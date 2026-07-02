[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Marketplace](../index.md) > Пользователям > [Практические руководства](index.md) > Использование продуктов Cloud Marketplace в Managed Service for Kubernetes > Использование Metrics Provider для трансляции метрик

# Использование Metrics Provider для трансляции метрик

Metrics Provider транслирует метрики объектов [кластера](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) Managed Service for Kubernetes в системы мониторинга и [системы автоматического масштабирования](../../managed-kubernetes/concepts/autoscale.md).

Из этой статьи вы узнаете, как настроить передачу внешних метрик в Horizontal Pod Autoscaler с помощью Metrics Provider.

Чтобы настроить передачу метрик:

1. [Подготовьте рабочее окружение](#create-files).
1. [Установите Metrics Provider и рабочее окружение](#install).
1. [Проверьте работу Metrics Provider](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Подготовьте рабочее окружение {#create-files}

Для проверки работы Metrics Provider будет создано тестовое приложение `nginx` и [Horizontal Pod Autoscaler](../../managed-kubernetes/concepts/autoscale.md#hpa), в который Metrics Provider будет передавать метрики утилизации CPU.
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

1. Создайте файл `hpa.yaml` с манифестом Horizontal Pod Autoscaler `test-hpa`:

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
                 resource_id: "<имя_узла>"
                 resource_type: "vm"
           target:
             type: Value
             value: "20"
   ```

   Имя узла, на котором будут развернуты Metrics Provider и рабочее окружение, можно получить со списком узлов в кластере:

   ```bash
   kubectl get nodes
   ```

## Установите Metrics Provider и рабочее окружение {#install}

1. Установите Metrics Provider по [инструкции](../../managed-kubernetes/operations/applications/metrics-provider.md).
1. Создайте тестовое приложение и Horizontal Pod Autoscaler:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f hpa.yaml
   ```

1. Убедитесь, что [поды](../../managed-kubernetes/concepts/index.md#pod) приложений перешли в состояние `Running`:

   ```bash
   kubectl get pods -n kube-system | grep nginx && \
   kubectl get pods -n kube-system | grep metrics
   ```

   Результат:

   ```text
   nginx-6c********-dbfrn                      1/1     Running   0          2d22h
   nginx-6c********-gckhp                      1/1     Running   0          2d22h
   metrics-server-v0.3.1-6b********-f7dv6      2/2     Running   4          7d3h
   ```

## Проверьте работу Metrics Provider {#validate}

Убедитесь, что Horizontal Pod Autoscaler получает метрики от Metrics Provider и на их основе рассчитывает количество подов приложения `nginx`:

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
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from external metric cpu_usage(&LabelSelector{MatchLabels:map[string]string{resource_id: <имя_узла>,resource_type: vm,service: compute,},MatchExpressions:[]LabelSelectorRequirement{},})
Events:           <none>
```

{% note info %}

Потребуется некоторое время, чтобы Metrics Provider получил метрики от кластера Managed Service for Kubernetes. Если вы столкнулись с ошибкой `unable to get external metric ... no metrics returned from external metrics API`, повторите проверку работы провайдера через несколько минут.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).