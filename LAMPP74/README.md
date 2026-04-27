# LAMPP
## Struktur Lampp
````
+ docker
  |- .env
  |- docker-compose.yaml
  |- Dockerfile
  |- php.ini
+web
+database
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


