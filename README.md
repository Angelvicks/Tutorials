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
Example:

[RUN] netsh interface portproxy add v4tov4 listenport=80 listenaddress=0.0.0.0 connectport=80 connectaddress=172.27.123.178

# Authorize port in the firewall
New-NetFirewallRule -DisplayName "WSL2 Port Bridge" -Direction Inbound -Action Allow -Protocol TCP -LocalPort [port list]
Example:

[RUN] New-NetFirewallRule -DisplayName "WSL2 Port Bridge" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 80,8080,443
