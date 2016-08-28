# -*- mode: ruby -*-
# vi: set ft=ruby :

CONFIG = File.join(File.dirname(__FILE__), "config.rb")
raise "required file 'config.rb' not found." unless File.exist? CONFIG
require CONFIG

module Vagrants
  def port_forwarding(vm, ports)
    ports.each do |(guest, host)|
      vm.network "forwarded_port", guest: guest.to_s, host: host, auto_correct: true
    end
  end

  def windows?
    RUBY_PLATFORM.downcase =~ /mswin(?!ce)|mingw|cygwin|bccwin/
  end

  def ansible_playbook(vm, playbook)
    if windows?
      vm.synced_folder $ansible,
                       "/ansible",
                       :mount_options => ["dmode=775", "fmode=664"]
      vm.provision :shell, :privileged => false, :inline => <<-EOT
        which ansible >/dev/null 2>&1 || {
          sudo yum install -y epel-release
          sudo yum --enablerepo=epel install -y ansible 
        }
        ansible-playbook -i /ansible/#{$inventory} -c local /ansible/#{playbook}
      EOT
    else
      vm.provision :ansible do |ansible|
        ansible.limit = "all"
        ansible.inventory_path = "#{$ansible}/#{$inventory}"
        ansible.playbook = "#{$ansible}/#{playbook}"
      end
    end
  end
end

