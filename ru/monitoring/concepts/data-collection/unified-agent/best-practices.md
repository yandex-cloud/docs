# Рекомендации по использованию агента

## Один агент на хост {#one-agent-per-host}

Не следует запускать на одном хосте больше одного экземпляра {{unified-agent-short-name}} с одинаковыми файлами конфигурации, так как это может привести к нарушению работы агента.

## Мониторинг агента {#agent_metrics}

При использовании {{unified-agent-short-name}} рекомендуется включить сбор метрик работоспособности самого агента.

Для этого добавьте в конфигурацию агента [маршрут доставки](index.md#routes) со входом `agent_metrics`. Пример такой конфигурации:

```yaml
status:
  port: 16241

routes:
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
      output:
        plugin: yc_metrics
        config:
          folder_id: "$FOLDER_ID"
          iam:
            cloud_meta: {}
```

См. также раздел [{#T}](inputs.md#agent_metrics_input).

## Использование хранилища {#storage}

Для надежной доставки метрик в {{ monitoring-full-name }} при помощи {{unified-agent-short-name}} используйте хранилище. Оно позволит временно хранить сообщения, проходящие по [цепочке преобразований](index.md#pipes), перед отправкой их на выход канала.

Используя хранилище, вы не потеряете данные, если агенту не удалось записать их в указанный выход (с учетом повторных попыток). Например, из-за сетевых проблем или недоступности API, куда отправляются сообщения.

Пример конфигурации агента с использованием хранилища:

```yaml
status:
  port: 16241

storages:
  - name: main
    plugin: fs
    config:
      directory: /var/lib/yandex/unified_agent/main
      max_partition_size: 1gb
      max_segment_size: 500mb

channels:
  - name: cloud_monitoring
    channel:
      pipe:
        - storage_ref:
            name: main
      output:
        plugin: yc_metrics
        config:
          folder_id: <идентификатор_каталога>
          iam:
            cloud_meta: {}

routes:
  - input:
      plugin: linux_metrics
      config:
        poll_period: 15s
        namespace: sys
    channel:
      channel_ref:
        name: cloud_monitoring
```

См. также раздел [{#T}](storage.md).
