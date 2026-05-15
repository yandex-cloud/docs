---
title: Диагностика производительности в {{ mch-name }}
description: Вы можете получать метрики производительности по запросам и группам запросов в {{ mch-full-name }}.
---

# Диагностика производительности в {{ mch-name }}

{{ mch-name }} позволяет собирать метрики производительности запросов в кластере.

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы включить сбор статистики, выберите опцию **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** при [создании](cluster-create.md#create-cluster) или [изменении](update.md) кластера. По умолчанию опция отключена.


{% endlist %}

## Получить статистику по запросам {#get-queries}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/heart-pulse.svg) **Диагностика производительности**.

      Чтобы посмотреть историю или статистику запросов, выберите нужную вкладку. При этом данные отображаются за выбранный интервал времени.
  
  1. (Опционально) Добавьте фильтры запросов:
      
      1. Выберите хосты.
      1. Выберите пользователей.
      1. Выберите результат запроса: `QueryFinish`, `ExceptionBeforeStart` или `ExceptionWhileProcessing`.
      1. Выберите вид запроса.

  1. Чтобы посмотреть информацию о запросе, выберите нужный запрос на вкладке **История**. Откроется страница запроса.
  
      Для запросов длительностью 5 секунд и более будут отображены следующие графики:

      * **Chart CPU** — использование CPU.
      * **Chart memory** — использование оперативной памяти.
      * **Chart rows** — количество строк, прочитанных и добавленных запросом.
      * **Chart bytes** — объем прочитанных и добавленных запросом данных, в байтах.

{% endlist %}

## Получить статистику по группам запросов {#get-query-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/heart-pulse.svg) **Диагностика производительности**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.clickhouse.PerformanceDiagnostics.ClusterDiagnosticsTabs.label_query-groups_w3anM }}**.

      На странице отображаются уникальные запросы за выбранный интервал времени.
  
  1. (Опционально) Добавьте фильтры запросов:
      
      1. Выберите хосты.
      1. Выберите пользователей.
      1. Выберите результат запроса: `QueryFinish`, `ExceptionBeforeStart` или `ExceptionWhileProcessing`.
      1. Выберите вид запроса.

{% endlist %}