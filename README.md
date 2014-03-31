squidprank
==========

Vagrant config for running pranks with squid proxy

To run, you'll need:

* Virtualbox (https://www.virtualbox.org/)
* Vagrant (http://www.vagrantup.com/)

Having installed both, run

"vagrant up"

from the root folder, to start up your squid pranking host. If you have multilpe ethernet adapters on your machine, you'll be prompted for which one you want to use for the bridged (eth1) interface. This is the interface you'll be spoofing / pranking on.

Once up, run "vagrant ssh" to access the VM, then "sudo /vagrant/start.sh" to start spoofing if you don't want to make any changes
