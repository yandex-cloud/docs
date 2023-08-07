# Горизонтальное масштабирование приложения в кластере

{{ managed-k8s-name }} поддерживает несколько видов [автоматического масштабирования](../concepts/autoscale.md). Из этой статьи вы узнаете, как настроить автоматическое масштабирование [кластера](../concepts/index.md#kubernetes-cluster) с помощью комбинации {{ k8s-ca }} и {{ k8s-hpa }}.
* [{#T}](#cpu-autoscaling).
* [{#T}](#rps-autoscaling).

{% note warning %}

В процессе работы общее количество [узлов в группах](../concepts/index.md#node-group) может вырасти до шести. Убедитесь, что у вас достаточно [ресурсов каталога](../concepts/limits.md) для выполнения инструкций из этого руководства.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для [мастера](../concepts/index.md#master) и групп узлов и [назначьте им роли](../../iam/operations/sa/assign-role-for-sa.md).
   * Сервисный аккаунт `sa-k8s-master` для управления кластером:
     * `k8s.clusters.agent` — для управления кластером {{ k8s }}.
     * `load-balancer.admin` — для управления [сетевым балансировщиком нагрузки](../../network-load-balancer/).
   * Сервисный аккаунт `sa-k8s-nodes` для управления группой узлов:
     * `container-registry.images.puller` — для загрузки образов из [{{ container-registry-full-name }}](../../container-registry/).
1. [Создайте сеть](../../vpc/quickstart.md) с именем `k8s-network` для размещения кластера. При создании сети выберите опцию **Создать подсети**.
1. [Создайте группы безопасности](../operations/connect/security-groups.md) для мастера и узлов:
   * `sg-k8s` — для [мастера и группы узлов](../operations/connect/security-groups.md#rules-internal).
   * `k8s-public-services` — для обеспечения [публичного доступа к сервисам из интернета](../operations/connect/security-groups.md#rules-nodes).
   * `k8s-master-whitelist` — для [доступа к API {{ k8s }}](../operations/connect/security-groups.md#rules-master).
1. [Создайте ключ шифрования](../../kms/operations/key.md#create):
   * **Имя ключа** — `k8s-symetric-key`.
   * **Алгоритм шифрования** — `AES-128`.
   * **Период ротации** — 365 дней.
1. [Создайте кластер {{ managed-k8s-name }} ](../operations/kubernetes-cluster/kubernetes-cluster-create.md) со следующими настройками:
   * **Сервисный аккаунт для ресурсов** — `sa-k8s-master`.
   * **Сервисный аккаунт для узлов** — `sa-k8s-nodes`.
   * **Ключ шифрования** — `k8s-symetric-key`.
   * **Релизный канал** — `RAPID`.
   * **Публичный адрес** — `Автоматически`.
   * **Тип мастера** — `Региональный`.
   * **Облачная сеть** — `k8s-network`.
   * **Группы безопасности** — `sg-k8s`, `k8s-master-whitelist`.
   * **Включить туннельный режим** — включено.
1. [Создайте две группы узлов](../operations/node-group/node-group-create.md) в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b` со следующими настройками:
   * В блоке **Масштабирование**:
     * **Тип** — `Автоматический`.
     * **Минимальное кол-во узлов** — `1`.
     * **Максимальное кол-во узлов** — `3`.
     * **Начальное кол-во узлов** — `1`.
   * В блоке **Сетевые настройки**:
     * **Публичный адрес** — `Автоматически`.
     * **Группы безопасности** — `sg-k8s`, `k8s-public-services`.
     * **Расположение** — `{{ region-id }}-a` или `{{ region-id }}-b`.

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Масштабирование от утилизации CPU {#cpu-autoscaling}

Из этого раздела вы узнаете, как настроить автоматическое масштабирование кластера в зависимости от нагрузки на CPU.
1. Создайте файл `k8s-autoscale-CPU.yaml`, который содержит настройки тестового приложения, балансировщика нагрузки и [{{ k8s-hpa }}](../concepts/autoscale.md#hpa):

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

1. В отдельном окне запустите отслеживание нагрузки на компоненты {{ k8s }}:

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

  В течение нескольких минут {{ k8s-hpa }} увеличит количество подов на узлах из-за роста потребления CPU. Когда текущих ресурсов кластера будет недостаточно, чтобы удовлетворить значение `requests`, {{ k8s-ca}} увеличит количество узлов в группах.
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
   git clone https://github.com/yandex-cloud/yc-architect-solution-library.git && \
     cd yc-architect-solution-library/demos/yc-k8s-autoscaling
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

1. Создайте тестовое приложение, правило Ingress и [{{ k8s-hpa }}](../concepts/autoscale.md#hpa):

   ```bash
   kubectl apply -f k8s_autoscale-RPS.yaml
   ```

   После создания объектов в Prometheus появится новая метрика `nginx_ingress_controller_requests_per_second`. Prometheus начнет считать эту метрику только после прохождения трафика через Ingress-контроллер.
1. Выполните несколько тестовых запросов к Ingress-контроллеру:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     curl -H "Host: nginx.example.com" http://$URL
   ```

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

1. В отдельном окне запустите отслеживание нагрузки на компоненты {{ k8s }}:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Запустите процесс, который имитирует рабочую нагрузку:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do curl -H "Host: nginx.example.com" http://$URL; done
   ```

   В течение нескольких минут {{ k8s-hpa }} увеличит количество подов на узлах из-за роста количества запросов к приложению. Когда текущих ресурсов кластера будет недостаточно, чтобы удовлетворить значение `requests`, {{ k8s-ca}} увеличит количество узлов в группах.
1. Завершите процесс имитации рабочей нагрузки. В течение нескольких минут количество узлов и подов вернется к начальному состоянию.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ k8s }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.