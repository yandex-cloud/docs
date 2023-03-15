### container-registry.images.pusher {#cr-images-pusher}

В роль `{{ roles-cr-pusher }}` входят следующие разрешения:
* [получение списка реестров](../../../container-registry/operations/registry/registry-list.md);
* [получение информации о реестре](../../../container-registry/operations/registry/registry-list.md#registry-get);
* [получение списка Docker-образов](../../../container-registry/operations/docker-image/docker-image-list.md);
* [получение информации о Docker-образе](../../../container-registry/operations/docker-image/docker-image-list.md#docker-image-get);
* [создание Docker-образа](../../../container-registry/operations/docker-image/docker-image-create.md);
* изменение Docker-образа;
* [удаление Docker-образа](../../../container-registry/operations/docker-image/docker-image-delete.md).

{% include [roles-restriction-only-parents](../roles-restriction-only-parents.md) %}