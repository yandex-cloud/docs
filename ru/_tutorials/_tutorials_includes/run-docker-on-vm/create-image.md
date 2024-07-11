1. Для удобства выполнения команд добавьте переменные:
    * Имя пользователя и публичный IP-адрес вашей ВМ — в переменную `${PUBLIC_IP}`:

        ```bash
        export PUBLIC_IP=<имя_пользователя>@<публичный_IP-адрес_ВМ>
        ```

    * Идентификатор реестра, созданного ранее, в формате `crpc9qeoft23********` — в переменную `${REGISTRY_ID}`:

        ```bash
        export REGISTRY_ID=<идентификатор_реестра>
        ```

1. Аутентифицируйтесь от своего имени:

    {% list tabs group=registry_auth %}

    - OAuth-токен {#oauth-token}

      1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
      1. Выполните команду:

          ```bash
          echo <OAuth-токен> | docker login --username oauth --password-stdin {{ registry }}
          ```

          Результат:

          ```text
          Login Succeeded
          ```

    - IAM-токен {#iam-token}

      {% note info %}

      {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Получите](../../../iam/operations/iam-token/create.md) {{ iam-name }}-токен.
      1. Выполните команду:

          ```bash
          yc iam create-token | docker login --username iam --password-stdin {{ registry }}
          ```

          Результат:

          ```text
          ...
          Login Succeeded
          ```

    - Docker Credential helper {#docker}

      1. Если у вас еще нет профиля для YC CLI, [создайте его](../../../cli/quickstart.md#initialize).
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

          Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

          {% endnote %}

      1. Проверьте, что Docker сконфигурирован.

          В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

          ```json
          "{{ registry }}": "yc"
          ```

      1. Docker готов к использованию, например, для [загрузки Docker-образов](../../../container-registry/operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

    {% endlist %}

1. Создайте файл Dockerfile:

    ```bash
    touch .dockerfile
    ```

1. Откройте Dockerfile текстовым редактором, например:

    ```bash
    nano .dockerfile
    ```

1. Добавьте туда следующие строки:

    ```text
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```

1. Соберите Docker-образ:

    ```bash
    docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
    ```

    Результат:

    ```text
    ...
    Successfully built b68ee9b6b1af
    Successfully tagged {{ registry }}/crpmnjr98tm5********/ubuntu:hello
    ```

1. Загрузите собранный Docker-образ в {{ container-registry-name }}:

    ```bash
    docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    The push refers to repository [{{ registry }}/crpc9qeoft23********/ubuntu]
    cc9d18e90faa: Pushed
    0c2689e3f920: Pushed
    47dde53750b4: Pushed
    hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928******** size: 943
    ```