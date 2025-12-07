sudo apt update && \
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y && \
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg && \
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list && \
sudo apt update && \
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y && \
sudo groupadd docker 2>/dev/null || true && \
sudo usermod -aG docker $USER && \
sudo modprobe overlay 2>/dev/null || true && \
sudo modprobe br_netfilter 2>/dev/null || true && \
sudo systemctl restart docker && \
sudo systemctl enable docker

docker volume create portainer_data  && \
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
