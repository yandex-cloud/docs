# Изменение параметров сервера метрик

[Сервер метрик (Metrics Server)](https://github.com/kubernetes-sigs/metrics-server) — это сервис в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster), устанавливаемый по умолчанию. С помощью компонента `kubelet` он собирает метрики с каждого [узла](../concepts/index.md#node-group) в кластере и предоставляет их через [Metrics API](https://github.com/kubernetes/metrics). На основании данных из этих метрик работают [горизонтальное и вертикальное автомасштабирования подов](../concepts/autoscale.md). Данные метрик можно получить с помощью команд `kubectl top node` или `kubectl top pod`. Подробнее см. в [документации Metrics Server](https://github.com/kubernetes-sigs/metrics-server#kubernetes-metrics-server).

[Под](../concepts/index.md#pod) сервера метрик содержит два контейнера: `metrics-server` и `metrics-server-nanny`, который является [addon-resizer](https://github.com/kubernetes/autoscaler/tree/master/addon-resizer#addon-resizer) для `metrics-server`. Контейнер `metrics-server-nanny` отвечает за автоматическое выделение ресурсов контейнеру `metrics-server` в зависимости от количества узлов в кластере {{ managed-k8s-name }}.

В некоторых случаях компонент `metrics-server-nanny` может работать некорректно. Например, если при малом количестве узлов в кластере {{ managed-k8s-name }} создано большое количество подов. В этом случае под сервера метрик превысит свои лимиты, что может вызвать снижение производительности сервера метрик.

Чтобы избежать этого, измените параметры сервера метрик вручную:
1. [{#T}](#get-resources).
1. [{#T}](#update-parameters).
1. [{#T}](#check-result).

Чтобы вернуть параметры сервера метрик до значений по умолчанию, [сбросьте их](#reset).

## Посмотрите количество ресурсов, выделенных для пода сервера метрик {#get-resources}

Выполните команду:

```bash
kubectl get pod <имя пода сервера метрик> \
  --namespace=kube-system \
  --output=json | \
  jq '.spec.containers[] | select(.name == "metrics-server") | .resources'
```

Ресурсы вычисляются по следующим формулам:

```text
cpu = baseCPU + cpuPerNode * nodesCount
memory = baseMemory + memoryPerNode * nodesCount
```

Где:
* `baseCPU` — базовое количество CPU.
* `cpuPerNode` — количество CPU на каждый узел.
* `nodesCount` — количество узлов.
* `baseMemory` — базовое количество оперативной памяти.
* `memoryPerNode` — количество оперативной памяти на каждый узел.

## Измените параметры сервера метрик {#update-parameters}

1. Откройте конфигурационный файл сервера метрик:

   ```bash
   kubectl edit configmap metrics-server-config \
     --namespace=kube-system \
     --output=yaml
   ```

1. Добавьте или измените параметры ресурсов в блоке `data.NannyConfiguration`:

   ```yaml
   apiVersion: v1
   data:
     NannyConfiguration: |-
       apiVersion: nannyconfig/v1alpha1
       kind: NannyConfiguration
       baseCPU: <базовое количество CPU>m
       cpuPerNode: <количество CPU за каждый узел>m
       baseMemory: <базовое количество оперативной памяти>Mi
       memoryPerNode: <количество оперативной памяти за каждый узел>Mi
   ...
   ```

   {% cut "Пример конфигурационного файла" %}

   ```yaml
   apiVersion: v1
   data:
     NannyConfiguration: |-
       apiVersion: nannyconfig/v1alpha1
       kind: NannyConfiguration
       baseCPU: 48m
       cpuPerNode: 1m
       baseMemory: 104Mi
       memoryPerNode: 3Mi
   kind: ConfigMap
   metadata:
     creationTimestamp: "2022-12-15T06:28:22Z"
     labels:
       addonmanager.kubernetes.io/mode: EnsureExists
     name: metrics-server-config
     namespace: kube-system
     resourceVersion: "303569"
     uid: 931b88ca-21da-4d04-a3c1-da7e8c95cc47
   ```

   {% endcut %}

1. Перезапустите сервис сервер метрик. Для этого удалите его и подождите пока контроллер {{ k8s }} создаст его заново:

   ```bash
   kubectl delete deployment metrics-server \
     --namespace=kube-system
   ```

## Проверьте результат {#check-result}

Снова [посмотрите](#get-resources) количество ресурсов, выделенных для пода сервера метрик, и убедитесь, что для нового пода оно изменилось.

## Сбросьте параметры сервера метрик {#reset}

Чтобы сбросить параметры до значений по умолчанию, удалите конфигурационный файл сервера метрик и его Deployment:

```bash
kubectl delete configmap metrics-server-config \
  --namespace=kube-system && \
kubectl delete deployment metrics-server \
  --namespace=kube-system
```

После выполнения команд новый под сервера метрик будет создан автоматически.