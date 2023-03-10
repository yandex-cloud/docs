# {{ container-registry-full-name }} concepts

{{ container-registry-name }} is a service for storing and distributing Docker images.

It allows you to manage the following objects:
* [Docker image](docker-image.md)
* [Docker volume](docker-volume.md)
* [Registry](registry.md)
* [Repositories](repository.md)

To work with {{ container-registry-name }}, internet access is required.

Internet access can be provided in the following ways:
* Assigning a VM a [public IP address](../../vpc/concepts/address.md#public-addresses).
* [Configuring a VM as a NAT instance](../../tutorials/routing/nat-instance.md).
* [Enabling egress NAT](../../vpc/operations/enable-nat.md).

The service supports [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/), so you can run commands available in the Docker CLI.