# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"

  config.ssh.insert_key = false
  # forward ssh agent to easily ssh into the different machines
  config.ssh.forward_agent = true
  check_guest_additions = false

  config.vm.provision "shell", name: "aide_verify", path: "scripts/aide_verify_acl.sh"
  config.vm.provision "shell", name: "aide_extended_attributes", path: "scripts/aide_verify_extended_attributes.sh"
  config.vm.provision "shell", name: "post_aide", path: "scripts/post_aide_scan_details.sh"
  config.vm.provision "shell", name: "disable_burst", path: "scripts/disable_burst_action.sh"
  config.vm.provision "shell", name: "disable_reboot", path: "scripts/disable_reboot_action.sh"
  config.vm.provision "shell", name: "min_age", path: "scripts/set_password_min_age.sh"
  config.vm.provision "ansible" do |ansible|
	ansible.verbose = "v"
	ansible.playbook = "almalinux9-playbook-stig.yml"
	ansible.config_file = "ansible.cfg"
  end

  config.vm.provision "shell", name: "log_usbguard", path: "scripts/log_usbguard.sh"
  config.vm.provision "ansible" do |ansible|
	ansible.verbose = "v"
	ansible.playbook = "other.yml"
	ansible.config_file = "ansible.cfg"
  end

  config.vm.provision :reload
  config.vm.provision "shell", name: "chmod", inline: "sudo dnf install scap-security-guide openscap-utils openscap -y"
  config.vm.provision "shell", name: "openscap", inline: "sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_stig --results ./ssg-results.xml --report ./ssg-results.html /usr/share/xml/scap/ssg/content/ssg-almalinux9-ds.xml || true"
  config.vm.provision "shell", name: "chmod", inline: "sudo chmod 777 ssg-results.*"
end
