#!/bin/bash
# clear last build
[[ `docker ps -a | grep -w api_vue | wc -l` -ne 0 ]] && docker rm -f api_vue
# if clean last build, open it
[[ `docker images | grep -w api_vue | wc -l` -ne 0 ]] && docker rmi api_vue
npm install --registry=https://registry.npm.taobao.org
npm run build
docker build . -t api_vue
docker run -d --restart always --network ops_web --name api_vue -p 8888:8000 api_vue
