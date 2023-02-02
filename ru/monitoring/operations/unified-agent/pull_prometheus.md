# Поставка метрик пользовательских приложений

{{unified-agent-full-name}} собирает метрики в формате {{ prometheus-name }} и конвертирует их в формат {{ monitoring-full-name }}. При помощи {{unified-agent-short-name}} вы сможете собирать метрики любых приложений, которые предоставляют метрики в формате {{ prometheus-name }}.

Для поставки в {{ monitoring-full-name }} метрик пользовательских приложений используется [вход metrics_pull](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input), который периодически опрашивает приложение по HTTP, ожидая получить метрики в формате {{ prometheus-name }}.

Для примера рассмотрим поставку метрик тестового приложения на Python.

## Пример поставки метрик пользовательского приложения {#example}

Описанная методика может также применяться для поставки метрик любых пользовательских приложений, использующих [клиентские библиотеки Prometheus](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Запустите тестовое Python-приложение, предоставляющее метрики в формате {{ prometheus-name }}.

   1. Установите Python-библиотеку [prometheus_client](https://github.com/prometheus/client_python), выполнив следующие команды:

       ```bash
       sudo apt install python3-pip
       pip3 install prometheus_client
       ```

   1. Создайте тестовое Python-приложение, записав в файл **example.py** следующий код:

       **example.py:**
       ```python
       from prometheus_client import start_http_server, Summary
       import random
       import time

       # Создайте метрику для отслеживания количества запросов и времени их выполнения.
       REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

       # Декорируйте функцию обработки запроса метрикой.
       @REQUEST_TIME.time()
       def process_request(t):
           """A dummy function that takes some time."""
           time.sleep(t)

       if __name__ == '__main__':
           # Запустите HTTP-сервер, чтобы приложение предоставило метрики.
           start_http_server(8000)
           # Сгенерируйте случайные запросы.
           while True:
               process_request(random.random())
       ```

   1. Запустите тестовое Python-приложение, выполнив следующую команду:

       ```bash
       python3 example.py
       ```

    1. Убедитесь, что приложение предоставляет метрики, выполнив команду `curl http://localhost:8000`. Пример работы команды:

        ```bash
        curl http://localhost:8000
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

       Где `$FOLDER_ID` – идентификатор каталога, в который будут записываться метрики.

   1. Установите {{unified-agent-short-name}} на свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
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
      - имя метрики, начинающееся с префикса `app`.

#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
