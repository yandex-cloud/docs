# Горизонтальное масштабирование приложения в кластере


{{ managed-k8s-name }} поддерживает несколько видов [автоматического масштабирования](../../managed-kubernetes/concepts/autoscale.md). Из этой статьи вы узнаете, как настроить автоматическое масштабирование [кластера](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью комбинации {{ k8s-ca }} и {{ k8s-hpa }}.

* [Масштабирование от утилизации CPU](#cpu-autoscaling).
* [Масштабирование от количества запросов к приложению](#rps-autoscaling).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note warning %}

В процессе работы общее количество [узлов в группах](../../managed-kubernetes/concepts/index.md#node-group) может вырасти до шести. Убедитесь, что у вас достаточно [ресурсов каталога](../../managed-kubernetes/concepts/limits.md) для выполнения инструкций из этого руководства.

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис {{ kms-name }}: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций (см. [тарифы {{ kms-name }}](../../kms/pricing.md)).


## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для [мастера](../../managed-kubernetes/concepts/index.md#master) и групп узлов и [назначьте им роли](../../iam/operations/sa/assign-role-for-sa.md).
   * Сервисный аккаунт `sa-k8s-master` для управления кластером:
     * `k8s.clusters.agent` — для управления кластером {{ k8s }}.
     * `load-balancer.admin` — для управления [сетевым балансировщиком нагрузки](../../network-load-balancer/).
   * Сервисный аккаунт `sa-k8s-nodes` для управления группой узлов:
     * `container-registry.images.puller` — для загрузки образов из [{{ container-registry-full-name }}](../../container-registry/).
1. [Создайте сеть](../../vpc/quickstart.md) с именем `k8s-network` для размещения кластера. При создании сети выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте ключ шифрования](../../kms/operations/key.md#create):
   * **{{ ui-key.yacloud.common.name }}** — `k8s-symetric-key`.
   * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** — `AES-128`.
   * **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** — `365 дней`.
1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) со следующими настройками:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** — `sa-k8s-master`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** — `sa-k8s-nodes`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** — `k8s-symetric-key`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_release-channel }}** — `RAPID`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** — `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** — `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-highly-available }}`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** — `k8s-network`.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика и для доступа к API {{ k8s }}.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}** — `{{ ui-key.yacloud.common.enabled }}`.
1. [Создайте две группы узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b` со следующими настройками:
   * В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-type }}** — `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}** — `1`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}** — `3`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** — `1`.
   * В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** — `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`.
     * **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика, для подключения к сервисам из интернета и для подключения к узлам по SSH.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_locations }}** — `{{ region-id }}-a` или `{{ region-id }}-b`.

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Масштабирование от утилизации CPU {#cpu-autoscaling}

Из этого раздела вы узнаете, как настроить автоматическое масштабирование кластера в зависимости от нагрузки на CPU.
1. Создайте файл `k8s-autoscale-CPU.yaml`, который содержит настройки тестового приложения, балансировщика нагрузки и [{{ k8s-hpa }}](../../managed-kubernetes/concepts/autoscale.md#hpa):

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

    {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

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

1. На основании данных метрики [средства автоматического масштабирования](../../managed-kubernetes/concepts/autoscale.md) вносят изменения в количество подов и узлов.

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

1. Создайте тестовое приложение, правило Ingress и [{{ k8s-hpa }}](../../managed-kubernetes/concepts/autoscale.md#hpa):

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

    {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

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
     while true; do curl --header "Host: nginx.example.com" http://$URL; done
   ```

    {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   В течение нескольких минут {{ k8s-hpa }} увеличит количество подов на узлах из-за роста количества запросов к приложению. Когда текущих ресурсов кластера будет недостаточно, чтобы удовлетворить значение `requests`, {{ k8s-ca}} увеличит количество узлов в группах.
1. Завершите процесс имитации рабочей нагрузки. В течение нескольких минут количество узлов и подов вернется к начальному состоянию.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ k8s }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.
