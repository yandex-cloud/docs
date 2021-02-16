# Поставка метрик пользовательских приложений

{{unified-agent-full-name}} поддерживает сбор метрик в формате Prometheus и конвертацию метрик в формат {{ monitoring-full-name }}. Таким образом, при помощи {{unified-agent-short-name}} можно собирать метрики любых приложений, предоставляющих метрики в формате Prometheus.

Для поставки в {{ monitoring-full-name }} метрик пользовательских приложений используется вход `metrics_pull`, который периодически опрашивает приложение по HTTP, ожидая получить метрики в формате Prometheus. Подробнее работа этого входа описана в разделе [{#T}](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input).

Для примера рассмотрим сбор метрик в формате Prometheus с тестового приложения на Python. Описанная методика может также применяться для поставки метрик любых пользовательских приложений, использующих [клиентские библиотеки Prometheus](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Запустите тестовое python-приложение, предоставляющее метрики в формате Prometheus.

   1. Установите python-библиотеку [prometheus_client](https://github.com/prometheus/client_python), выполнив следующие команды:

       ```bash
       sudo apt install python3-pip
       pip3 install prometheus_client
       ```

   1. Создайте тестовое python-приложение, записав в файл **example.py** следующий код:

       **example.py:**
       ```python
       from prometheus_client import start_http_server, Summary
       import random
       import time

       # Create a metric to track time spent and requests made.
       REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

       # Decorate function with metric.
       @REQUEST_TIME.time()
       def process_request(t):
           """A dummy function that takes some time."""
           time.sleep(t)

       if __name__ == '__main__':
           # Start up the server to expose the metrics.
           start_http_server(8000)
           # Generate some requests.
           while True:
               process_request(random.random())
       ```

   1. Запустите тестовое python-приложение, выполнив следующую команду:

       ```bash
       python3 example.py
       ```

    1. Убедитесь, что приложение предоставляет метрики, выполнив команду `curl http://localhost:8000`. Пример работы команды:

        ```bash
        $ curl http://localhost:8000
        # HELP python_gc_objects_collected_total Objects collected during gc
        # TYPE python_gc_objects_collected_total counter
        python_gc_objects_collected_total{generation="0"} 362.0
        python_gc_objects_collected_total{generation="1"} 0.0
        python_gc_objects_collected_total{generation="2"} 0.0
        # HELP python_gc_objects_uncollectable_total Uncollectable object found during GC
        # TYPE python_gc_objects_uncollectable_total counter
        ...
        ```

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../iam/operations/sa/create.md) и [{#T}](../../../iam/operations/sa/assign-role-for-sa.md).

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

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `$FOLDER_ID` на идентификатор каталога, куда будут записываться метрики:

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
            plugin: metrics_pull
            config:
              url: http://localhost:8000
              format:
                prometheus: {}
              namespace: app
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

    1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются метрики, в строке запроса. Собранные метрики приложения имеют в имени префикс `app`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../../concepts/data-collection/unified-agent/best-practices.md)
