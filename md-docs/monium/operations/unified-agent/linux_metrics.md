[Документация Yandex Cloud](../../../index.md) > [Monium](../../index.md) > Метрики > [Поставка и экспорт метрик](../index.md) > Поставка системных метрик Linux

# Поставка системных метрик Linux

Общие метрики виртуальной машины сервис Monium Metrics получает от сервиса Yandex Compute Cloud. Например, количество оперативной памяти, выделенной ВМ в момент запуска. Но как ВМ использует память, можно измерить только собирая данные внутри ВМ. Для сбора и передачи [системных метрик Linux](../../metrics-ref/unifiedagent-ref.md) предназначена утилита Unified Agent.

{% note warning %}

Поставка системных метрик виртуальных машин, работающих на Windows и macOS, запланирована в будущих релизах Unified Agent.

{% endnote %}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvnxotvmul6bua5kcg?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://youtu.be/9Z9ugkMnRcI).



Чтобы настроить Unified Agent для сбора системных метрик с виртуальной машины Yandex Cloud, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в Monium Metrics.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `monitoring.editor`.

   1. [Привяжите сервисный аккаунт](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине, на которой установлен Unified Agent.

1. Установите и настройте Unified Agent:

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

   1. Установите Unified Agent на свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -v /proc:/ua_proc \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=<идентификатор_каталога> \
      cr.yandex/yc/unified-agent
      ```

       Где `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в который будут записываться метрики.
       
       Другие способы установки агента описаны в разделе [Установка и обновление Unified Agent](../../concepts/data-collection/unified-agent/installation.md).

1. Убедитесь, что метрики поступают в Monium Metrics:

    1. На [главной странице](https://monium.yandex.cloud) сервиса Monium Metrics перейдите в раздел **Метрики**.

    1. В строке запроса выберите:
      - каталог, в который собираются метрики;
      - значение метки `service=custom`;
      - имя метрики, начинающееся с префикса `sys`.


#### Что дальше {#what-is-next}

- [Изучите концепции Unified Agent](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../../concepts/data-collection/unified-agent/best-practices.md)