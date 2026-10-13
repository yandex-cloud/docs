# {{ container-registry-full-name }} concepts

{% include [sunset](../../_includes/container-registry/sunset.md) %}

{{ container-registry-name }} is a service for storing and distributing Docker images.

{{ container-registry-name }} offers a reliable storage solution independent of external locks. Docker images in {{ container-registry-name }} are stored in the same {{ yandex-cloud }} [data centers](../../overview/concepts/geo-scope.md) as the rest of the cloud infrastructure, ensuring high-speed image processing and zero external traffic costs.

To ensure data security, {{ container-registry-name }} transfers Docker images over [HTTPS](https://ru.wikipedia.org/wiki/HTTPS) using SSL certificates managed from {{ yandex-cloud }}. Additionally, {{ container-registry-name }} comes with a native [vulnerability scanner](./vulnerability-scanner.md) that enables you to scan Docker images both when they are pushed to the registry and later on a schedule, as well as flexibly manage scan results.

It allows you to manage the following objects:

* [Docker image](docker-image.md)
* [Docker volume](docker-volume.md)
* [Registry](registry.md)
* [Repository](repository.md)

To work with {{ container-registry-name }}, internet access is required.

You can provide internet access in the following ways:

* Assigning a [public IP address](../../vpc/concepts/address.md#public-addresses) to a VM.
* [By configuring a VM as a NAT instance](../../tutorials/routing/nat-instance/index.md).
* [By setting up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{{ container-registry-full-name }} supports [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/), which means you can run the commands available in the Docker CLI.