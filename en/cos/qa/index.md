# Questions and answers about {{ cos-name }}

#### How do I perform auto updates based on immutable tags? {#auto-update}

Updating a container will not work with tags that persist from version to version. We recommend using a new tag for each [Docker image](../../container-registry/concepts/docker-image.md).

There is a number of disadvantages of using tags that persist from version to version:
* When a problem occurs, it is difficult to find its source if multiple identical VMs have the same tag but different code.
* A cluster of multiple VMs can be heterogeneous, for example, if one VM restarts and updates a Docker image.
* It is difficult to distinguish between Docker image versions on a VM.

#### I can't create a container. Why? {#create-container}

{% note warning %}

The Docker Compose specification does not support `build` instructions: the image must be built in advance. In addition, the Docker Compose specification should not contain any links to other files: they are not delivered to the VM.

{% endnote %}

- Check that the image name is correct.
- Make sure the service account linked to the VM has the `container-registry.images.puller` rights to the desired image.
- Check that the VM has internet access.
- You can also view logs by running the `sudo journalctl -u yc-container-daemon` command on the VM.

#### How can I close a port for public access and leave it accessible within the network? {#port}

- If you use a standard COI (one [container](../tutorials/vm-create.md) configured by parameters), all ports that are open in the Docker container will also be open on the host.
- If you need other network settings for containers, you can configure them using a COI with the [Docker Compose specification](../tutorials/docker-compose.md#docker-compose).
- To make your container port open on the host but disable access to it from the internet, you can use [security groups](../../vpc/concepts/security-groups.md).

   {% include [security-groups-note-vm](../../_includes/vpc/security-groups-note-vm.md) %}

