# Поставка метрик с хостов вне {{ yandex-cloud }}

Для поставки в {{ monitoring-full-name }} метрик с хостов, расположенных за пределами {{ yandex-cloud }}, используются авторизованные ключи сервисных аккаунтов для обмена [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token) на IAM-токен. Описанная методика может также применяться для отправки метрик с виртуальных машин {{ yandex-cloud }} без привязанного сервисного аккаунта.

Чтобы настроить {{unified-agent-full-name}} для сбора метрик с использованием авторизованного ключа, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }} и создайте авторизованный ключ.

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../iam/operations/sa/create.md) и [{#T}](../../../iam/operations/sa/assign-role-for-sa.md).

   1. Создайте авторизованный ключ для созданного сервисного аккаунта, например, при помощи утилиты `yc`, выполнив следующую команду, заменив строку `<SA_ID>` на идентификатор сервисного аккаунта:

       ```bash
       yc iam key create --service-account-id <SA_ID> --output jwt_params.json
       ```

       Подробнее создание авторизованных ключей описано в разделе [{#T}](../../../iam/operations/authorized-key/create.md).

   1. Доставьте файл **jwt_params.json** с параметрами авторизованного ключа на хост, где установлен {{unified-agent-short-name}}.

       Пример файла **jwt_params.json**:
       ```json
       {
           "id": "ajt...",
           "service_account_id": "aje...",
           "created_at": "2021-01-14T13:18:51.070026Z",
           "key_algorithm": "RSA_2048",
           "public_key": "-----BEGIN PUBLIC KEY-----\nMD...",
           "private_key": "-----BEGIN PRIVATE KEY-----\nMI..."
       }
       ```

1. Установите и настройте {{unified-agent-full-name}}.

   1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v \/proc:/ua_proc \
      -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
      ```

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `$FOLDER_ID` на идентификатор каталога, куда будут записываться метрики, и указав имя файла с параметрами JWT в секции `iam.jwt.file` :

       **config.yml:**
       ```yaml
        status:
          port: "16241"

        storages:
          - name: main
            plugin: fs
            config:
              directory: /var/lib/yandex/unified_agent/main
              max_partition_size: 100mb
              max_segment_size: 10mb

        channels:
          - name: cloud_monitoring
            channel:
              pipe:
                - storage_ref:
                    name: main
              output:
                plugin: yc_metrics
                config:
                  folder_id: "$FOLDER_ID"
                  iam:
                    jwt:
                      file: "jwt_params.json"

        routes:
          - input:
              plugin: linux_metrics
              config:
                namespace: sys
            channel:
              channel_ref:
                name: cloud_monitoring

          - input:
              plugin: agent_metrics
              config:
                namespace: ua
            channel:
              pipe:
                - filter:
                    plugin: filter_metrics
                    config:
                      match: "{scope=health}"
              channel_ref:
                name: cloud_monitoring

        import:
          - /etc/yandex/unified_agent/conf.d/*.yml
       ```

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

   1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются системные метрики, в строке запроса. Собранные системные метрики имеют в имени префикс `sys`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../../concepts/data-collection/unified-agent/best-practices.md)
