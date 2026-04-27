# LAMPP
## Struktur Lampp
````
+database
+ docker
  |- .env
  |- docker-compose.yaml
  |- Dockerfile
  |- php.ini
+web
````
## Install
````
sudo docker-compose -p lampp up -d
````
## Un-Install
````
sudo docker-compose -p lampp down -v --remove-orphans
````
## Runnning
````
http://ip_address:port-host
http://ip_address:port_db
````


