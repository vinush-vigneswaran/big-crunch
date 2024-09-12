eval $(ssh-agent -s)
ssh-add ~/.ssh/github_rsa
git pull

docker stop big-crunch_navidrome_1
docker rm big-crunch_navidrome_1

docker stop $(docker ps -aq)
docker container prune -f

docker-compose up -d
docker ps -a
