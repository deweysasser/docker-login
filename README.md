Docker-Login
============

Automatically maintain logins to private docker repositories across a
cluster of docker machines.

Used for giving e.g. a cluster of ECS docker hosts logins to private
docker repositories.

Reads file "login.txt" in (container path) '/monitor' and on startup
or whenever that file changes, executes "docker login" on each
non-blank, non-comment line in that file.

'#' is the comment character.

Usage
-----

    docker run -d -v $(pwd)/monitor:/monitor:ro -v /var/run/docker.sock:/var/run/docker.sock -v ~/.docker:/root/.docker deweysasser/docker-login
    echo "-u USER -p PASS REPO" > monitor/login.txt



ECS Login
---------

The image 'docker-ecs-login' is used for logging in to ECS docker repos, and must be run something like this:


    docker run -d -v $(pwd)/monitor:/monitor:ro -v /etc/ecs:/etc/ecs -v /var/run/docker.sock:/var/run/docker.sock deweysasser/docker-ecs-login
    echo "-u USER -p PASS REPO" > monitor/login.txt
    # catch modifications by shell append (">>") or by human edit with e.g. vi
    inotifywait -m -e MODIFY  /etc/ecs | while read dir op arg; do if [ $arg == "ecs.config" ] ; then    stop ecs; start ecs; fi; done


Of course, you must have inotifywatch, which you can get from the EPEL repo like this:

```
curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm > /tmp/epel.rpm
rpm -i /tmp/epel.rpm
yum --enablerepo=epel install -y inotify-tools
```



