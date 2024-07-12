---
title: "Решение проблем в {{ container-registry-full-name }}"
description: "На странице приведены часто возникающие ошибки и способы их решения." 
---

# Решение проблем в {{ container-registry-name }}

В списке ниже приведены часто возникающие ошибки и способы их решения:
* `docker login is not supported with yc credential helper`

  **Почему возникла ошибка:** если вы используете [Docker Credential helper](../operations/authentication.md#cred-helper), нельзя [аутентифицироваться](../operations/authentication.md) в {{ container-registry-name }} с помощью `docker login`. Эту ошибку можно также увидеть в [{{ coi }}](../../cos/concepts/index.md), где Credential helper используется для аутентификации от имени привязанного к [виртуальной машине](../../compute/concepts/vm.md) [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

  **Как исправить:** аутентифицируйтесь в [реестре](../concepts/registry.md), используя Docker Credential helper, или [отключите Docker Credential helper](../operations/authentication.md#ch-not-use).
* `Got permission denied while trying to connect to the Docker daemon socket`

  **Почему возникла ошибка:** Docker-демон по умолчанию требует прав `root`-пользователя для выполнения команд.

  **Как исправить:** выполняйте команды, используя `sudo`, или [настройте права для других пользователей операционной системы](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).
* `name unknown: Registry <...> not found`

  **Почему возникла ошибка:** не указан или указан неверно идентификатор реестра. При использовании команд Docker CLI необходимо указывать полное имя [Docker-образа](../concepts/docker-image.md), включающее в себя идентификатор реестра. Подробнее об этом читайте в разделе [{#T}](../concepts/repository.md).

  **Как исправить:** проверьте корректность указанного уникального идентификатора реестра, [посмотрев список реестров](../operations/registry/registry-list.md).
* `Error response from daemon: pull access denied for <{{ registry }}/идентификатор_реестра/имя_Docker-образа>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <идентификатор_запроса>`

  **Почему возникла ошибка:** для [IP-адреса](../../vpc/concepts/address.md), с которого идет запрос на скачивание Docker-образа, нет разрешения на скачивание (PULL).

  **Как исправить:** [добавьте](../operations/registry/registry-access.md) разрешающие правила для этого IP-адреса в настройках реестра или удалите все правила и повторите попытку.