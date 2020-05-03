A Dockerfile that installs and runs the latest Moodle 3.8 stable, with external MySQL Database, uitable ith Jwilder [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) [nginx-proxy] and buchdag [
docker-letsencrypt-nginx-proxy-companion ](https://github.com/nginx-proxy/docker-letsencrypt-nginx-proxy-companion).


Mysql : 8.0
PHP : 4.0

## Installation

```
git clone https://github.com/euchi/mmodle
cd moodle
docker build -t moodle .
```

## Usage

Set .env and .env.db with your data

docker-compose up -d
