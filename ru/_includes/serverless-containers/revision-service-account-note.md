Если [реестр](../../container-registry/concepts/registry.md) или [репозиторий](../../container-registry/concepts/repository.md) с Docker-образом не являются [публичными](../../container-registry/qa/index.md#public-registry), необходимо указать в настройках ревизии [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого [есть права](../../iam/operations/sa/assign-role-for-sa.md) на скачивание Docker-образа. Например, роль `container-registry.images.puller` на каталог или реестр, в которых находится Docker-образ.

Если в настройках ревизии указан сервисный аккаунт, у пользователя или сервисного аккаунта, от имени которого создается ревизия, должна быть роль `iam.serviceAccounts.user`. Она подтверждает права на использование сервисного аккаунта.

Сейчас не поддерживаются внешние реестры. Поэтому любой внешний образ сначала нужно перенести в реестр Yandex Container Registry по [инструкции](../../container-registry/operations/docker-image/docker-image-push.md).
