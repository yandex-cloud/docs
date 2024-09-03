Роль `container-registry.images.scanner` позволяет сканировать Docker-образы на наличие уязвимостей, а также просматривать информацию о реестрах, Docker-образах и репозиториях, а также об облаке, каталоге и квотах сервиса.

Пользователи с этой ролью могут:
* просматривать список [Docker-образов](../../../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также скачивать Docker-образы из реестра;
* [запускать](../../../container-registry/operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать список [реестров](../../../container-registry/concepts/registry.md) и информацию о них и о назначенных [правах доступа](../../../iam/concepts/access-control/index.md) к ним, а также о [настройках политик доступа](../../../container-registry/operations/registry/registry-access.md) для IP-адресов и настройках [сканера уязвимостей](../../../container-registry/concepts/vulnerability-scanner.md);
* просматривать информацию о [репозиториях](../../../container-registry/concepts/repository.md) и назначенных правах доступа к ним;
* просматривать список [политик](../../../container-registry/concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках;
* просматривать список результатов [тестирования](../../../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов и информацию о таких результатах;
* просматривать информацию о [квотах](../../../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.