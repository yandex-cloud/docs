# Поставка системных метрик Linux

Для поставки в {{ monitoring-full-name }} системных метрик виртуальных машин, работающих на Linux-совместимых операционных системах, используется вход [linux_metrics](../../concepts/data-collection/unified-agent/configuration.md#linux_metrics_input).

{% note warning %}

Поставка системных метрик виртуальных машин, работающих на Windows и macOS, запланирована в будущих релизах {{unified-agent-full-name}}.

**TODO**: добавить идею в сообществе и поставить ссылку

{% endnote %}

Чтобы настроить {{unified-agent-full-name}} для сбора системных метрик с виртуальной машины {{ yandex-cloud }}, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `editor`.

   1. Привяжите сервисный аккаунт к виртуальной машине, на которой установлен {{unified-agent-short-name}}. Подробнее шаги для этого описаны в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

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

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики:

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
                    cloud_meta: {}

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
