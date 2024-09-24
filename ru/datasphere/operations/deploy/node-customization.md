# Настроить окружение для развертывания самостоятельного сервиса

1. [Создайте Docker-образ](../user-images.md) в проекте и установите необходимые зависимости в скрипте сборки. Соберите образ.

1. [Создайте секрет](../data/secrets.md#create) с паролем для вашего реестра контейнеров.

   Если вы используете реестр {{ container-registry-full-name }}, аутентифицируйтесь по авторизованному ключу для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), который имеет [необходимые роли](../../../container-registry/security/index.md) и указан в [настройках проекта](../projects/update.md):

   1. {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Получите и сохраните в файл `key.json` авторизованные ключи для вашего сервисного аккаунта:

      ```bash
      yc iam key create --service-account-name default-sa -o key.json
      ```

      Результат:

      ```text
      id: aje8a87g4eaj********
      service_account_id: aje3932acde3********
      created_at: "2019-05-31T16:56:47Z"
      key_algorithm: RSA_2048
      ```

   1. Выполните команду:

      ```bash
      cat key.json | docker login \
        --username json_key \
        --password-stdin \
        {{ registry }}
      ```

      Где:
      * Команда `cat key.json` записывает содержимое файла с ключом в поток вывода.
      * Флаг `--password-stdin` позволяет читать пароль из потока ввода.

      Результат:

      ```text
      Login Succeeded
      ```
   {% include [disclaimer](../../../_includes/iam/authorized-keys-disclaimer.md) %}

1. [Загрузите](../../../container-registry/operations/docker-image/docker-image-push.md) образ в реестр контейнеров. Для этого запустите ячейку с кодом:

   ```text
   #!:docker-publish <имя_образа>:<тег_образа> {{ registry }}/<путь_к_образу>:<тег>
   ```

   * `<имя_образа>` — имя образа в {{ ml-platform-name }};
   * `<тег_образа>` — тег образа в {{ ml-platform-name }};
   * `<путь_к_образу>` — путь к образу {{ container-registry-name }} вида `cr.yandex/<идентификатор_реестра>/<имя_образа>`;
   * `<тег>` — [тег](../../../container-registry/concepts/docker-image.md#version) образа.

   В процессе загрузки укажите имя пользователя и выберите секрет с паролем. При авторизации в {{ container-registry-name }} в качестве имени пользователя введите тип токена — `json_key`, вместо пароля укажите секрет.

1. В форме создания [ноды](../../concepts/deploy/index.md#node) укажите путь к образу в формате `{{ registry }}/<адрес_реестра>:<tag>`.
