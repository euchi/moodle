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

When running locally or for a test deployment, use of localhost is acceptable.

To spawn a new instance of Moodle:

```
docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql
docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://localhost:8080 -p 8080:80 jhardison/moodle
```

You can visit the following URL in a browser to get started:

```
http://localhost:8080 
```

### Production Deployment

For a production deployment of moodle, use of a FQDN is advised. This FQDN should be created in DNS for resolution to your host. For example, if your internal DNS is company.com, you could leverage moodle.company.com and have that record resolve to the host running your moodle container. The moodle url would then be, `MOODLE_URL=http://moodle.company.com`
In the following steps, replace MOODLE_URL with your appropriate FQDN.

* Deploy With Docker
```
docker run -d --name DB -p 3306:3306 -e MYSQL_DATABASE=moodle -e MYSQL_ROOT_PASSWORD=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodle mysql
docker run -d -P --name moodle --link DB:DB -e MOODLE_URL=http://moodle.company.com -p 80:80 jhardison/moodle
```

* Deploy with Docker Compose

Pull the latest source from GitHub:
```
git clone https://github.com/jmhardison/docker-moodle.git
```

Update the `moodle_variables.env` file with your information. Please note that we are using v3 compose files, as a stop gap link env variable are manually filled since v3 no longer automatically fills those for use.

Once the environment file is filled in you may bring up the service with:
`docker-compose up -d`



## Caveats
The following aren't handled, considered, or need work: 
* moodle cronjob (should be called from cron container)
* log handling (stdout?)
* email (does it even send?)

## Credits

This is a fork of [Jon Auer's](https://github.com/jda/docker-moodle) Dockerfile.
This is a reductionist take on [sergiogomez](https://github.com/sergiogomez/)'s docker-moodle Dockerfile.

