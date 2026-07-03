# {{ gpu-operator }}

{{ stackland-name }} позволяет использовать GPU {{ nvidia }} в кластере {{ stackland-name }} с помощью компонента {{ gpu-operator }}. Компонент автоматизирует управление GPU-ресурсами и обеспечивает их доступность для рабочих нагрузок. Компонент основан на [{{ nvidia }} GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) и включает набор инструментов для полноценной работы с GPU в Kubernetes.

{{ gpu-operator }} решает следующие задачи:

* Автоматическое обнаружение GPU на узлах кластера.
* Предоставление GPU как ресурсов Kubernetes для подов.
* Поддержка технологий виртуализации GPU (Multi-instance GPU, MIG).
* Поддержка создания кластеров GPU c помощью NVLink.
* Мониторинг состояния и сбор метрик GPU.

Для работы {{ gpu-operator }} необходимы узлы с GPU {{ nvidia }}.

## Основные компоненты {#components}

### Драйвер {{ nvidia }} {#nvidia-driver}

Версия: 580.126

Драйвер {{ nvidia }} обеспечивает низкоуровневый интерфейс между операционной системой и GPU. Драйвер предоставляет доступ к аппаратным возможностям GPU, управляет памятью устройства и обрабатывает команды от приложений.

### {{ nvidia }} Container Toolkit {#nvidia-container-toolkit}

Версия: 580.126

{{ nvidia }} Container Toolkit позволяет запускать контейнеры c GPU-ускорением. Toolkit интегрируется с container runtime и обеспечивает доступ GPU к контейнерам через Container Device Interface (CDI). Компонент автоматически настраивает окружение контейнера, монтирует необходимые библиотеки и устройства, а также управляет изоляцией GPU-ресурсов между контейнерами.

### {{ nvidia }} Fabric Manager {#nvidia-fabric-manager}

Версия: 580.126

{{ nvidia }} Fabric Manager управляет NVLink и NVSwitch в системах с несколькими GPU. Компонент обеспечивает высокоскоростное межсоединение между GPU, оптимизирует топологию связей и управляет распределенной памятью в multi-GPU конфигурациях.

### {{ nvidia }} Operator {#nvidia-operator}

Версия: 25.10

{{ nvidia }} {{ gpu-operator }} автоматизирует управление GPU в кластере Kubernetes. Оператор создает, настраивает и управляет компонентами, необходимыми для работы GPU, включая драйверы, библиотеки, плагины устройств и системы мониторинга. Оператор обеспечивает управление жизненным циклом GPU-компонентов через CRD.

### DCGM {#dcgm}

{{ nvidia }} Data Center GPU Manager (DCGM) — инструмент для мониторинга и управления GPU в дата-центрах. DCGM собирает метрики производительности, температуры, утилизации памяти и другие характеристики GPU.

### DCGM Exporter {#dcgm-exporter}

DCGM Exporter экспортирует метрики GPU в формате Prometheus. Метрики автоматически собираются компонентом [Monitoring](monitoring.md) и доступны для визуализации в Grafana.

## Мониторинг GPU {#monitoring}

Метрики GPU автоматически собираются DCGM Exporter и доступны в Grafana. {{ stackland-name }} предоставляет готовые дашборды для мониторинга GPU:

* [{{ nvidia }} DCGM Dashboard](../cluster-monitoring/nvidia-dcgm-monitoring.md) — общий дашборд с метриками всех GPU в кластере.
* [{{ nvidia }} DCGM Dashboard with MIG metrics](../cluster-monitoring/nvidia-dcgm-mig-monitoring.md) — дашборд для мониторинга GPU с MIG.
* [{{ nvidia }} DCGM Dashboard w/o MIG metrics](../cluster-monitoring/nvidia-dcgm-no-mig-monitoring.md) — дашборд для мониторинга GPU без MIG.

## Использование GPU в подах {#usage}

Чтобы использовать GPU в поде, укажите ресурс `nvidia.com/gpu` в спецификации контейнера:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: gpu-pod
spec:
  containers:
  - name: cuda-container
    image: nvidia/cuda:12.0-base
    resources:
      limits:
        nvidia.com/gpu: 1
```

Kubernetes автоматически разместит под на узле с доступным GPU.

## Конфигурация {#configuration}

### Параметры MIG Manager {#mig-settings}

```yaml
migManager:
  enabled: false
  strategy: "single"
  config:
    default: "all-disabled"
```

* `enabled` — включает поддержку Multi-Instance GPU.
* `strategy` — стратегия MIG. Возможные значения: `single` (одна конфигурация MIG на всех GPU узла) или `mixed` (разные конфигурации MIG на разных GPU узла).
* `config.default` — конфигурация MIG по умолчанию.

Чтобы включить поддержку MIG, установите `enabled` в `true` и настройте узел с GPU:

```
kubectl label nodes my-node nvidia.com/mig.config=all-1g.5gb --overwrite
```

Этой командой на узле `my-node` применяется профиль MIG, который делит вычислительные мощности каждой GPU узла на несколько независимых GPU из 1 вычислительного сегмента и 5 ГБ видеопамяти.

Посмотреть все доступные профили MIG можно следующей командой:

```
kubectl -n stackland-nvidia-gpu get cm default-mig-parted-config -o jsonpath='{.data.config\.yaml}'
```

## См. также {#see-also}

* [Monitoring](monitoring.md) — мониторинг кластера и компонентов.
* [Документация GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html).
