[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > DataSphere Inference > Настроить окружение ноды

# Настроить окружение для развертывания самостоятельного сервиса

1. [Создайте Docker-образ](../user-images.md) в проекте и установите необходимые зависимости в скрипте сборки. Соберите образ.

1. [Создайте секрет](../data/secrets.md#create) с паролем для вашего реестра контейнеров.

   Если вы используете реестр Yandex Container Registry, аутентифицируйтесь по авторизованному ключу для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), который имеет [необходимые роли](../../../container-registry/security/index.md) и указан в [настройках проекта](../projects/update.md):

   1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
        cr.yandex
      ```

      Где:
      * Команда `cat key.json` записывает содержимое файла с ключом в поток вывода.
      * Флаг `--password-stdin` позволяет читать пароль из потока ввода.

      Результат:

      ```text
      Login Succeeded
      ```
   {% note info %}
   
   Срок жизни авторизованных ключей не ограничен, но вы всегда можете получить новые авторизованные ключи и повторить процедуру аутентификации, если что-то пошло не так.
   
   {% endnote %}

1. [Загрузите](../../../container-registry/operations/docker-image/docker-image-push.md) образ в реестр контейнеров. Для этого запустите ячейку с кодом:

   ```text
   #!:docker-publish <имя_образа>:<тег_образа> cr.yandex/<путь_к_образу>:<тег>
   ```

   * `<имя_образа>` — имя образа в DataSphere;
   * `<тег_образа>` — тег образа в DataSphere;
   * `<путь_к_образу>` — путь к образу Container Registry вида `cr.yandex/<идентификатор_реестра>/<имя_образа>`;
   * `<тег>` — [тег](../../../container-registry/concepts/docker-image.md#version) образа.

   В процессе загрузки укажите имя пользователя и выберите секрет с паролем. При авторизации в Container Registry в качестве имени пользователя введите тип токена — `json_key`, вместо пароля укажите секрет.

1. В форме создания [ноды](../../concepts/deploy/index.md#node) укажите путь к образу в формате `cr.yandex/<адрес_реестра>:<tag>`.