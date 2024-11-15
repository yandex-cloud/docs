1. Запустите Docker Desktop.
1. Аутентифицируйтесь в реестре от своего имени с помощью:

   {% list tabs group=registry_auth %}

   - Docker Credential helper {#docker}

     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}

        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "{{ registry }}": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../../../container-registry/operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   - OAuth-токена {#oauth-token}

     1. Если у вас еще нет [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md), получите его по [ссылке]({{ link-cloud-oauth }}).
     1. Выполните команду:

        ```bash
        echo <OAuth-токен> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   - {{ iam-full-name }}-токена {#iam-token}

     {% note info %}

     {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Получите](../../../iam/operations/iam-token/create.md) [{{ iam-name }}-токен](../../../iam/concepts/authorization/iam-token.md).
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   {% endlist %}

1. Скачайте Docker-образ с [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Результат:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Присвойте тег Docker-образу:

   ```bash
   docker tag ubuntu:20.04 {{ registry }}/<идентификатор_реестра>/ubuntu:20.04
   ```

1. Загрузите Docker-образ в {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<идентификатор_реестра>/ubuntu:20.04
   ```

   Результат:

   ```text
   The push refers to repository [{{ registry }}/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```