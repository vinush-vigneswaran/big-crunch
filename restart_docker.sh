eval $(ssh-agent -s)
ssh-add ~/.ssh/github_rsa
git pull

docker stop big-crunch_navidrome_1
docker rm big-crunch_navidrome_1
docker start big-crunch_navidrome_1
