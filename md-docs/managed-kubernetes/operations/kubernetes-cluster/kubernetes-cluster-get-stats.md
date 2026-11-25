[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление кластером Kubernetes > Мониторинг состояния кластера Kubernetes

# Мониторинг состояния кластера Managed Service for Kubernetes

Managed Service for Kubernetes автоматически отправляет метрики кластеров в [Monium Metrics](../../../monium/metrics/overview.md). Доступны метрики следующих объектов Kubernetes:

* контейнер;
* [мастер](../../concepts/index.md#master);
* [узел](../../concepts/index.md#node-group);
* [под](../../concepts/index.md#pod);
* [постоянный том](../../concepts/volume.md#persistent-volume).

Описание метрик приводится в разделе [Справочник метрик Monium Metrics](../../metrics.md).

## Как получить статистику {#methods}

Есть несколько альтернативных способов:

* [Посмотрите статистику в консоли управления](#console). В ней визуализируются метрики только мастера, узлов и подов.
* [Откройте веб-интерфейс Monium](#monitoring). В нем визуализируются все метрики Managed Service for Kubernetes.
* [Выгрузите метрики](../../../monium/operations/metric/get.md) с помощью API Monium. Этот способ подходит, если нужно получить только численные значения метрик без визуализации.
* [Установите приложение Metrics Provider](../applications/metrics-provider.md). С его помощью можно транслировать метрики в двух направлениях:

   * из объектов Kubernetes в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md);
   * из Monium в объекты Kubernetes.


* [Установите приложение Prometheus Operator](../applications/prometheus-operator.md) для работы с системой мониторинга [Yandex Managed Service for Prometheus®](../../../monium/operations/prometheus/index.md). Так вы сможете работать с дашбордами в [Grafana](https://grafana.com/grafana/) и пользоваться преимуществами [Prometheus](https://prometheus.io/docs/introduction/overview/).


## Посмотреть статистику в консоли управления {#console}

### Посмотреть статистику мастера {#master}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. Перейдите на вкладку **Обзор**, затем **Мастер**.

      Откроются виджеты с метриками мастера Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).

   1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику узла {#node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление узлами**, затем **Узлы**.
  1. Выберите узел, по которому вы хотите посмотреть статистику, и перейдите на вкладку **Мониторинг**.

      Откроются виджеты с метриками узла Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).

      На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [Monium](#monitoring).

  1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику пода {#pod}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. Перейдите на вкладку **Рабочая нагрузка**.
  1. В списке подов выберите под, для которого хотите посмотреть статистику, и перейдите на вкладку **Мониторинг**.

     Откроются виджеты с метриками пода Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).

     На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [Monium](#monitoring).

  1. Укажите период, за который нужно получить статистику.

     Графики на виджетах автоматически обновятся.

{% endlist %}

## Посмотреть статистику в Monium {#monitoring}

1. Откройте [главную страницу](https://monium.yandex.cloud) Monium.
1. Выберите [проект](../../../monium/concepts/glossary.md#project) `folder__<идентификатор_каталога>` для каталога, в котором находится кластер. Метрики ресурсов автоматически поступают в этот проект.
1. Слева выберите ![alt](../../../_assets/console-icons/compass.svg) **Обзор** → ![alt](../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
1. В поле для ввода запроса нажмите на значок ![image](../../../_assets/console-icons/code.svg).
1. [Задайте запрос на статистику](#requests-in-monitoring).
1. Укажите период, за который нужно получить статистику.
1. Нажмите кнопку **Выполнить**.

### Запросы на статистику в Monium {#requests-in-monitoring}

В запросах ниже `cluster="default"` — служебная метка Monium. Кластер Managed Service for Kubernetes выбирается по метке `cluster_id`.

* Для **контейнера** Managed Service for Kubernetes:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", container="<имя_контейнера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"container.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-container-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера Managed Service for Kubernetes.
   * `namespace` — пространство имен объекта.
   * `container` — имя контейнера, по которому нужна статистика.

* Для **мастера** Managed Service for Kubernetes:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики мастера, например `"master.cpu.utilization_percent"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера Managed Service for Kubernetes.

* Для **узла** Managed Service for Kubernetes:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", node="<имя_узла>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики узла, например `"node.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера Managed Service for Kubernetes.
   * `node` — имя узла, по которому нужна статистика.

* Для **пода** Managed Service for Kubernetes:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", pod="<имя_пода>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики пода, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера Managed Service for Kubernetes.
   * `namespace` — пространство имен объекта.
   * `pod` — имя пода, по которому нужна статистика.

* Для **постоянного тома** (Persistent Volume Claim, PVC) Managed Service for Kubernetes:

   ```
   "<метрика>"{project="folder__<идентификатор_каталога>", cluster="default", service="__managed-kubernetes__", cluster_id="<идентификатор_кластера>", namespace="<пространство_имен>", persistentvolumeclaim="<имя_pvc>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики постоянного тома, например `"persistent_volume.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-persistent-volume-metrics).
   * `project` — проект каталога с кластером в формате `folder__<идентификатор_каталога>`.
   * `cluster_id` — идентификатор кластера Managed Service for Kubernetes.
   * `namespace` — пространство имен объекта.
   * `persistentvolumeclaim` — имя постоянного тома, по которому нужна статистика.