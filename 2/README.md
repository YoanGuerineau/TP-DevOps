# Step 2: Run a Node.js App using a Dockerfile
You need to add a port forwarding rule on VirtualBox from 127.0.0.1 port 8080 to the VM IP address on port 8080.
On the VM you can create the /tp folder with those commands: ```sudo mkdir /tp && sudo chown -R vagrant:vagrant /tp```
Using windows, you should then be able to scp the whole folder using: ```scp -r .\2\ vagrant@127.0.0.1:/tp/```
Copy this folder content to /tp/2 on the VM. As root, reach the folder where the Dockerfile is stored and run ```docker build -t my-app .```
Once the image is built, run ```docker run -d --rm -p 8080:8080 --name my-app-1 my-app```
You can check if the container is running with ```docker ps```
If it is running, you should see the "Hello World" page at http://127.0.0.1:8080/
