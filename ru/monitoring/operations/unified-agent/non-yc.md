# Поставка метрик с хостов вне {{ yandex-cloud }}

Для поставки в {{ monitoring-full-name }} метрик с хостов, расположенных за пределами {{ yandex-cloud }}, используются [авторизованные ключи](../../../iam/concepts/authorization/key.md) сервисных аккаунтов. Описанная методика может также применяться для отправки метрик с виртуальных машин {{ yandex-cloud }} без привязанного сервисного аккаунта.

## Поставка метрик с использованием авторизованного ключа {#example}

Чтобы настроить {{unified-agent-full-name}} для поставки метрик с использованием авторизованного ключа, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }} и создайте авторизованный ключ.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

   1. [Создайте авторизованный ключ](../../../iam/operations/authorized-key/create.md) для созданного сервисного аккаунта при помощи утилиты [YC CLI](../../../cli/quickstart.md):

       ```bash
       yc iam key create --service-account-id <SA_ID> --output jwt_params.json
       ```

       Где `<SA_ID>` – идентификатор сервисного аккаунта.

      Другие способы создания авторизованных ключей описаны в разделе [{#T}](../../../iam/operations/authorized-key/create.md).

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

1. Установите и настройте {{unified-agent-full-name}}:

   1. Создайте в домашнем каталоге файл **config.yml**.

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

       Где:

       * `$FOLDER_ID` – идентификатор каталога, в который будут записываться метрики.
       * `iam.jwt.file` – имя файла с параметрами JWT.

   1. Установите {{unified-agent-short-name}} на свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      {{ registry }}/yc/unified-agent
      ```

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}:

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-full-name }} перейдите в раздел **Обзор метрик**.

    1. В строке запроса выберите:
      - каталог, в который собираются метрики;
      - значение метки `service=custom`;
      - имя метрики, начинающееся с префикса `sys`.

#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
