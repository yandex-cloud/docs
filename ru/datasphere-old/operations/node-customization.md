# Настройка окружения для развертывания микросервиса

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

1. [Создайте Docker-образ](user-images.md) в проекте и установите необходимые зависимости в скрипте сборки. Соберите образ.

1. [Создайте секрет](data/secret-create.md) с паролем для вашего реестра контейнеров. Если вы используете реестр {{ container-registry-full-name }}, [аутентифицируйтесь по авторизованному ключу](../../container-registry/operations/authentication.md#sa-json) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Чтобы сгенерировать авторизованный ключ, в CLI выполните команду:

      ``` 
      yc iam key create --service-account-id <service_account_id> -o key.json
      ```

   Паролем для сервисного аккаунта `<service_account_id>` будет содержимое файла `key.json`.

1. [Загрузите](../../container-registry/operations/docker-image/docker-image-push.md) образ в реестр контейнеров. Для этого запустите ячейку с кодом:

   ```
   #!:docker-publish <datasphere_image_name>:<datasphere_image_tag> {{ registry }}/<cloud_registry_path>:<tag> 
   ```
   
   * `<datasphere_image_name>` — имя образа в {{ ml-platform-name }};
   * `<datasphere_image_tag>` — тег образа в {{ ml-platform-name }};
   * `<cloud_registry_path>` — адрес реестра {{ container-registry-name }};
   * `<tag>` — [тег](../../container-registry/concepts/docker-image.md#version) образа.

   В процессе загрузки укажите имя пользователя и выберите секрет с паролем.

1. В форме создания ноды укажите путь к образу в формате `{{ registry }}/<cloud_registry_path>:<tag>`. При авторизации в {{ container-registry-name }} в качестве имени пользователя введите тип токена — `json_key`, вместо пароля укажите секрет.