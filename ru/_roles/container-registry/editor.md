Роль `container-registry.editor` позволяет управлять реестрами, Docker-образами, репозиториями и их настройками.

Пользователи с этой ролью могут:
* просматривать список [реестров](../../container-registry/concepts/registry.md) и информацию о них, а также создавать, изменять и удалять реестры;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к реестрам, а также о [настройках политик доступа](../../container-registry/operations/registry/registry-access.md) для IP-адресов;
* просматривать информацию о настройках [сканера уязвимостей](../../container-registry/concepts/vulnerability-scanner.md), а также создавать, изменять и удалять правила сканирования;
* просматривать список [Docker-образов](../../container-registry/concepts/docker-image.md) в реестре и информацию о них, а также создавать, скачивать, изменять и удалять Docker-образы;
* [запускать](../../container-registry/operations/scanning-docker-image.md#manual) и отменять сканирование Docker-образов на уязвимости, а также просматривать историю сканирования и информацию о его результатах;
* просматривать информацию о [репозиториях](../../container-registry/concepts/repository.md) и назначенных правах доступа к ним, а также создавать и удалять репозитории;
* просматривать список [политик](../../container-registry/concepts/lifecycle-policy.md) автоматического удаления Docker-образов и информацию о таких политиках, а также создавать, изменять и удалять такие политики;
* запускать [тестирование](../../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) политик автоматического удаления Docker-образов, просматривать список результатов тестирования и информацию о таких результатах;
* просматривать информацию о [квотах](../../container-registry/concepts/limits.md#container-registry-quotas) сервиса Container Registry;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `container-registry.viewer`.