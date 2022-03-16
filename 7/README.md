# Step 7: Migrate the Node.js Apps to K8s
Start the Kubernetes container running ```minikube start```
Copy all the folder content to /tp/7 on the VM.
You might also need to get the files from step 2 and 3 into /tp/2 /tp/3.
Then mount those directories to your Minikube with ```minikube start --mount-string="/tp/2:/tp/2" --mount``` and ```minikube start --mount-string="/tp/3:/tp/3" --mount```.
Run ```kubectl create -f my-app-deployment.yml```.
Check that everything is coming up using ```kubectl get deploy,pod```.
Run ```kubectl apply -f my-app-service.yml```.
Check that everything is coming up using ```kubectl get svc```.
Run ```kubectl create -f my-app-ingress.yml```.
Check that everything is coming up using ```kubectl get ingress```.
