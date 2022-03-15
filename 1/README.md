# First Step: Create a VirtualBox VM using Terraform + Install docker-engine using Ansible
In order to create the VM, you need to run ```terraform apply```. You can replace the image value with the path to an image on your machine or with the url of another image.
You can search for images here: https://app.vagrantup.com/boxes/search

The second step is to run the ansible playbook on the VM from the host. A few configuration steps are required. You should be able to see the machine on VirtualBox GUI. Default login/password of the given vagrant image is **vagrant/vagrant**. Usign this you should be able to log on the VM. Check the ip address using ```ip a```.
Add a port forwarding rule using VirtualBox GUI from 127.0.0.1 on port 22 to the machine IP address on port 22. Once this is done, you should be able to ssh from the host to the VM using ```ssh vagrant@127.0.0.1```
If everything is working so far, you should be able to run ```ansible-playbook -k -i ./inventory.ini -u vagrant ./docker-engine.yml```

If no error occured, you can ssh on the VM and run sudo docker ps to check if docker was installed properly.
