# Docker volume in {{ container-registry-name }}

A _Docker volume_ is a tool for the permanent storage of information on a [VM](../../compute/concepts/vm.md) instance. The data in the volume is stored independently of containers. If you delete a container, both its volumes and data will persist. Deleting a volume is a separate operation.

## Volumes and Docker Compose {#volume-compose}

You can use [Docker Compose](../../cos/concepts/coi-specifications.md#compose-spec) to create and manage multiple volumes. When `docker-compose up` is called for the first time, the defined volumes will be created. These volumes will be used in subsequent calls.

If you run a container that creates a new volume, the content from the mount folder will be copied to the volume. Containers that have mounted the volume will gain access to the volume data.