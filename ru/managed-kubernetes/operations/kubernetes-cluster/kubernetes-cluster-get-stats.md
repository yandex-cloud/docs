# Мониторинг состояния кластера {{ managed-k8s-name }}

{% include [metrics-resources-list](../../../_includes/managed-kubernetes/metrics-resources-list.md) %}

Описание метрик приводится в разделе [{#T}](../../metrics.md).

## Как получить статистику {#methods}

Есть несколько альтернативных способов:

* [Посмотрите статистику в консоли управления](#console). В ней визуализируются метрики только мастера, узлов и подов.
* [Откройте веб-интерфейс {{ monium-name }}](#monitoring). В нем визуализируются все метрики {{ managed-k8s-name }}.
* [Выгрузите метрики](../../../monium/operations/metric/get.md) с помощью API {{ monium-name }}. Этот способ подходит, если нужно получить только численные значения метрик без визуализации.
* [Установите приложение Metrics Provider](../applications/metrics-provider.md). С его помощью можно транслировать метрики в двух направлениях:

   * из объектов {{ k8s }} в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md);
   * из {{ monium-name }} в объекты {{ k8s }}.


* [Установите приложение Prometheus Operator](../applications/prometheus-operator.md) для работы с системой мониторинга [{{ managed-prometheus-name }}](../../../monium/operations/prometheus/index.md). Так вы сможете работать с дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/) и пользоваться преимуществами [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/).


## Посмотреть статистику в консоли управления {#console}

### Посмотреть статистику мастера {#master}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.overview }}**, затем **{{ ui-key.yacloud.k8s.cluster.overview.label_master-title }}**.

      Откроются виджеты с метриками мастера {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).

   1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику узла {#node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**, затем **{{ ui-key.yacloud.k8s.nodes.label_nodes }}**.
  1. Выберите узел, по которому вы хотите посмотреть статистику, и перейдите на вкладку **{{ ui-key.yacloud.k8s.node.overview.label_monitoring }}**.

      Откроются виджеты с метриками узла {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).

      На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [{{ monium-name }}](#monitoring).

  1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику пода {#pod}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. В списке подов выберите под, для которого хотите посмотреть статистику, и перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-monitoring }}**.

     Откроются виджеты с метриками пода {{ managed-k8s-name }}. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).

     На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [{{ monium-name }}](#monitoring).

  1. Укажите период, за который нужно получить статистику.

     Графики на виджетах автоматически обновятся.

{% endlist %}

## Посмотреть статистику в {{ monium-name }} {#monitoring}

1. Откройте [главную страницу]({{ link-monium }}) {{ monium-name }}.
1. Выберите [проект](../../../monium/concepts/glossary.md#project) `folder__<идентификатор_каталога>` для каталога, в котором находится кластер. Метрики ресурсов автоматически поступают в этот проект.
1. Слева выберите ![alt](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
1. В поле для ввода запроса нажмите на значок ![image](../../../_assets/console-icons/code.svg).
1. [Задайте запрос на статистику](#requests-in-monitoring).
1. Укажите период, за который нужно получить статистику.
1. Нажмите кнопку **Выполнить**.

### Запросы на статистику в {{ monium-name }} {#requests-in-monitoring}

В запросах ниже `cluster="default"` — служебная метка {{ monium-name }}. Кластер {{ managed-k8s-name }} выбирается по метке `cluster_id`.

* Для **контейнера** {{ managed-k8s-name }}:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", container="<имя_контейнера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"container.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-container-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера {{ managed-k8s-name }}.
   * `namespace` — пространство имен объекта.
   * `container` — имя контейнера, по которому нужна статистика.

* Для **мастера** {{ managed-k8s-name }}:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики мастера, например `"master.cpu.utilization_percent"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера {{ managed-k8s-name }}.

* Для **узла** {{ managed-k8s-name }}:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", node="<имя_узла>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики узла, например `"node.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера {{ managed-k8s-name }}.
   * `node` — имя узла, по которому нужна статистика.

* Для **пода** {{ managed-k8s-name }}:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", pod="<имя_пода>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики пода, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера {{ managed-k8s-name }}.
   * `namespace` — пространство имен объекта.
   * `pod` — имя пода, по которому нужна статистика.

* Для **постоянного тома** (Persistent Volume Claim, PVC) {{ managed-k8s-name }}:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", persistentvolumeclaim="<имя_pvc>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики постоянного тома, например `"persistent_volume.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-persistent-volume-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера {{ managed-k8s-name }}.
   * `namespace` — пространство имен объекта.
   * `persistentvolumeclaim` — имя постоянного тома, по которому нужна статистика.
