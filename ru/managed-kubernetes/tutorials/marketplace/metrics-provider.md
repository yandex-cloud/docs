# Использование {{ MP }} для трансляции метрик

{{ MP }} транслирует метрики объектов [кластера](../../concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }} в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md).

Из этой статьи вы узнаете, как настроить передачу внешних метрик в {{ k8s-hpa }} с помощью {{ MP }}.

Чтобы настроить передачу метрик:
1. [{#T}](#create-files).
1. [{#T}](#install).
1. [{#T}](#validate).
1. [{#T}](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте кластер {{ managed-k8s-name }} ](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации.

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Подготовьте рабочее окружение {#create-files}

Для проверки работы {{ MP }} будет создано тестовое приложение `nginx` и [{{ k8s-hpa }}](../../concepts/autoscale.md#hpa), в который {{ MP }} будет передавать метрики утилизации CPU.
1. Создайте файл `app.yaml` с манифестом приложения `nginx`:

   {% cut "app.yaml" %}

   ```yaml
   ---
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
     namespace: kube-system
     labels:
       app: nginx
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         name: nginx
         labels:
           app: nginx
       spec:
         containers:
           - name: nginx
             image: registry.k8s.io/hpa-example
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"
   ---
   ### Service
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx
     namespace: kube-system
   spec:
     selector:
       app: nginx
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
     type: LoadBalancer
   ```

   {% endcut %}

1. Создайте файл `hpa.yaml` с манифестом {{ k8s-hpa }} `test-hpa`:

   ```yaml
   apiVersion: autoscaling/v2beta2
   kind: HorizontalPodAutoscaler
   metadata:
     name: test-hpa
     namespace: kube-system
   spec:
     maxReplicas: 2
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: nginx
     metrics:
       - type: External
         external:
           metric:
             name: cpu_usage
             selector:
               matchLabels:
                 service: "compute"
                 resource_id: "<имя узла>"
                 resource_type: "vm"
           target:
             type: Value
             value: "20"
   ```

   Имя узла, на котором будут развернуты {{ MP }} и рабочее окружение, можно получить со списком узлов в кластере:

   ```bash
   kubectl get nodes
   ```

## Установите {{ MP }} и рабочее окружение {#install}

1. Установите {{ MP }} по [инструкции](../../operations/applications/metrics-provider.md).
1. Создайте тестовое приложение и {{ k8s-hpa }}:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f hpa.yaml
   ```

1. Убедитесь, что [поды](../../concepts/index.md#pod) приложений перешли в состояние `Running`:

   ```bash
   kubectl get pods -n kube-system | grep nginx && \
   kubectl get pods -n kube-system | grep metrics
   ```

   Результат:

   ```text
   nginx-6c5cbfc6d9-dbfrn                      1/1     Running   0          2d22h
   nginx-6c5cbfc6d9-gckhp                      1/1     Running   0          2d22h
   metrics-server-v0.3.1-6b998b66d6-f7dv6      2/2     Running   4          7d3h
   ```

## Проверьте работу {{ MP }} {#validate}

Убедитесь, что {{ k8s-hpa }} получает метрики от {{ MP }} и на их основе рассчитывает количество подов приложения `nginx`:

```bash
kubectl -n kube-system describe hpa test-hpa
```

В ожидаемом выводе команды условия `AbleToScale` и `ScalingActive` должны иметь статус `True`:

```text
Name:                          test-hpa
Namespace:                     kube-system
...
Min replicas:                  1
Max replicas:                  2
Deployment pods:               2 current / 2 desired
Conditions:
  Type            Status  Reason            Message
  ----            ------  ------            -------
  AbleToScale     True    ReadyForNewScale  recommended size matches current size
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from external metric cpu_usage(&LabelSelector{MatchLabels:map[string]string{resource_id: <имя узла>,resource_type: vm,service: compute,},MatchExpressions:[]LabelSelectorRequirement{},})
Events:           <none>
```

{% note info %}

Потребуется некоторое время, чтобы {{ MP }} получил метрики от кластера {{ managed-k8s-name }}. Если вы столкнулись с ошибкой `unable to get external metric ... no metrics returned from external metrics API`, повторите проверку работы провайдера через несколько минут.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ managed-k8s-name }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера [публичный статический IP-адрес](../../../vpc/concepts/address.md#public-addresses), [удалите его](../../../vpc/operations/address-delete.md).