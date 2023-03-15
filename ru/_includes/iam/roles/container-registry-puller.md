### container-registry.images.puller {#cr-images-puller}

В роль `{{ roles-cr-puller }}` входят следующие разрешения:
* [получение списка реестров](../../../container-registry/operations/registry/registry-list.md);
* [получение информации о реестре](../../../container-registry/operations/registry/registry-list.md#registry-get);
* [получение списка Docker-образов](../../../container-registry/operations/docker-image/docker-image-list.md);
* [получение информации о Docker-образе](../../../container-registry/operations/docker-image/docker-image-list.md#docker-image-get).

{% include [roles-restriction-only-parents](../roles-restriction-only-parents.md) %}