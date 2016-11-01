# shell-utils
This repository contains commonly used shell scripts.

## docker-clean.sh

This script cleans docker environment. The following steps are executed:

* Delete all exited containers
* Remove all untagged images
* Remove all unbound volumes

Usage:

```
docker-clean.sh [ -h | --help | OPTIONS ]

curl https://raw.githubusercontent.com/cokeSchlumpf/shell-utils/master/docker-clean.sh | bash -s --
```
