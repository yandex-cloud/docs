# Поставка метрик HAProxy и других сторонних приложений

{{unified-agent-full-name}} поддерживает сбор метрик в формате Prometheus и конвертацию метрик в формат {{ monitoring-full-name }}. Таким образом, при помощи {{unified-agent-short-name}} можно собирать метрики любых приложений, предоставляющих метрики в формате Prometheus.

Для поставки в {{ monitoring-full-name }} метрик сторонних приложений используется вход `prometheus_pull`, который периодически опрашивает напрямую стороннее приложение (если оно поддерживает метрики в формате Prometheus) или специальное приложение-экспортер, реализующее интеграцию с Prometheus. Подробнее работа этого входа описана в разделе [{#T}](../../concepts/data-collection/unified-agent/configuration.md#prometheus_pull_input).

Для примера рассмотрим поставку в {{ monitoring-full-name }} метрик [HAProxy](https://www.haproxy.org). Описанная методика может также применяться для отправки метрик любых сторонних приложений, для которых существует [интеграция с Prometheus](https://prometheus.io/docs/instrumenting/exporters/).

1. Установите [HAProxy](https://www.haproxy.org) и [HAProxy Exporter for Prometheus](https://github.com/prometheus/haproxy_exporter).

   1. Для установки HAProxy и HAProxy Exporter for Prometheus выполните следующую команду:

      ```bash
      sudo apt install haproxy prometheus-haproxy-exporter
      ```

   1. Убедитесь, что экспортер запущен и предоставляет метрики, выполнив команду `curl http://localhost:9101/metrics`. Пример работы команды:

      ```bash
      $ curl http://localhost:9101/metrics
      # HELP go_gc_duration_seconds A summary of the GC invocation durations.
      # TYPE go_gc_duration_seconds summary
      go_gc_duration_seconds{quantile="0"} 0
      go_gc_duration_seconds{quantile="0.25"} 0
      go_gc_duration_seconds{quantile="0.5"} 0
      go_gc_duration_seconds{quantile="0.75"} 0
      go_gc_duration_seconds{quantile="1"} 0
      go_gc_duration_seconds_sum 0
      go_gc_duration_seconds_count 0
      # HELP go_goroutines Number of goroutines that currently exist.
      # TYPE go_goroutines gauge
      go_goroutines 6
      # HELP go_info Information about the Go environment.
      # TYPE go_info gauge
      go_info{version="go1.10.4"} 1
      ```

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../iam/operations/sa/create.md) и [{#T}](../../../iam/operations/sa/assign-role-for-sa.md).

   1. Привяжите сервисный аккаунт к виртуальной машине, на которой установлен {{unified-agent-short-name}}. Подробнее шаги для этого описаны в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

1. Установите и настройте {{unified-agent-full-name}}.

   1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

       {% include [ua-docker-install](../../../_includes/monitoring/ua-docker-install.md) %}

       Другие способы установки агента описаны в разделе [{#T}](../../concepts/data-collection/unified-agent/installation.md).

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики:

       **config.yml:**
       ```yaml
       status:
         port: 16241
       routes:
         - input:
             plugin: prometheus_pull
             config:
               url: http://localhost:9101/metrics
               namespace: haproxy
           channel:
             output:
               plugin: yc_metrics
               config:
                 folder_id: <FOLDER_ID>
                 iam:
                   cloud_meta: {}
       ```

 1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

    1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются метрики, в строке запроса. Собранные метрики приложения имеют в имени префикс `haproxy`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../../concepts/data-collection/unified-agent/index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../../concepts/data-collection/unified-agent/best-practices.md)
