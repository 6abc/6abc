# wget https://raw.githubusercontent.com/6abc/6abc/main/Script_After_Install.sh
# Works only if login as root
# chmod +x Script_After_Install.sh
# ./Script_After_Install.sh
sudo apt update
sudo apt upgrade -y
timedatectl set-timezone Asia/Kolkata
sudo apt install curl -y
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo -ne '\n' | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt upgrade -y
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
docker volume create portainer_data
docker run -d -p 2000:8000 -p 2443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce
docker run --detach \
    --name watchtower \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
docker run --name dozzle -d --volume=/var/run/docker.sock:/var/run/docker.sock -p 9000:8080 amir20/dozzle:latest
echo -e 'Visit : https://<IP ADD>:2443/ for Portainer(Docker UI Manager)\nExample https://10.0.0.8:2443/\nYour IP Address:\n'
ip add | grep "inet " | awk -F'[/ ]+' '{ print $3 }'
