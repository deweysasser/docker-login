Docker-Login
============

Automatically maintain logins to private docker repositories across a
cluster of docker machines.

Used for giving e.g. a cluster of ECS docker hosts logins to private
docker repositories.

On startup, or whenever any files change in the monitored directory,
this will execute "docker login" once for each non-blank, non-comment
line in the file.

'#' is the comment character.

Usage
-----

    docker run -d -v $(pwd)/monitor:/monitor:ro -v /var/run/docker.sock:/var/run/docker.sock deweysasser/login-docker
    echo "-u USER -p PASS REPO" > monitor/login.txt





