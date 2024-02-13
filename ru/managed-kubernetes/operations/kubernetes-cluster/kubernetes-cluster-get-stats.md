# Мониторинг состояния кластера {{ managed-k8s-name }}

{% include [metrics-resources-list](../../../_includes/managed-kubernetes/metrics-resources-list.md) %}

Описание метрик приводится в разделе [{#T}](../../metrics.md).

## Как получить статистику {#methods}

Есть несколько альтернативных способов:

* [Посмотрите статистику в консоли управления](#console). В ней визуализируются метрики только мастера, узлов и подов.
* [Откройте веб-интерфейс {{ monitoring-name }}](#monitoring). В нем визуализируются все метрики {{ managed-k8s-name }}.
* [Выгрузите метрики](../../../monitoring/operations/metric/get.md) с помощью API {{ monitoring-name }}. Этот способ подходит, если нужно получить только численные значения метрик без визуализации.
* [Установите приложение Metrics Provider](../applications/metrics-provider.md). С его помощью можно транслировать метрики в двух направлениях:

   * из объектов {{ k8s }} в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md);
   * из сервиса {{ monitoring-name }} в объекты {{ k8s }}.

* [Установите приложение Prometheus Operator](../applications/prometheus-operator.md) для работы с системой мониторинга [{{ managed-prometheus-name }}](../../../monitoring/operations/prometheus/index.md). Так вы сможете работать с дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/) и пользоваться преимуществами [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/).

## Посмотреть статистику в консоли управления {#console}

### Посмотреть статистику мастера {#master}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. В разделе **{{ ui-key.yacloud.common.overview }}** перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.overview.label_master-title }}**.

      Откроются виджеты с метриками мастера {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).

   1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику узла {#node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** перейдите на вкладку **{{ ui-key.yacloud.k8s.nodes.label_nodes }}**.
  1. Откройте страницу узла, по которому вы хотите посмотреть статистику.
  1. Перейдите на вкладку **Мониторинг**.

      Откроются виджеты с метриками узла {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).

      На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [сервисе {{ monitoring-name }}](#monitoring).

  1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику пода {#pod}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. На панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. Откройте страницу пода, по которому хотите посмотреть статистику.
  1. Перейдите на вкладку **Мониторинг**.

     Откроются виджеты с метриками пода {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).

     На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [сервисе {{ monitoring-name }}](#monitoring).

  1. Укажите период, за который нужно получить статистику.

     Графики на виджетах автоматически обновятся.

{% endlist %}

## Посмотреть статистику в {{ monitoring-name }} {#monitoring}

1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
1. На панели слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
1. В поле для ввода запроса нажмите на значок ![image](../../../_assets/console-icons/code.svg).
1. [Задайте запрос на статистику](#requests-in-monitoring).
1. Укажите период, за который нужно получить статистику.
1. Нажмите кнопку **Выполнить**.

### Запросы на статистику в {{ monitoring-name }} {#requests-in-monitoring}

* Для **контейнера** {{ managed-k8s-name }}:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", container="<имя_контейнера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"container.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-container-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера {{ managed-k8s-name }}.
   * `container` — имя контейнера, по которому нужна статистика.

* Для **мастера** {{ managed-k8s-name }}:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"master.cpu.utilization_percent"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера {{ managed-k8s-name }}.

* Для **узла** {{ managed-k8s-name }}:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", node="<имя_узла>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"node.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера {{ managed-k8s-name }}.
   * `node` — имя узла, по которому нужна статистика.

* Для **пода** {{ managed-k8s-name }}:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", pod="<имя_пода>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера {{ managed-k8s-name }}.
   * `pod` — имя пода, по которому нужна статистика.

* Для **постоянного тома** (Persistent Volume Claim, PVC) {{ managed-k8s-name }}:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", persistentvolumeclaim="<имя_PVC>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-persistent-volume-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера {{ managed-k8s-name }}.
   * `persistentvolumeclaim` — имя постоянного тома, по которому нужна статистика.
