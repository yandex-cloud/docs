---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Решение проблем в {{ container-registry-name }}

В списке ниже приведены часто возникающие ошибки и способы их решения:
- `docker login is not supported with yc credential helper`

    **Почему возникла ошибка:** если вы используете [Docker Credential helper](../operations/authentication.md#cred-helper), нельзя аутентифицироваться в {{ container-registry-full-name }} с помощью `docker login`. Эту ошибку можно также увидеть в [Container Optimized Image](../../cos/concepts/index.md), где Credential helper используется для аутентификации от имени привязанного к ВМ сервисного аккаунта.

    **Как исправить:** аутентифицируйтесь в реестре, [используя Docker Credential helper](../operations/authentication.md#cred-helper), или [отключите Docker Credential helper](../operations/authentication.md#ch-not-use).
- `Got permission denied while trying to connect to the Docker daemon socket`

    **Почему возникла ошибка:** Docker-демон по умолчанию требует прав `root`-пользователя для выполнения команд.

    **Как исправить:** выполняйте команды, используя `sudo`, или [настройте права для других пользователей операционной системы](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).
- `name unknown: Registry <...> not found`

    **Почему возникла ошибка:** не указан или указан неверно идентификатор реестра. При использовании команд Docker CLI необходимо указывать полное имя Docker-образа, включающее в себя идентификатор реестра. Подробнее об этом читайте в разделе [{#T}](../concepts/repository.md).

    **Как исправить:** проверьте корректность указанного уникального идентификатора реестра, [посмотрев список реестров](../operations/registry/registry-list.md).
