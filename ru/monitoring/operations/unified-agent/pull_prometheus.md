# Поставка метрик пользовательских приложений

{{unified-agent-full-name}} поддерживает сбор метрик в формате Prometheus и конвертацию метрик в формат {{ monitoring-full-name }}. Таким образом, при помощи {{unified-agent-short-name}} можно собирать метрики любых приложений, предоставляющих метрики в формате Prometheus.

Для поставки в {{ monitoring-full-name }} метрик пользовательских приложений используется вход `prometheus_pull`, который периодически опрашивает приложение по HTTP, ожидая получить метрики в формате Prometheus. Подробнее работа этого входа описана в разделе [{#T}](../../concepts/unified-agent/configuration.md#prometheus_pull_input).

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

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../../iam/operations/sa/create.md) и [{#T}](../../../../iam/operations/sa/assign-role-for-sa.md).

   1. Привяжите сервисный аккаунт к виртуальной машине, на которой установлен {{unified-agent-short-name}}. Подробнее шаги для этого описаны в разделе [{#T}](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

1. Установите и настройте {{unified-agent-full-name}}.

   1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

       {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/unified-agent/installation.md).

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики:

       **config.yml:**
       ```yaml
       status:
         port: 16241
       routes:
         - input:
             plugin: prometheus_pull
             config:
               url: http://localhost:8000
               namespace: app
           channel:
             output:
               plugin: yc_metrics
               config:
                 folder_id: <FOLDER_ID>
                 iam:
                   cloud_meta: {}
       ```

 1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

    1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются метрики, в строке запроса. Собранные метрики приложения имеют в имени префикс `app`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../../concepts/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../../concepts/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../../concepts/unified-agent/best-practices.md)
