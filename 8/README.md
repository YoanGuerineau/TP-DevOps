# Step 8: Install Gitlab and setup a gitlab-runner (using a GitLab Operator)
First, install the "cert-manager" and the "metrics server" with ```kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml ``` and ```kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml```
Deploy the GitLab Operator using the following commands:
```
GL_OPERATOR_VERSION=0.5.1 # Check for newer versions here https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/-/releases
PLATFORM=kubernetes # or "openshift"
kubectl create namespace gitlab-system
kubectl apply -f https://gitlab.com/api/v4/projects/18899486/packages/generic/gitlab-operator/${GL_OPERATOR_VERSION}/gitlab-operator-${PLATFORM}-${GL_OPERATOR_VERSION}.yaml
```
Add ```127.0.0.1 my-gitlab.local``` to your hosts file on you host machine and ```10.0.2.15 my-gitlab.local``` on the VM.
Copy all the folder content under /tp/8 on the VM. Run ```kubectl -n gitlab-system apply -f my-gitlab.yml```
You can check in the logs if there is any issue using ```kubectl -n gitlab-system logs deployment/gitlab-controller-manager -c manager -f```.
You can also check what is the status of the GitLab resources with ```kubectl -n gitlab-system get gitlab```.
To remove the installed GitLab, run: 
```
kubectl -n gitlab-system delete -f my-gitlab.yml
kubectl delete -f https://gitlab.com/api/v4/projects/18899486/packages/generic/gitlab-operator/${GL_OPERATOR_VERSION}/gitlab-operator-${PLATFORM}-${GL_OPERATOR_VERSION}.yaml
kubectl delete namespaces gitlab-system
... if stuck ...
kubectl proxy &
kubectl get namespace gitlab-system -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/gitlab-system/finalize
```

All Operator steps can be found here: https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/-/blob/master/doc/installation.md


## Another way to go (manually) (recommended)
Took from https://medium.com/@SergeyNuzhdin/how-to-easily-deploy-gitlab-on-kubernetes-75f5868cea78 / https://github.com/lwolf/kubernetes-gitlab.git

Simply get all the folder content under /tp/8 and run :
```
cd /tp/8/kubernetes-gitlab
kubectl create -f gitlab-ns.yml
kubectl create -f gitlab/redis-svc.yml
kubectl create -f gitlab/redis-deployment.yml
kubectl create -f gitlab/postgresql-svc.yml
kubectl create -f gitlab/postgresql-deployment.yml
kubectl create -f gitlab/gitlab-svc.yml
kubectl create -f gitlab/gitlab-svc-nodeport.yml
kubectl create -f gitlab/gitlab-deployment.yml
```
You can inspect the service using: ```kubectl describe svc gitlab-nodeport --namespace=gitlab```
Ingress controller deployment:
```
kubectl create -f ingress/default-backend-svc.yml
kubectl create -f ingress/default-backend-deployment.yml
kubectl create -f ingress/nginx-settings-configmap.yml
kubectl create -f ingress/configmap.yml
kubectl create -f ingress/nginx-ingress-lb.yml
kubectl create -f ingress/gitlab-ingress.yml
```
Inspect the service and note the NodePort on this line: ```NodePort:                 http  31514/TCP```
From here, you should be able to see the GitLab web interface on http://my-gitlab.local:31514 (don't forget to add the port forwarding on the VM).
In order to log-in as admin use: root/GitlabRootPassword
Next step is to deploy the GitLab runner:
First login as root on GitLab and go to: http://http://my-gitlab.local/admin/runners and note the registration token.
Also run ```kubectl get all -n gitlab``` and note the LoadBalancer IP address: ```service/gitlab                 LoadBalancer   10.97.27.70      <pending>     80:32655/TCP,1022:32357/TCP   3h9m```
Run the following commands:
```
kubectl run -it runner-registrator --image=gitlab/gitlab-runner:v1.5.2 --restart=Never -- register
```
Some help for the prompts: 
The gitlab coordinator has to be "http://<LoadBalancerIP>/ci". The token must be the registration token you took from GitLab. The description isn't so important, you can type "gitlab-docker-runner". You can skip the tags (simply press enter). The executor is "docker" and the image is "python:3.5".
You need to complete the info in gitlab-runner/gitlab-runner-docker-configmap.yml (replace token with the one you can find on GitLab Runners page when you click on your new runner "http://my-gitlab.local/admin/runners/1" and the url with the gitlab coordinator url "http://<LoadBalancer>/ci).
You can finally start the gitlab-runner using:
```
kubectl create -f gitlab-runner/gitlab-runner-docker-configmap.yml
kubectl create -f gitlab-runner/gitlab-runner-docker-deployment.yml
```
