[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Практические руководства](index.md) > Настройка и тестирование масштабирования > Горизонтальное масштабирование приложения в кластере

# Горизонтальное масштабирование приложения в кластере


Managed Service for Kubernetes поддерживает несколько видов [автоматического масштабирования](../concepts/autoscale.md). Из этой статьи вы узнаете, как настроить автоматическое масштабирование [кластера](../concepts/index.md#kubernetes-cluster) с помощью комбинации Cluster Autoscaler и Horizontal Pod Autoscaler.

* [Масштабирование от утилизации CPU](#cpu-autoscaling).
* [Масштабирование от количества запросов к приложению](#rps-autoscaling).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note warning %}

В процессе работы общее количество [узлов в группах](../concepts/index.md#node-group) может вырасти до шести. Убедитесь, что у вас достаточно [ресурсов каталога](../concepts/limits.md) для выполнения инструкций из этого руководства.

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис Key Management Service: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций ([тарифы Key Management Service](../../kms/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для [мастера](../concepts/index.md#master) и групп узлов и [назначьте им роли](../../iam/operations/sa/assign-role-for-sa.md).
   * Сервисный аккаунт `sa-k8s-master` для управления кластером:
     * `k8s.clusters.agent` — для управления кластером Kubernetes.
     * `load-balancer.admin` — для управления [сетевым балансировщиком нагрузки](../../network-load-balancer/index.md).
   * Сервисный аккаунт `sa-k8s-nodes` для управления группой узлов:
     * `container-registry.images.puller` — для загрузки образов из [Yandex Container Registry](../../container-registry/index.md).
1. [Создайте сеть](../../vpc/quickstart.md) с именем `k8s-network` для размещения кластера. При создании сети выберите опцию **Создать подсети**.

1. [Создайте группы безопасности](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте ключ шифрования](../../kms/operations/key.md#create):
   * **Имя** — `k8s-symetric-key`.
   * **Алгоритм шифрования** — `AES-128`.
   * **Период ротации, дни** — `365 дней`.
1. [Создайте кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md) со следующими настройками:
   * **Сервисный аккаунт для ресурсов** — `sa-k8s-master`.
   * **Сервисный аккаунт для узлов** — `sa-k8s-nodes`.
   * **Ключ шифрования** — `k8s-symetric-key`.
   * **Релизный канал** — `RAPID`.
   * **Публичный адрес** — `Автоматически`.
   * **Тип мастера** — `Высокодоступный`.
   * **Облачная сеть** — `k8s-network`.
   * **Группы безопасности** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика и для доступа к API Kubernetes.
   * **Сilium CNI** — `Включено`.
1. [Создайте две группы узлов](../operations/node-group/node-group-create.md) в зонах доступности `ru-central1-a` и `ru-central1-b` со следующими настройками:
   * В блоке **Масштабирование**:
     * **Тип** — `Автоматический`.
     * **Минимальное кол-во узлов** — `1`.
     * **Максимальное кол-во узлов** — `3`.
     * **Начальное кол-во узлов** — `1`.
   * В блоке **Сетевые настройки**:
     * **Публичный адрес** — `Автоматически`.
     * **Группы безопасности** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика, для подключения к сервисам из интернета и для подключения к узлам по SSH.
     * **Расположение** — `ru-central1-a` или `ru-central1-b`.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

## Масштабирование от утилизации CPU {#cpu-autoscaling}

Из этого раздела вы узнаете, как настроить автоматическое масштабирование кластера в зависимости от нагрузки на CPU.
1. Создайте файл `k8s-autoscale-CPU.yaml`, который содержит настройки тестового приложения, балансировщика нагрузки и [Horizontal Pod Autoscaler](../concepts/autoscale.md#hpa):

   {% cut "k8s-autoscale-CPU.yaml" %}

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
   ---
   ### HPA
   apiVersion: autoscaling/v1
   kind: HorizontalPodAutoscaler
   metadata:
     name: nginx
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: nginx
     minReplicas: 1
     maxReplicas: 10
     targetCPUUtilizationPercentage: 20
   ```

   {% endcut %}

1. Создайте объекты:

   ```bash
   kubectl apply -f k8s-autoscale-CPU.yaml
   ```

1. В отдельном окне запустите отслеживание нагрузки на компоненты Kubernetes:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Запустите процесс, имитирующий рабочую нагрузку:

   ```bash
   URL=$(kubectl get service nginx -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do wget -q -O- http://$URL; done
   ```

   {% note tip %}

   Чтобы увеличить нагрузку и ускорить выполнение сценария, запустите несколько процессов в отдельных окнах.

   {% endnote %}

    {% note info %}
    
    Если ресурс недоступен по указанному URL, то [убедитесь](../operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
    
    {% endnote %}

   В течение нескольких минут Horizontal Pod Autoscaler увеличит количество подов на узлах из-за роста потребления CPU. Когда текущих ресурсов кластера будет недостаточно, чтобы удовлетворить значение `requests`, Cluster Autoscaler увеличит количество узлов в группах.
1. Завершите процесс имитации рабочей нагрузки. В течение нескольких минут количество узлов и подов вернется к начальному состоянию.

## Масштабирование от количества запросов к приложению {#rps-autoscaling}

Из этого раздела вы узнаете, как настроить автоматическое масштабирование кластера в зависимости от количества запросов к приложению (_Requests Per Second, RPS_).

### Алгоритм работы {#how-it-works}

1. Ingress-контроллер передает в [систему мониторинга Prometheus](https://prometheus.io/) информацию о количестве запросов к приложению.
1. Prometheus создает и публикует метрику `nginx_ingress_controller_requests_per_second` — количество запросов к приложению за секунду.

   Чтобы создать такую метрику, в конфигурационный файл Prometheus `values-prom.yaml` добавлено правило:

   ```yaml
   rules:
     groups:
       - name: Ingress
         rules:
           - record: nginx_ingress_controller_requests_per_second
             expr: rate(nginx_ingress_controller_requests[2m])
   ```

1. На основании данных метрики [средства автоматического масштабирования](../concepts/autoscale.md) вносят изменения в количество подов и узлов.

### Установка объектов {#create-objects}

1. Клонируйте GitHub-репозиторий, который содержит актуальные конфигурационные файлы:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-mk8s-autoscaling-solution.git && \
   cd yc-mk8s-autoscaling-solution
   ```

1. Добавьте репозитории Helm, которые содержат Ingress-контроллер и систему мониторинга Prometheus:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
   helm repo update
   ```

1. Установите Ingress-контроллер:

   ```bash
   helm upgrade \
     --install rps ingress-nginx/ingress-nginx \
     --values values-ingr.yaml
   ```

1. Установите Prometheus:

   ```bash
   helm upgrade \
     --install prometheus prometheus-community/prometheus \
     --values values-prom.yaml
   ```

1. Установите [Prometheus-адаптер](https://github.com/kubernetes-sigs/prometheus-adapter), с помощью которого средства автоматического масштабирования будут получать метрики из Prometheus:

   ```bash
   helm upgrade \
     --install prometheus-adapter prometheus-community/prometheus-adapter \
     --values values-prom-ad.yaml
   ```

1. Создайте тестовое приложение, правило Ingress и [Horizontal Pod Autoscaler](../concepts/autoscale.md#hpa):

   ```bash
   kubectl apply -f k8s_autoscale-RPS.yaml
   ```

   После создания объектов в Prometheus появится новая метрика `nginx_ingress_controller_requests_per_second`. Prometheus начнет считать эту метрику только после прохождения трафика через Ingress-контроллер.
1. Выполните несколько тестовых запросов к Ingress-контроллеру:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     curl --header "Host: nginx.example.com" http://$URL
   ```

    {% note info %}
    
    Если ресурс недоступен по указанному URL, то [убедитесь](../operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
    
    {% endnote %}

1. Убедитесь, что метрика `nginx_ingress_controller_requests_per_second` доступна:

   ```bash
   kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | jq . | \
     grep ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second
   ```

   Результат:

   ```text
   "name": "ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second",
   ```

### Проверка автоматического масштабирования {#test-rps-autoscaling}

1. В отдельном окне запустите отслеживание нагрузки на компоненты Kubernetes:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Запустите процесс, который имитирует рабочую нагрузку:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do curl --header "Host: nginx.example.com" http://$URL; done
   ```

    {% note info %}
    
    Если ресурс недоступен по указанному URL, то [убедитесь](../operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
    
    {% endnote %}

   В течение нескольких минут Horizontal Pod Autoscaler увеличит количество подов на узлах из-за роста количества запросов к приложению. Когда текущих ресурсов кластера будет недостаточно, чтобы удовлетворить значение `requests`, Cluster Autoscaler увеличит количество узлов в группах.
1. Завершите процесс имитации рабочей нагрузки. В течение нескольких минут количество узлов и подов вернется к начальному состоянию.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.