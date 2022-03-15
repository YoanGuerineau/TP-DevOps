# Step 3: Run a Node.js App using docker-compose
You need to add a port forwarding rule on VirtualBox from 127.0.0.1 port 8081 to the VM IP address on port 8081.
You might need to run ```apt install docker-compose``` as a first step.
Running ```docker ps```check if any my-app-X is running. If so, run ```docker stop my-app-X && docker rm my-app-X``` for each running cluster.
Copy all the folder content to /tp/3 on the VM. You also need to have all the content of the previous step on /tp/2. You should be able to run ```docker-compose up -d```
You can check if the two apps are up using ```docker ps```
To check that everything is working properly, check that you get the hello world pages on http://127.0.0.1:8080 and http://127.0.0.1:8081
