# Step 5: Create a Minikube VM using Terraform
In order to create the VM, you need to run ```terraform apply```. You can replace the image value with the path to an image on your machine or with the url of another image.
You can search for images here: https://app.vagrantup.com/boxes/search

A few configuration steps are required. You should be able to see the machine on VirtualBox GUI. Default login/password of the given vagrant image is **vagrant/vagrant**. Using this you should be able to log on the VM. Check the ip address using ```ip a```.
If the interface is not up, you can run ```ip link set <interface_name> up```.
In case no IP address was set, you can run ```ifconfig <interface_name> <wanted_ip_address>/<netmask>```.
Best is to configure the netplan manually with something like:
```
network:
  ethernets:
    enp0s17:
      dhcp4: true
      dhcp6: false
      optional: true
      nameservers:
        addresses: [4.2.2.1, 4.2.2.2, 208.67.220.220]
  version: 2
```
And then run ```netplan apply```
You can check if everything is alright by connecting via ssh to the VM and pinging "google.com".
To check if minikube is doing alright, run ```kubectl version```, ```kubectl get ns``` and ```kubectl get all -n kube-system```
