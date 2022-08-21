# Simple Voting Application 🗳️
A great sample application for docker & docker compose demonstration!

Indeed, this is a distributed application running across multiple Docker containers.

## 🏗️ 0. Installation and Setup 

- Install Git:
```
yum install -y git
```

- Install Docker:
```
yum install -y docker
```

- Git clone this repository:
```
git clone https://github.com/TomHuynhSG/simple-voting-application.git
```

- Change current directory inside it:
```
cd simple-voting-application
```

## 🐳 1. Docker Step by Step 

- Will add more explanation later on!
```
cd vote/
cat Dockerfile 
service docker start
service docker status
docker build . -t voting-app
docker images
docker run -d --name=redis redis
docker run -d --name=db -e POSTGRES_PASSWORD=postgres postgres:9.4
docker build . -t worker-app
docker run -d --link redis:redis --link db:db worker-app
docker build . -t result-app
docker run -d -p 8081:80 --link db:db result-app
```

## 🐳 2. Docker Compose

- Install Docker compose:
```
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

- Check the version of docker compose:
```
docker-compose version
```

- Stop and remove all containers:
```
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
```

- Create a "docker-compose.yml" file as following:
```
version: "3"
services:
 redis:
   image: redis
 
 db:
  image: postgres:9.4
  environment:
   POSTGRES_PASSWORD: "postgres"
 
 vote:
   image: voting-app
   ports:
     - 8080:80
   links:
     - redis
 
 worker:
   image: worker-app
   links:
     - db
     - redis
 
 result:
   image: result-app
   ports:
     - 8081:80
   links:
     - db
```

- Run the docker compose file:
```
docker-compose up
```

- Check if the website is up and running via port 8080 (voting website) and 8081 (result website).


## ⚙️ Architecture 

![Architecture diagram](https://i.imgur.com/iVphAjP.png)

* A front-end web app in [Python](/vote) or [ASP.NET Core](/vote/dotnet) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) or [NATS](https://hub.docker.com/_/nats/) queue which collects new votes
* A [.NET Core](/worker/src/Worker), [Java](/worker/src/main) or [.NET Core 2.1](/worker/dotnet) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) or [TiDB](https://hub.docker.com/r/dockersamples/tidb/tags/) database backed by a Docker volume
* A [Node.js](/result) or [ASP.NET Core SignalR](/result/dotnet) webapp which shows the results of the voting in real time

## 💡 Reference 
- Modified and simplified based on the official Docker sample voting app (https://github.com/dockersamples/example-voting-app)

## 🏆 Author
- Huynh Nguyen Minh Thong (Tom Huynh) - tomhuynhsg@gmail.com
