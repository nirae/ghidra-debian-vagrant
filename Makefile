export:
	vagrant package --vagrantfile init/Vagrantfile

vagrant-add:
	vagrant box add nirae/ghidra_debian package.box

vagrant-remove:
	vagrant box remove nirae/ghidra_debian --all
