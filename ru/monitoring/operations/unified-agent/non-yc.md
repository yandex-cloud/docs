# Поставка метрик с хостов вне {{ yandex-cloud }}

Для поставки в {{ monitoring-full-name }} метрик с хостов, расположенных за пределами {{ yandex-cloud }}:

1. Создайте [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта для доступа к каталогу, в который будут поставляться метрики.

1. [Установите и настройте {{ unified-agent-full-name }}](../../concepts/data-collection/unified-agent/installation.md) для сбора и отправки метрик.
 
Описанная методика может также применяться для отправки метрик с виртуальных машин {{ yandex-cloud }} без привязанного сервисного аккаунта.

{% note warning %}

Поставка системных метрик возможна только с хостов Linux на платформе AMD. Поддержка Windows и macOS запланирована в будущих релизах {{ unified-agent-full-name }}.

{% endnote %}

## Поставка метрик с использованием авторизованного ключа {#example}

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }} и создайте авторизованный ключ.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

   1. [Создайте авторизованный ключ](../../../iam/operations/authorized-key/create.md) для созданного сервисного аккаунта при помощи утилиты [YC CLI](../../../cli/quickstart.md):

       ```bash
       yc iam key create --service-account-id <идентификатор_сервисного_аккаунта> --output jwt_params.json
       ```

       Где `--service-account-id` – идентификатор сервисного аккаунта.

      Другие способы создания авторизованных ключей описаны в разделе [{#T}](../../../iam/operations/authorized-key/create.md).

   1. Доставьте файл **jwt_params.json** с параметрами авторизованного ключа на хост, где будет установлен {{unified-agent-short-name}}.

       Пример файла **jwt_params.json**:
       ```json
       {
           "id": "ajt4yut8vb12********",
           "service_account_id": "ajeo5pert10z********",
           "created_at": "2024-05-15T07:10:32.585653195Z",
           "key_algorithm": "RSA_2048",
           "public_key": "-----BEGIN PUBLIC KEY-----\nMD...",
           "private_key": "-----BEGIN PRIVATE KEY-----\nMI..."
       }
       ```
   
1. [Установите и настройте на хосте {{unified-agent-full-name}}](../../concepts/data-collection/unified-agent/installation.md):
   
   1. Установите [Docker](https://docs.docker.com).

   1. Создайте в домашнем каталоге файл **config.yml**.

       **config.yml:**
       ```yaml
        status:
          port: "16241"
          host: null
        agent_log:
          priority: NOTICE

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
                  url: https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write
                  folder_id: "$FOLDER_ID"
                  iam:
                    jwt:
                      file: "/etc/yandex/unified_agent/jwt_params.json"

        routes:
          - input:
              plugin: linux_metrics
              config:
                namespace: sys
                proc_directory: /ua_proc
                sys_directory: /sys
                resources:
                  cpu: basic
                  memory: basic
                  network: basic
                  storage: basic
                  io: basic
                  kernel: basic
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
       * `iam.jwt.file` – путь к файлу с параметрами JWT.

   1. Установите {{unified-agent-short-name}}, выполнив в домашнем каталоге команду:

      ```bash
      docker run \
      -p 16241:16241 -it -d --uts=host \
      --name unified-agent-$(echo $(cat /proc/sys/kernel/random/uuid) | cut -d '-' -f1) \
      -v /proc:/ua_proc \
      -v $(pwd)/config.yml:/etc/yandex/unified_agent/config.yml \
      -v $(pwd)/jwt_params.json:/etc/yandex/unified_agent/jwt_params.json \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs81qpemb4******** \
      --entrypoint="unified_agent" \
      cr.yandex/yc/unified-agent
      ```

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}:

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-full-name }} перейдите в раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

    1. В строке запроса выберите:
      - каталог, в который собираются метрики;
      - значение метки `service=custom`;
      - имя метрики, начинающееся с префикса `sys`.

#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
