# Обзор

!!! TODO: Добавить в index.yaml Мониторинга ссылки на страницы агента !!!

Для поставки пользовательских метрик в Яндекс.Мониторинг предоставляется Yandex Unified Agent — агент для поставки метрик виртуальных машин и пользовательских приложений. Агент собирает метрики в формате Prometheus и отправляет их в Яндекс.

Начать поставлять метрики виртуальной машины Яндекс.Облака при помощи Unified Agent очень просто:

1. Создайте файл конфигурации, указав в нём идентификатор своего каталога в Облаке в параметре folderId:
```
$ vim example.yml
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

2. Запустите агент:
```
$ docker run docker run -d --name yandex-unified-agent \
-v example.yml:/etc/yandex/unified-agent/example.yml
-e UNIFIED_AGENT_CONFIG=/etc/yandex/unified-agent/example.yml \
-v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
cr.yandex/yc/yandex-unified-agent:latest
```

Больше инструкций для быстрого начала работы доступны в разделе ["Начало работы"](quickstart.md). Подробные инструкции по установке и конфигурированию доступны в разделах ["Установка"](installation.md) и ["Конфигурирование"](configuration.md) соответственно.

{% note %}
В настоящий момент Unified Agent запускается только на ОС Linux или в виде docker-контейнера. Системные метрики собираются только в linux-совместимых системах из /proc и /sys. Поддержка нативной работы в Windows и Mac планируется в будущем.
{% endnote %}

## Основные разделы
- Индекс остальных страничек