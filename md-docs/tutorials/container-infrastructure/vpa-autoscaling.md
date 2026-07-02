[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Контейнерная инфраструктура](index.md) > Managed Service for Kubernetes > Настройка и тестирование масштабирования > Вертикальное масштабирование приложения в кластере

# Вертикальное масштабирование приложения в кластере Yandex Managed Service for Kubernetes

# Вертикальное масштабирование приложения в кластере

Managed Service for Kubernetes поддерживает несколько видов автоматического масштабирования. Из этой статьи вы узнаете, как настроить автоматическое управление ресурсами [пода](../../managed-kubernetes/concepts/index.md#pod) с помощью [Vertical Pod Autoscaler](../../managed-kubernetes/concepts/autoscale.md#vpa):

* [Создайте Vertical Pod Autoscaler и тестовое приложение](#create-vpa-workload).
* [Проверьте работу Vertical Pod Autoscaler](#test-vpa).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) Managed Service for Kubernetes. При создании задайте настройки:

   * Используйте созданные ранее группы безопасности.
   * Если вы планируете работать с кластером в пределах сети Yandex Cloud, выделять кластеру публичный IP-адрес не нужно. Для подключений извне предоставьте кластеру публичный адрес.

1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании задайте настройки:

   * Используйте созданные ранее группы безопасности.
   * Выделите публичный IP-адрес, чтобы предоставить группе узлов доступ в интернет и возможность скачивать Docker-образы и компоненты.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

1. Установите Vertical Pod Autoscaler из [репозитория](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler):

     ```bash
     cd /tmp && \
       git clone https://github.com/kubernetes/autoscaler.git && \
       cd autoscaler/vertical-pod-autoscaler/hack && \
       ./vpa-up.sh
     ```

## Создайте Vertical Pod Autoscaler и тестовое приложение {#create-vpa-workload}

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

1. Создайте файл `vpa.yaml`, содержащий настройки Vertical Pod Autoscaler:

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
       updateMode:  "Recreate"
       minReplicas: 1
   ```

   {% endcut %}

1. Создайте объекты:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f vpa.yaml
   ```

1. Убедитесь, что поды Vertical Pod Autoscaler и `nginx` перешли в состояние `Running`:

   ```bash
   kubectl get pods -n kube-system | grep vpa && \
   kubectl get pods | grep nginx
   ```

   Результат:

   ```text
   vpa-admission-controller-58********-qmxtv  1/1  Running  0  44h
   vpa-recommender-67********-jqvgt           1/1  Running  0  44h
   vpa-updater-64********-xqsts               1/1  Running  0  44h
   nginx-6c********-62j7w                     1/1  Running  0  42h
   ```

## Проверьте работу Vertical Pod Autoscaler {#test-vpa}

Для проверки работы Vertical Pod Autoscaler будет создана имитация рабочей нагрузки на приложение `nginx`.
1. Изучите рекомендации, которые предоставляет Vertical Pod Autoscaler до создания нагрузки:

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

1. Убедитесь, что Vertical Pod Autoscaler управляет ресурсами подов приложения `nginx`:

   ```bash
   kubectl get pod <имя_пода_nginx> --output yaml
   ```

   Результат:

   ```bash
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

    {% note info %}
    
    Если ресурс недоступен по указанному URL, то [убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
    
    {% endnote %}

1. Через несколько минут изучите рекомендации, которые предоставляет Vertical Pod Autoscaler после создания нагрузки:

   ```bash
   kubectl describe vpa nginx
   ```

   Vertical Pod Autoscaler выделил дополнительные ресурсы подам при повышении нагрузки. Обратите внимание на повышение значений `Cpu` в метриках `Status.Recommendation.Container Recommendations`:

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

1. [Удалите кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.