# Рекомендации по использованию агента

Данный раздел описывает рекомендации по использованию {{unified-agent-full-name}}.

## Один агент на хост { #one-agent-per-host }

Не следует запускать на одном хосте больше одного экземпляра {{unified-agent-full-name}} с одинаковыми файлами конфигурации, так как это может привести к нарушению работы агента.

## Мониторинг агента { #agent_metrics }

При использовании {{unified-agent-full-name}} рекомендуется включить сбор метрик работоспособности самого агента.

Для этого добавьте в конфигурацию агента [маршрут доставки](./concepts.md#routes) со входом типа `agent_metrics`. Пример такой конфиугации:

```yaml
status:
  port: 16241

routes:
  - input:
      plugin: agent_metrics
      config:
        namespace: agent
    channel:
      output:
        plugin: yc_metrics
        config:
          folder_id: <FOLDER_ID>
          iam:
            cloud_meta: {}
```

Подробнее конфигурирование входа `agent_metrics` описано в разделе [{#T}](configuration.md#agent_metrics_input).

## Использование хранилища { #storage }

Для надежной доставки метрик, которые собирает {{unified-agent-short-name}}, в {{ monitoring-full-name }} рекомендуется использовать хранилище, которое позволяет буферизировать сообщения, проходящие по [цепочке преобразований](./concepts.md#pipes) перед отправкой их в выход канала.

Сохранение данных в хранилище позволяет не потерять данные в случае, если агенту не удалось записать данные в указанный выход (с учетом повторных попыток), например, из-за сетевых проблем или недоступности API, куда отправляются сообщения.

Пример конфиугации агента с использованием хранилища:

```yaml
status:
  port: 16241

storages:
  - name: main
    plugin: fs
    config:
      directory: ./data/storage
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
          folder_id: <FOLDER_ID>
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

Подробнее конфигурирование хранилища описано в разделе [{#T}](configuration.md#storages).
