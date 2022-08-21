# Simple Voting Application 🗳️
A great sample application for docker & docker compose demonstration!

Indeed, this is a distributed application running across multiple Docker containers.

## 🏗️ Installation and Setup 

- To be updated...

## 🐳 Docker Step by Step 

- To be updated...

## 🐳 Docker Compose

- To be updated...

## ⚙️ Architecture 

![Architecture diagram](https://i.imgur.com/iVphAjP.png)

* A front-end web app in [Python](/vote) or [ASP.NET Core](/vote/dotnet) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) or [NATS](https://hub.docker.com/_/nats/) queue which collects new votes
* A [.NET Core](/worker/src/Worker), [Java](/worker/src/main) or [.NET Core 2.1](/worker/dotnet) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) or [TiDB](https://hub.docker.com/r/dockersamples/tidb/tags/) database backed by a Docker volume
* A [Node.js](/result) or [ASP.NET Core SignalR](/result/dotnet) webapp which shows the results of the voting in real time

## 💡 Reference 
- Modified and simplified based on the official Docker sample voting app (https://github.com/dockersamples/example-voting-app)
