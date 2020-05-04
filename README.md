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

Before accessing your URL for installation, you need to patch the code.
You con use docker exec -ti scodoc bash 
The vim package is installed.
In : /var/www/html/admin/index.php you need to comment the folowing lines :
752         // prevent installation hijacking
753         if ($adminuser->lastip !== getremoteaddr()) {
754             print_error('installhijacked', 'admin');
755         }
You can uncomment or not after installation, they are only use for installing
Yes, it would be better to update moodle.
