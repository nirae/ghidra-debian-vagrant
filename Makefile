export:
	vagrant package --vagrantfile init/Vagrantfile

vagrant-add:
	vagrant box add nirae/ghidra package.box

vagrant-remove:
	vagrant box remove nirae/ghidra --all
