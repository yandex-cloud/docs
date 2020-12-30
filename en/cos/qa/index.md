# Questions and answers about {{ cos-name }}

#### How do I perform auto updates based on immutable tags? {#auto-update}

Updating a container won't work with tags that persist from version to version. We recommend using a new tag for each [Docker image](../../container-registry/concepts/docker-image.md).

Disadvantages of using tags that persist from version to version:

* When a problem occurs, it's difficult to find its source if several identical VMs have the same tag but different code.
* A cluster of multiple VMs can be heterogeneous, for example, if one VM restarts and updates a Docker image.
* It's difficult to distinguish between Docker image versions on a VM.