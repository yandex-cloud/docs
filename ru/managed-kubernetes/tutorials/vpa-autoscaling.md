# Вертикальное масштабирование приложения в кластере

{{ managed-k8s-name }} поддерживает несколько видов автоматического масштабирования. Из этой статьи вы узнаете, как настроить автоматическое управление ресурсами [пода](../concepts/index.md#pod) с помощью [{{ k8s-vpa }}](../concepts/autoscale.md#vpa):
* [{#T}](#create-vpa-workload).
* [{#T}](#test-vpa).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте группы безопасности](../operations/connect/security-groups.md) для [мастера {{ k8s }}](../concepts/index.md#master) и [узлов](../concepts/index.md#node-group):
   * `sg-k8s` — для [мастера и группы узлов](../operations/connect/security-groups.md#rules-internal).
   * `k8s-public-services` — для [публичного доступа к сервисам из интернета](../operations/connect/security-groups.md#rules-nodes).
   * `k8s-master-whitelist` — для [доступа к API {{ k8s }}](../operations/connect/security-groups.md#rules-master).
1. [Создайте кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании кластера и группы узлов:
   * Используйте созданные ранее группы безопасности.
   * Выберите автоматический тип назначения [публичного адреса](../../vpc/concepts/address.md#public-addresses).

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Создайте {{ k8s-vpa }} и тестовое приложение {#create-vpa-workload}

1. Создайте файл `app.yaml`, содержащий настройки тестового приложения `nginx` и балансировщика нагрузки:

   {% cut "app.yaml" %}

   ```yaml
   ---
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
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

1. Создайте файл `vpa.yaml`, содержащий настройки {{ k8s-vpa }}:

   {% cut "vpa.yaml" %}

   ```yaml
   ---
   apiVersion: autoscaling.k8s.io/v1
   kind: VerticalPodAutoscaler
   metadata:
     name: nginx
   spec:
     targetRef:
       apiVersion: "apps/v1"
       kind:       Deployment
       name:       nginx
     updatePolicy:
       updateMode: "Auto"
   ```

   {% endcut %}

1. Создайте объекты:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f vpa.yaml
   ```

1. Убедитесь, что поды {{ k8s-vpa }} и `nginx` перешли в состояние `Running`:

   ```bash
   kubectl get pods -n kube-system | grep vpa && \
   kubectl get pods | grep nginx
   ```

   Результат:

   ```text
   vpa-admission-controller-58cf99779c-qmxtv  1/1  Running  0  44h
   vpa-recommender-678f4f6d4b-jqvgt           1/1  Running  0  44h
   vpa-updater-64ddd67787-xqsts               1/1  Running  0  44h
   nginx-6c5cbfc6d9-62j7w                     1/1  Running  0  42h
   nginx-6c5cbfc6d9-6t4nz                     1/1  Running  0  42h
   ```

   {% note info %}

   Для корректной работы {{ k8s-vpa }} требуется как минимум два пода `nginx`.

   {% endnote %}

## Проверьте работу {{ k8s-vpa }} {#test-vpa}

Для проверки работы {{ k8s-vpa }} будет создана имитация рабочей нагрузки на приложение `nginx`.
1. Изучите рекомендации, которые предоставляет {{ k8s-vpa }} до создания нагрузки:

   ```bash
   kubectl describe vpa nginx
   ```

   Обратите внимание на низкие значения `Cpu` в метриках `Status.Recommendation.Container Recommendations`:

   ```yaml
   Name:         nginx
   Namespace:    default
   Labels:       <none>
   Annotations:  <none>
   API Version:  autoscaling.k8s.io/v1
   Kind:         VerticalPodAutoscaler
   ...
   Status:
     Conditions:
       Last Transition Time:  2022-03-18T08:02:04Z
       Status:                True
       Type:                  RecommendationProvided
     Recommendation:
       Container Recommendations:
         Container Name:  nginx
         Lower Bound:
           Cpu:     25m
           Memory:  262144k
         Target:
           Cpu:     25m
           Memory:  262144k
         Uncapped Target:
           Cpu:     25m
           Memory:  262144k
         Upper Bound:
           Cpu:     25m
           Memory:  262144k
   ```

1. Убедитесь, что {{ k8s-vpa }} управляет ресурсами подов приложения `nginx`:

   ```bash
   kubectl get pod <имя одного из подов nginx> --output yaml
   ```

   Результат:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     annotations:
       vpaObservedContainers: nginx
       vpaUpdates: 'Pod resources updated by nginx: container 0: cpu request, memory
         request, cpu limit, memory limit'
   ...
   spec:
     containers:
     ...
       name: nginx
       resources:
         limits:
           cpu: 50m
           memory: 500000Ki
         requests:
           cpu: 25m
           memory: 262144k
   ```

1. В отдельном окне запустите процесс, имитирующий рабочую нагрузку:

   ```bash
   URL=$(kubectl get service nginx -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do wget -q -O- http://$URL; done
   ```

   {% note tip %}

   Чтобы увеличить нагрузку и ускорить выполнение сценария, запустите несколько процессов в отдельных окнах.

   {% endnote %}

1. Через несколько минут изучите рекомендации, которые предоставляет {{ k8s-vpa }} после создания нагрузки:

   ```bash
   kubectl describe vpa nginx
   ```

   {{ k8s-vpa }} выделил дополнительные ресурсы подам при повышении нагрузки. Обратите внимание на повышение значений `Cpu` в метриках `Status.Recommendation.Container Recommendations`:

   ```yaml
   Name:         nginx
   Namespace:    default
   Labels:       <none>
   Annotations:  <none>
   API Version:  autoscaling.k8s.io/v1
   Kind:         VerticalPodAutoscaler
   ...
   Status:
    Conditions:
       Last Transition Time:  2022-03-18T08:02:04Z
       Status:                True
       Type:                  RecommendationProvided
     Recommendation:
       Container Recommendations:
         Container Name:  nginx
         Lower Bound:
           Cpu:     25m
           Memory:  262144k
         Target:
           Cpu:     410m
           Memory:  262144k
         Uncapped Target:
           Cpu:     410m
           Memory:  262144k
         Upper Bound:
           Cpu:     28897m
           Memory:  1431232100
   ```

1. Завершите процесс имитации рабочей нагрузки. В течение нескольких минут значения метрик `Status.Recommendation.Container Recommendations` вернутся к первоначальным.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ k8s }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.