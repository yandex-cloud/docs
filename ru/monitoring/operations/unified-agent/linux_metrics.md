# Поставка системных метрик Linux

Для поставки в {{ monitoring-full-name }} системных метрик виртуальных машин, работающих на Linux-совместимых операционных системах, используется вход [linux_metrics](../../concepts/data-collection/unified-agent/configuration.md#linux_metrics_input).

{% note warning %}

Поставка системных метрик виртуальных машин, работающих на {% if product == "yandex-cloud" %}Windows и {% endif %}macOS, запланирована в будущих релизах {{unified-agent-full-name}}.

{% endnote %}

Чтобы настроить {{unified-agent-full-name}} для сбора системных метрик с виртуальной машины {{ yandex-cloud }}, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

   1. [Привяжите сервисный аккаунт](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине, на которой установлен {{unified-agent-short-name}}.

1. Установите и настройте {{unified-agent-full-name}}.

   1. Создайте в домашнем каталоге файл **config.yml**:

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

       Где `$FOLDER_ID` – идентификатор каталога, в который будут записываться метрики.

   1. Установите {{unified-agent-short-name}} на свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -v /proc:/ua_proc \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
      ```

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-full-name }} перейдите в раздел **Обзор метрик**.

    1. В строке запроса выберите:
      - каталог, в который собираются метрики;
      - значение метки `service=custom`;
      - имя метрики, начинающееся с префикса `sys`.


#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
