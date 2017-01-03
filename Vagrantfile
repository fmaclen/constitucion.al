##VMWARE_BOX = "puppetlabs/ubuntu-14.04-64-nocm"
VIRTUALBOX_BOX = "ubuntu/trusty64"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.55.130"
  config.vm.synced_folder ".", "/vagrant", owner: "vagrant", :mount_options => ["dmode=777"]

  config.vm.provision "shell", inline: <<-SCRIPT
    # Define user settings for rbenv installation.
    # Current default values (shown here) are normally fine.
    export USER_NAME=vagrant
    export USER_HOME=/home/$USER_NAME
    export DEFAULT_RUBY='2.2.2'

    curl -fsS https://raw.githubusercontent.com/forgecrafted/vagrant-provision-ruby/master/script | bash
  SCRIPT
end
