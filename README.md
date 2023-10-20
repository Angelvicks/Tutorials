# Tutorials
This is a repository for all the tutorials I learned at Mavou Consulting in order to not forget and come back to it later

# How to forward WSL port to Host port
Active powershell script withe command below
Get-ExecutionPolicy

## Forward port
See WSL IP (ifconfig in wsl distri) or :


wsl hostname -i
Run:

netsh interface portproxy add v4tov4 listenport=[PORT] listenaddress=0.0.0.0 connectport=[PORT] connectaddress=[WSL_IP]

To use the command, replace [PORT] with the desired port number, listenaddress is the IP address of your local machine and replace [WSL_IP] with the IP address of your Windows Subsystem for Linux (WSL) instance.
The command provided above is used in Windows to configure port forwarding using the netsh utility. This command specifically sets up a port forwarding rule to forward traffic from a specific listen port on the local machine to a connect port on a specified connect address which is the IP address of WSL instance.
Example:

[RUN] netsh interface portproxy add v4tov4 listenport=80 listenaddress=192.168.8.2 connectport=80 connectaddress=172.18.35.234

## Authorize port in the firewall
New-NetFirewallRule -DisplayName "WSL2 Port Bridge" -Direction Inbound -Action Allow -Protocol TCP -LocalPort [port list]
Example:

[RUN] New-NetFirewallRule -DisplayName "WSL2 Port Bridge" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 80,8080,443

# How to run the Gitlab-k8s repository code on microk8s in a linux interface (WSL instance using Ubuntu)
- Make sure you provide a strong password for the gitlab password configuration because there is a validation of the password in the interface
- Export the port of ingress from the virtual machine to be able to be accessible on the physical machine. Use the commands above, then you can access it through the browser with the port you provided.
- Install ingress as well with the following commands;
1- Pull ingress-nginx-controller v1.1.3
sudo ctr -n=k8s.io image pull k8s.gcr.io/ingress-nginx/controller:v1.1.3
sudo ctr -n=k8s.io image pull k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1

2- Apply installation yml
kubectl apply -f ingress-nginx-controller-V1_1_3-installer.yml

Verify installation
kubectl --namespace ingress-nginx get pod

The end for now
