Release 1.2
============

* Use 'jq' to extract only the auths part which ECS appears to want

* remove quotes when writing ecs.config -- turns out it's *NOT* a shell file

* Add a container specificially for ECS logins

Release 1.1
============

* Change to more generic execution.

by default, will only handle files in /monitor/login.txt, but generally
will handle any file /monitor/BASE.txt by passing it to /root/BASE.sh, only
if the later exists


Release 1.0
============

* Initial version


