# Simple Voting Application 🗳️

<p align="center">
    <img src="https://i.imgur.com/b9iYVtC.png" width=900>
<p>

<p align="center">"Five Docker Containers! Perfectly Balanced, As All Things Should Be!"</p>

---

A great sample application for docker & docker compose demonstration!

Indeed, this is a distributed application running across multiple Docker containers.

## 🏗️ 0. Installation and Setup 

- Make sure the port numbers below as allowed in your host machine for this application:
    - 8080
    - 8081

- Install Git:
```
yum install -y git
```

- Install Docker:
```
yum install -y docker
```

- Start Docker:
```
service docker start
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

- Change current directory to vote directory which contains the voting website:
```
cd vote
```

- Checkout the Dockerfile of that voting website:
```
cat Dockerfile 
```

- Build a Docker image of voting application:
```
docker build . -t voting-app
```

- Check if the new voting-app is there:
```
docker images
```

- Run a Docker container from the Redis image of DockerHub:
```
docker run -d --name=redis redis
```

- Run a Docker container from the voting app image ➜ The voting website is now live via port 8080:
```
docker run -d -p 8080:80 --link redis:redis voting-app
```


- Run a Docker container from the Postgres image of DockerHub:
```
docker run -d --name=db -e POSTGRES_PASSWORD=postgres postgres:9.4
```

- Change current directory to worker-app directory:
```
cd ../worker
```

- Build a Docker image of worker app:
```
docker build . -t worker-app
```

- Run a Docker container from the worker app image:
```
docker run -d --link redis:redis --link db:db worker-app
```

- Change current directory to result directory which contains the result website:
```
cd ../result
```

- Build a Docker image of result app:
```
docker build . -t result-app
```

- Run a Docker container from the result app image ➜ The result website is now live via port 8081:
```
docker run -d -p 8081:80 --link db:db result-app
```

## 🐳 2. Docker Compose

Instead of running these above Docker commands one by one. We can use docker compose which allow us to define and run multi-container Docker applications at once.


- First, let's stop and remove all containers so we can start from scratch:
```
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
```

- Install Docker compose:
```
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

- Check the version of docker compose:
```
docker-compose version
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

## 🌟 Screenshots

- Voting page:
![Voting page](https://i.imgur.com/MHt7PpR.png)

- Result page:
![Result page](https://i.imgur.com/T0P2mBa.png)


## ⚙️ Architecture 

![Architecture diagram](https://i.imgur.com/iVphAjP.png)

* A front-end web app (Flask) in [Python](/vote) which lets you vote between two options.
* A [Redis](https://hub.docker.com/_/redis/) queue which collects new votes.
* A [.NET Core 3.1](/worker/src/Worker), [Java](/worker/src/main) worker which consumes votes and stores them in Postgres databased container.
* A [Postgres](https://hub.docker.com/_/postgres/) database.
* A [Node.js](/result) webapp which shows the results of the voting in real time.

## 💡 Reference 
- Modified and simplified based on the official Docker sample voting app (https://github.com/dockersamples/example-voting-app)

## 🏆 Author
- Huynh Nguyen Minh Thong (Tom Huynh) - tomhuynhsg@gmail.com
