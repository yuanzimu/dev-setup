# -*- mode: ruby -*-
# vi: set ft=ruby :

options = {
  :ip => "10.10.10.100",
  :scriptDir => "setup"
}

Vagrant.configure("2") do |config|

  # Use [berkshelf plugin](https://github.com/RiotGames/vagrant-berkshelf) 
  # to use [berkshelf](http://berkshelf.com/) to manage cookbooks
  # To install plugin: `vagrant plugin install vagrant-berkshelf`
  config.berkshelf.enabled = true

  # Use [omnibus plugin](https://github.com/schisamo/vagrant-omnibus) 
  # to use the omnibus installer to install [chef](http://www.opscode.com/chef/)
  # Install plugin: `vagrant plugin install vagrant-omnibus`
  config.omnibus.chef_version = "11.4.4"

  # VM name
  config.vm.hostname = "stucco"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise-server-cloudimg-amd64-vagrant-disk1"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # Ubuntu cloud images, including virtual box images for vagrant, can
  # be found here: http://cloud-images.ubuntu.com/
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  # config.vm.network :forwarded_port, guest: 5672, host: 5672
  # No port forwarding, use private network IP to connect to VM

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network :public_network

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "#{options[:ip]}"

  # Mount the parent directory under /stucco in the VM
  # config.vm.synced_folder "../", "/stucco"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  
  # Use VBoxManage to customize the VM. Change memory and limit VM's CPU.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end
  

  # Update package list, but do not do upgrade. Upgrades should
  # be done manually, if required (`sudo apt-get upgrade`)
  config.vm.provision :shell, :inline => "echo 'Running apt-get update' ; sudo apt-get update"

  # Recommended for riak
  config.vm.provision :shell, :inline => "echo 'Increasing ulimit for Riak' ; ulimit -n 10240"

  # Install required packages
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      # turn on ntp
      "ntp" => {
        "servers" => ["0.us.pool.ntp.org", "1.us.pool.ntp.org", "2.us.pool.ntp.org"]
      },
      # use Oracle Java JDK instead of default OpenJDK
      "java" => {
        "install_flavor" => 'oracle',
        "jdk_version" => 7,
        "oracle" => {
          "accept_oracle_download_terms" => true
        }
      },
      # set up riak to use the configured IP address
      "riak" => {
        "args" => {
          "-name" => "riak@#{options[:ip]}"
        },
        "config" => {
          "riak_core" => {
            "http" => {
              "__string_#{options[:ip]}" => 8098
            }
          },
          "riak_api" => {
            "pb_ip" => "__string_#{options[:ip]}"
          }
        }
      },
      # set the cluster name
      "elasticsearch" => {
        "cluster_name" => "stucco-es"
      }
    }

    chef.add_recipe "ntp"
    chef.add_recipe "git"
    chef.add_recipe "chef-sbt"
    chef.add_recipe "python"
    chef.add_recipe "java"
    chef.add_recipe "zookeeper"
    chef.add_recipe "rabbitmq"
    chef.add_recipe "riak"
    chef.add_recipe "elasticsearch"
  end

  # Install [Storm](http://storm-project.net/), passing version as argument
  config.vm.provision :shell do |shell|
    shell.path = "#{options[:scriptDir]}/storm.sh"
    shell.args = "0.8.2"
  end

  # Install [Logstash](http://logstash.net), passing version as argument
  config.vm.provision :shell do |shell|
    shell.path = "#{options[:scriptDir]}/logstash.sh"
    shell.args = "1.1.13"
  end

  # Install [Neo4j](http://www.neo4j.org/), passing version as argument
  config.vm.provision :shell do |shell|
    shell.path = "#{options[:scriptDir]}/neo4j.sh"
    shell.args = "1.9.2"
  end

  # Set up Stucco
  config.vm.provision :shell, :path => "#{options[:scriptDir]}/stucco.sh"

end