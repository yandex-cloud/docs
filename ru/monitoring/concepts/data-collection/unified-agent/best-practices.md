---
title: Рекомендации по использованию агента
description: В статье вы ознакомитесь с рекомендациями по использованию агента.
---

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

## Расчет времени использования процессора {#cpu-time-tracking}

Чтобы отобразить на графике метрику использования процессора в процентах, ранее использовалась метрика `sys.system.CpuUsagePercent`. Теперь ОС Linux не передает эту метрику, но ее можно вычислить с помощью двух других метрик:

* `sys.system.UsefulTime` — время активного использования CPU.
* `sys.system.IdleTime` — время простоя CPU.

Чтобы добавить на дашборд диаграмму использования процессора в процентах:

1. [Установите и запустите](./installation.md) {{ unified-agent-short-name }}.
1. Откройте нужный дашборд или [создайте](../../../operations/dashboard/create.md) новый.
1. В правом верхнем углу нажмите значок ![square-plus](../../../../_assets/console-icons/square-plus.svg) и выберите ![chart-column](../../../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-type.graph }}**, чтобы добавить на дашборд новый виджет.
1. В добавляемом виджете создайте в текстовом режиме (значок ![code](../../../../_assets/console-icons/code.svg)) три запроса:

    1. Запрос `UsefulTime`:

        ```text
        "sys.system.UsefulTime"{folderId = "<идентификатор_каталога>", service = "custom", cpu  = "-"}
        ```

        Где `<идентификатор_каталога>` — [идентификатор](../../../../resource-manager/operations/folder/get-id.md) каталога, в котором находится ваш дашборд.

        Нажмите значок ![eye](../../../../_assets/console-icons/eye.svg), чтобы не отображать эту метрику на графике.
    1. Запрос `IdleTime`:

        ```text
        "sys.system.IdleTime"{folderId = "<идентификатор_каталога>", service = "custom", cpu = "-"}
        ```

        Где `<идентификатор_каталога>` — [идентификатор](../../../../resource-manager/operations/folder/get-id.md) каталога, в котором находится ваш дашборд.

        Нажмите значок ![eye](../../../../_assets/console-icons/eye.svg), чтобы не отображать эту метрику на графике.
    1. Запрос `CpuUsagePercent`:

        ```text
        100 * UsefulTime / (IdleTime + UsefulTime)
        ```
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** и убедитесь, что график загрузки процессора построен.
1. В правом верхнем углу нажмите значок ![floppy-disk.svg](../../../../_assets/console-icons/floppy-disk.svg), чтобы сохранить ваш виджет.