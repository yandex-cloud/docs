# Обзор

!!! TODO: Добавить в index.yaml Мониторинга ссылки на страницы агента !!!

Для поставки пользовательских метрик в {{monitoring-full-name}} предоставляется {{unified-agent-full-name}} — агент для поставки метрик виртуальных машин и пользовательских приложений. Агент собирает метрики в формате Prometheus и отправляет их в {{monitoring-full-name}}.

Начать поставлять метрики виртуальной машины {{yandex-cloud}} при помощи {{unified-agent-short-name}} очень просто:


1. Создайте файл конфигурации *example.yml*, указав в нем идентификатор своего каталога в Облаке в параметре folderId:

    **example.yml:**
    ```yaml
    status:
      port: 16241
    routes:
      - input:
          plugin: linux_metrics
          config:
            namespace: sys
        channel:
            pipe:
              - filter:
                  plugin: transform_metric_label
                  config:
                    label: path
                    rename_to: sensor
                    add_value_prefix: sys
              - filter:
                  plugin: convert_metrics
                  config:
                  format:
                    json:
                    indentation: 4
                    metric_name_label: sensor
            output:
              plugin: http
              config:
                url: "https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write"
                query:
                  folderId: <YOUR FOLDER ID>
                  service: custom
                headers:
                  Content-Type: application/json
                iam:
                  cloud_meta: {}
    ```

2. Запустите агент выполнив следующую команду:

    {% include [ua-docker-install](../../../_includes/monitoring/ua-docker-install.md) %}

Больше инструкций для быстрого начала работы доступны в разделе [{#T}](quickstart/index.md). Подробные инструкции по установке и конфигурированию доступны в разделах [{#T}](installation.md) и [{#T}](configuration.md) соответственно.

{% note warning %}

В настоящий момент {{unified-agent-short-name}} запускается только на ОС Linux или в виде Docker-контейнера. Системные метрики собираются только в Linux-совместимых операционных системах из `/proc` и `/sys`. Поддержка нативной работы в Windows и Mac планируется в будущем.

{% endnote %}

## Основные разделы
- Индекс остальных страничек
