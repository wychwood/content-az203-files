#!/bin/bash

docker build -t aspnet-webapp .
docker run -d -p 8080:80 --name myapp apsnet-webapp
