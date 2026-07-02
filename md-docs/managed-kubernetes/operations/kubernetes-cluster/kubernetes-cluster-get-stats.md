[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление кластером Kubernetes > Мониторинг состояния кластера Kubernetes

# Мониторинг состояния кластера Managed Service for Kubernetes

Managed Service for Kubernetes автоматически отправляет метрики кластеров в сервис [Yandex Monitoring](../../../monitoring/index.md). Доступны метрики следующих объектов Kubernetes:

* контейнер;
* [мастер](../../concepts/index.md#master);
* [узел](../../concepts/index.md#node-group);
* [под](../../concepts/index.md#pod);
* [постоянный том](../../concepts/volume.md#persistent-volume).

Описание метрик приводится в разделе [Справочник метрик Yandex Monitoring](../../metrics.md).

## Как получить статистику {#methods}

Есть несколько альтернативных способов:

* [Посмотрите статистику в консоли управления](#console). В ней визуализируются метрики только мастера, узлов и подов.
* [Откройте веб-интерфейс Monitoring](#monitoring). В нем визуализируются все метрики Managed Service for Kubernetes.
* [Выгрузите метрики](../../../monitoring/operations/metric/get.md) с помощью API Monitoring. Этот способ подходит, если нужно получить только численные значения метрик без визуализации.
* [Установите приложение Metrics Provider](../applications/metrics-provider.md). С его помощью можно транслировать метрики в двух направлениях:

   * из объектов Kubernetes в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md);
   * из сервиса Monitoring в объекты Kubernetes.


* [Установите приложение Prometheus Operator](../applications/prometheus-operator.md) для работы с системой мониторинга [Yandex Managed Service for Prometheus®](../../../monitoring/operations/prometheus/index.md). Так вы сможете работать с дашбордами в [Grafana](https://grafana.com/grafana/) и пользоваться преимуществами [Prometheus](https://prometheus.io/docs/introduction/overview/).


## Посмотреть статистику в консоли управления {#console}

### Посмотреть статистику мастера {#master}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. В разделе **Обзор** перейдите на вкладку **Мастер**.

      Откроются виджеты с метриками мастера Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).

   1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику узла {#node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. В разделе **Управление узлами** перейдите на вкладку **Узлы**.
  1. Откройте страницу узла, по которому вы хотите посмотреть статистику.
  1. Перейдите на вкладку **Мониторинг**.

      Откроются виджеты с метриками узла Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).

      На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [сервисе Monitoring](#monitoring).

  1. Укажите период, за который нужно получить статистику.

      Графики на виджетах автоматически обновятся.

{% endlist %}

### Посмотреть статистику пода {#pod}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу кластера Managed Service for Kubernetes.
  1. На панели слева выберите **Рабочая нагрузка**.
  1. Откройте страницу пода, по которому хотите посмотреть статистику.
  1. Перейдите на вкладку **Мониторинг**.

     Откроются виджеты с метриками пода Managed Service for Kubernetes. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).

     На виджетах представлены только некоторые из доступных метрик. Все метрики доступны в [сервисе Monitoring](#monitoring).

  1. Укажите период, за который нужно получить статистику.

     Графики на виджетах автоматически обновятся.

{% endlist %}

## Посмотреть статистику в Monitoring {#monitoring}

1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
1. На панели слева выберите раздел **Метрики**.
1. В поле для ввода запроса нажмите на значок ![image](../../../_assets/console-icons/code.svg).
1. [Задайте запрос на статистику](#requests-in-monitoring).
1. Укажите период, за который нужно получить статистику.
1. Нажмите кнопку **Выполнить**.

### Запросы на статистику в Monitoring {#requests-in-monitoring}

* Для **контейнера** Managed Service for Kubernetes:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", container="<имя_контейнера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"container.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-container-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера Managed Service for Kubernetes.
   * `container` — имя контейнера, по которому нужна статистика.

* Для **мастера** Managed Service for Kubernetes:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"master.cpu.utilization_percent"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-master-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера Managed Service for Kubernetes.

* Для **узла** Managed Service for Kubernetes:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", node="<имя_узла>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"node.cpu.core_usage_time"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-node-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера Managed Service for Kubernetes.
   * `node` — имя узла, по которому нужна статистика.

* Для **пода** Managed Service for Kubernetes:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", pod="<имя_пода>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-pod-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера Managed Service for Kubernetes.
   * `pod` — имя пода, по которому нужна статистика.

* Для **постоянного тома** (Persistent Volume Claim, PVC) Managed Service for Kubernetes:

   ```
   "<метрика>"{folderId="<идентификатор_каталога>", service="managed-kubernetes", cluster_id="<имя_кластера>", persistentvolumeclaim="<имя_PVC>"}
   ```

   В запросе укажите параметры:

   * `"<метрика>"` — название метрики контейнера, например `"pod.memory.used_bytes"`. Метрики перечислены в [справочнике](../../metrics.md#managed-kubernetes-persistent-volume-metrics).
   * `folderId` — идентификатор каталога.
   * `cluster_id` — имя кластера Managed Service for Kubernetes.
   * `persistentvolumeclaim` — имя постоянного тома, по которому нужна статистика.