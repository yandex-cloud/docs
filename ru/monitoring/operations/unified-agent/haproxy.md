# Поставка метрик HAProxy и других сторонних приложений

{{unified-agent-full-name}} поддерживает сбор метрик в формате {{ prometheus-name }} и конвертацию метрик в формат {{ monitoring-full-name }}. При помощи {{unified-agent-short-name}} вы сможете собирать метрики любых приложений, которые предоставляют метрики в формате {{ prometheus-name }}.

Для поставки в {{ monitoring-full-name }} метрик сторонних приложений используется [вход metrics_pull](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input), который периодически опрашивает напрямую стороннее приложение (если оно поддерживает метрики в формате {{ prometheus-name }}) или специальное приложение-экспортер, реализующее интеграцию с {{ prometheus-name }}.

Для примера рассмотрим поставку в {{ monitoring-full-name }} метрик [HAProxy](https://www.haproxy.org).

## Пример поставки метрик HAProxy {#example}

Описанная методика может также применяться для отправки метрик любых сторонних приложений, для которых существует [интеграция с Prometheus](https://prometheus.io/docs/instrumenting/exporters/).

1. Установите [HAProxy](https://www.haproxy.org).

   1. Для установки HAProxy выполните следующую команду:

      ```bash
      sudo apt install haproxy
      ```

   1. Чтобы реализовать интеграцию с {{ prometheus-name }}, настройте экспортер. Для этого добавьте раздел `frontend` в конфигурационный файл `haproxy.cfg`:

      ```bash
      frontend stats
          bind *:8404
          http-request use-service prometheus-exporter if { path /metrics }
          stats enable
          stats uri /stats
          stats refresh 10s
      ```

   1. Выполните перезапуск сервиса:

      ```
      sudo service haproxy restart
      ```

   1. Убедитесь, что экспортер запущен и предоставляет метрики. Для этого выполните команду `curl http://localhost:8404/metrics`. Пример работы команды:

      ```bash
      # HELP haproxy_process_nbthread Number of started threads (global.nbthread)
      # TYPE haproxy_process_nbthread gauge
      haproxy_process_nbthread 2
      # HELP haproxy_process_nbproc Number of started worker processes (historical, always 1)
      # TYPE haproxy_process_nbproc gauge
      haproxy_process_nbproc 1
      # HELP haproxy_process_relative_process_id Relative worker process number (1)
      # TYPE haproxy_process_relative_process_id gauge
      haproxy_process_relative_process_id 1
      # HELP haproxy_process_uptime_seconds How long ago this worker process was started (seconds)
      # TYPE haproxy_process_uptime_seconds gauge
      haproxy_process_uptime_seconds 5
      # HELP haproxy_process_pool_failures_total Number of failed pool allocations since this worker was started
      # TYPE haproxy_process_pool_failures_total counter
      haproxy_process_pool_failures_total 0
      ```

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики и [назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

   1. [Привяжите сервисный аккаунт](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине, на которой установлен {{ unified-agent-short-name }}.

1. Установите и настройте {{ unified-agent-full-name }}:

   1. Создайте в домашнем каталоге файл `config.yml`:

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
              plugin: metrics_pull
              config:
                url: http://localhost:8404/metrics
                format:
                  prometheus: {}
                namespace: haproxy
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

   1. Установите {{ unified-agent-short-name }} на свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs81qpemb4******** \
      {{ registry }}/yc/unified-agent
      ```

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).


 1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}:

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-full-name }} перейдите в раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

    1. В строке запроса выберите:
      - каталог, в который собираются метрики;
      - значение метки `service=custom`;
      - имя метрики, начинающееся с префикса `haproxy`.

#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
