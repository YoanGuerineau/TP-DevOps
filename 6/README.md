# Step 6: Expose the Minikube dashboard with an ingress controller
First, run ```minikube addons enable ingress```. You also need to run ```minikube dashboard``` once. When you get ```* Opening http://127.0.0.1:46829/api.....``` you can interrupt it with Ctrl+C.
Get the content of the folder in /tp/6 on the VM and run ```kubectl apply -f dashboard-ingress.yml```
Get the IP with ```kubectl get ingress --namespace=kubernetes-dashboard```. Use this ip to add lines to your hosts files on both the VM and your host machine. 
The line to add is: ```<found_ip> my-dashboard.local```
On Windows, the hosts file can be found under ```C:\Windows\System32\drivers\etc\hosts``` and is only editable with Administrator rights.