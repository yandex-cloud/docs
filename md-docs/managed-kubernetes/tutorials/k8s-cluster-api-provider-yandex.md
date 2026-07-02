[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Практические руководства](index.md) > Создание кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API

# Создание управляемого пользователем (self-managed) кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API

# Создание управляемого пользователем (self-managed) кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API

[Сluster-api-provider-yandex](https://github.com/yandex-cloud/cluster-api-provider-yandex) — провайдер для развертывания управляемого пользователем (self-managed) кластера Kubernetes в облачной инфраструктуре Yandex Cloud с помощью [Kubernetes Cluster API](https://cluster-api.sigs.k8s.io/).

Кластер разворачивается на базе [виртуальных машин](../../compute/concepts/vm.md) Yandex Compute Cloud и [L7-балансировщика](../../application-load-balancer/concepts/application-load-balancer.md) Yandex Application Load Balancer.

**Преимущества использования провайдера Yandex Cloud для создания кластера:** {#advantages}

* Интеграция с [API Yandex Cloud](../../api-design-guide/concepts/general.md).
* Декларативный подход к созданию кластера и управлению им.
* Возможность описать кластер как пользовательский ресурс — [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/).
* Широкий спектр параметров для конфигурации вычислительных ресурсов кластера.
* [Пользовательские образы](#prepare-os-image) операционных систем для мастера и узлов.
* Пользовательский Control Plane.
* Альтернатива [Terraform](https://www.terraform.io/) в CI-процессах.

**Совместимость провайдера с Kubernetes Cluster API** {#compatibility}

| Версия провайдера | Версия Cluster API |
| :---: | :---: |
| v1alpha1 | v1beta1 (v1.x) |

Чтобы развернуть кластер Kubernetes в Yandex Cloud с помощью Cluster API:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте окружение](#prepare-environment).
1. [Подготовьте образ операционной системы для узлов кластера](#prepare-os-image).
1. [Получите Docker-образ с провайдером Yandex Cloud](#get-docker-image).
1. [Установите провайдер Yandex Cloud и провайдер Kubernetes Cluster API](#install-providers).
1. [Сформируйте манифесты кластера](#prepare-manifests).
1. [Разверните кластер](#create-cluster).
1. [Подключитесь к кластеру](#connect-to-cluster).
1. [Установите CCM](#install-ccm).
1. [Установите CNI](#install-cni).
1. [Проверьте связь управляющего кластера с созданным](#check-connection).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за вычислительные ресурсы и диски ВМ, на базе которых разворачивается кластер Kubernetes, вспомогательной ВМ, а также узлов управляющего кластера Managed Service for Kubernetes ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Yandex Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за использование мастера управляющего кластера Managed Service for Kubernetes и исходящий трафик ([тарифы Yandex Managed Service for Kubernetes](../pricing.md)).
* Плата за [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) для вспомогательной ВМ и управляющего кластера Managed Service for Kubernetes ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за использование [NAT-шлюза](../../vpc/concepts/gateways.md) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#nat-gateways)).

#### Опциональные траты {#optional-expenses}

* Если для узлов создаваемого кластера Kubernetes вы будете использовать собственный образ:
  * Плата за хранение образа в бакете и операции с данными ([тарифы Yandex Object Storage](../../storage/pricing.md)).
  * Плата за хранение образа в Compute Cloud ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Если для развертывания провайдера Yandex Cloud в управляющем кластере вы будете использовать собственный Docker-образ — плата за хранение Docker-образа в реестре и исходящий трафик ([тарифы Yandex Container Registry](../../container-registry/pricing.md)).

### Подготовьте инфраструктуру {#infra}

1. Подготовьте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) Yandex Cloud:
    1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будут создаваться ресурсы кластера.
    1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли [compute.editor](../../compute/security/index.md#compute-editor) и [alb.editor](../../application-load-balancer/security/index.md#alb-editor) на каталог.
    1. [Создайте](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) авторизованный ключ для сервисного аккаунта в формате JSON.
1. Если в вашем каталоге еще нет [облачной сети](../../vpc/concepts/network.md#network) Virtual Private Cloud, [создайте](../../vpc/operations/network-create.md) ее. Также [создайте](../../vpc/operations/subnet-create.md) и подсеть.

    {% note warning %}
    
    Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
    
    {% endnote %}

1. Инфраструктуре создаваемого кластера будет автоматически назначена [группа безопасности](../../vpc/concepts/security-groups.md) по умолчанию, которая создается вместе с сетью. [Добавьте](../../vpc/operations/security-group-add-rule.md) в эту группу следующие правила для _входящего_ трафика:

    Протокол | Диапазон портов | Тип источника | Источник | Описание
    --- | --- | --- | --- | ---
    `TCP` | `0-65535` | `Группа безопасности` | `Balancer` | `Проверки состояния L7-балансировщиком`
    `Any` | `8443` | `CIDR` | `0.0.0.0/0` | `Доступ к Kubernetes API`

1. Создаваемый кластер будет доступен в облачной сети по [внутреннему IP-адресу](../../vpc/concepts/address.md#internal-addresses). Чтобы обеспечить удаленный доступ к кластеру:
    1. [Создайте](../../compute/operations/vm-create/create-linux-vm.md) в той же сети, в которой будет развернут кластер, вспомогательную ВМ с публичным IP-адресом и с группой безопасности по умолчанию.
    1. Установите на вспомогательную ВМ утилиту [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl).
1. Создайте _управляющий_ [кластер](../operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes с публичным IP-адресом и [группу узлов](../operations/node-group/node-group-create.md). Кластер потребуется для развертывания нового кластера с помощью Cluster API и управления кластерной инфраструктурой.

    {% note tip %}

    Управляющий кластер также можно развернуть локально, например, с помощью [утилиты `kind`](https://kind.sigs.k8s.io/).

    {% endnote %}

1. Чтобы создаваемый кластер имел доступ в интернет и мог загружать Docker-образы, [настройте](../../vpc/operations/create-nat-gateway.md) NAT-шлюз для подсети, в которой будет расположен новый кластер.

## Настройте окружение {#prepare-environment}

Окружение настраивается на локальном компьютере.

1. Установите инструменты:
    * [Go](https://go.dev/doc/install) версии 1.22.0 или выше.
    * [Docker](https://www.docker.com/) версии 17.03 или выше.
    * [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) версии 1.11.3 или выше.
    * [clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start#install-clusterctl) версии 1.5.0 или выше.

1. [Настройте](../operations/connect/index.md#kubectl-connect) для `kubectl` доступ к управляющему кластеру Managed Service for Kubernetes.

    Если вы разворачивали управляющий кластер локально с помощью утилиты `kind`, настройте к нему доступ [по инструкции](https://kind.sigs.k8s.io/docs/user/quick-start/#interacting-with-your-cluster).

1. Склонируйте репозиторий [cluster-api-provider-yandex](https://github.com/yandex-cloud/cluster-api-provider-yandex) и перейдите в директорию с проектом:

    ```bash
    git clone https://github.com/yandex-cloud/cluster-api-provider-yandex.git
    cd cluster-api-provider-yandex
    ```
    
## Подготовьте образ операционной системы для узлов кластера {#prepare-os-image}

[Образ](../../compute/concepts/image.md) ОС, который будет развернут на узлах создаваемого кластера, должен быть подготовлен для работы с Kubernetes Cluster API и совместим с Compute Cloud.

Вы можете использовать готовый тестовый образ или собрать собственный:

{% list tabs %}

- Готовый образ

  Чтобы использовать тестовый образ ОС на основе Ubuntu 24.04, подготовленный для работы с Kubernetes версии 1.31.4, при [формировании манифеста кластера](#prepare-manifests) в переменной `YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID` укажите идентификатор образа `fd8a3kknu25826s8hbq3`.

  {% note warning %}

  Образ создан в ознакомительных целях, не используйте его в промышленной эксплуатации.

  {% endnote %}

- Собственный образ

  1. [Соберите](https://image-builder.sigs.k8s.io/capi/capi) образ ОС с помощью утилиты [Image Builder](https://github.com/kubernetes-sigs/image-builder).

      Смотрите также [Подготовить образ диска для Compute Cloud](../../compute/operations/image-create/custom-image.md).
  1. [Загрузите](../../compute/operations/image-create/upload.md) образ в Compute Cloud и сохраните его идентификатор.

{% endlist %}

## Получите Docker-образ с провайдером Yandex Cloud {#get-docker-image}

Вы можете использовать готовый Docker-образ с провайдером Yandex Cloud из публичного [реестра](../../container-registry/concepts/registry.md) Yandex Container Registry или собрать его самостоятельно из исходного кода.

{% list tabs %}

- Готовый образ

  1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md#cred-helper) в реестре Container Registry с помощью [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).
  1. Добавьте в переменную окружения `IMG` путь к Docker-образу с провайдером Yandex Cloud в публичном реестре:

      ```bash
      export IMG=cr.yandex/crpsjg1coh47p81vh2lc/capy/cluster-api-provider-yandex:latest
      ```

- Образ из исходного кода

  1. [Создайте](../../container-registry/operations/registry/registry-create.md) реестр Container Registry и сохраните его идентификатор.
  1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md#cred-helper) в реестре Container Registry с помощью [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).
  1. Добавьте в переменную окружения `IMG` путь, по которому собранный Docker-образ будет сохранен в реестре:

      ```bash
      export IMG=cr.yandex/<идентификатор_реестра>/cluster-api-provider-yandex:<тег>
      ```

  1. Если вы собираете Docker-образ на компьютере с архитектурой, отличной от [AMD64](https://ru.wikipedia.org/wiki/X86-64), отредактируйте в [Makefile](https://github.com/yandex-cloud/cluster-api-provider-yandex/blob/master/Makefile) блок `docker-build`:

      ```text
      docker build --platform linux/amd64 -t ${IMG} .
      ```

  1. Запустите Docker daemon.
  1. Соберите Docker-образ и загрузите его в реестр:

      ```bash
      make docker-build docker-push
      ```

{% endlist %}

## Установите провайдер Yandex Cloud и провайдер Kubernetes Cluster API {#install-providers}

1. Инициализируйте управляющий кластер:

    ```bash
    clusterctl init
    ```

    В управляющий кластер будут установлены основные компоненты Kubernetes Cluster API и [cert-manager](https://cert-manager.io/).

1. Создайте в управляющем кластере описание пользовательского ресурса — [CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) (CRD) для создаваемого кластера:

    ```bash
    make install
    ```

1. Получите список установленных CRD:

    ```bash
    kubectl get crd | grep cluster.x-k8s.io
    ```

    Чтобы получить манифест конкретного CRD, выполните команду:

    ```bash
    kubectl get crd <имя_CRD> \
      --output yaml
    ```

1. Создайте пространство имен для провайдера Yandex Cloud:

    ```bash
    kubectl create namespace capy-system
    ```

1. Создайте секрет с авторизованным ключом сервисного аккаунта Yandex Cloud:

    ```bash
    kubectl create secret generic yc-sa-key \
      --from-file=key=<путь_к_файлу_с_авторизованным_ключом> \
      --namespace capy-system
    ```

1. Установите провайдер Yandex Cloud:

    ```bash
    make deploy
    ```

## Сформируйте манифесты кластера {#prepare-manifests}

1. Получите идентификаторы ресурсов Yandex Cloud для развертывания кластера:
    * [Образ ОС](../../compute/operations/image-control/image-control-get-info.md).
    * [Каталог](../../resource-manager/operations/folder/get-id.md).
    * [Зона доступности](../../overview/concepts/geo-scope.md).
    * [Сеть](../../vpc/operations/network-get-info.md).
    * [Подсеть](../../vpc/operations/subnet-get-info.md) в выбранной зоне доступности.

1. Передайте идентификаторы ресурсов в переменные окружения:

    ```bash
    export YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID=<идентификатор_образа>
    export YANDEX_FOLDER_ID=<идентификатор_каталога>
    export YANDEX_NETWORK_ID=<идентификатор_сети>
    export YANDEX_SUBNET_ID=<идентификатор_подсети>
    export YANDEX_ZONE_ID=<идентификатор_зоны_доступности>
    ```

    Если вы [не собирали свой образ ОС](#prepare-os-image), в переменной `YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID` укажите значение `fd8a3kknu25826s8hbq3`. Это идентификатор тестового образа на основе Ubuntu 24.04, подходящего для работы с Kubernetes версии 1.31.4.

1. Сформируйте манифесты кластера:

    ```bash
    clusterctl generate cluster <имя_создаваемого_кластера> \
      --from templates/cluster-template.yaml > /tmp/capy-cluster.yaml
    ```

    В манифесте `capy-cluster.yaml` будут описаны:
    * L7-балансировщик Application Load Balancer с динамическим внутренним IP-адресом. Ему можно [присвоить фиксированный IP-адрес](#configure-endpoint).

        {% note warning %}

        * После создания кластера присвоить L7-балансировщику фиксированный IP-адрес будет нельзя.
        * Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

        {% endnote %}

    * Три узла с Control Plane кластера.

1. (Опционально) Чтобы сразу развернуть узлы кластера для рабочей нагрузки, добавьте в манифест их описание:

    ```bash
    clusterctl generate cluster <имя_создаваемого_кластера> \
        --worker-machine-count <количество_узлов_для_рабочей_нагрузки> \
        --from templates/cluster-template.yaml > /tmp/capy-cluster.yaml
    ```

### (Опционально) Настройте эндпоинт API-сервера {#configure-endpoint}

Задайте в манифесте `capy-cluster.yaml` параметры для L7-балансировщика:

```yaml
  loadBalancer:
    listener:
      address: <фиксированный_IP-адрес_из_диапазона_подсети>
      subnet:
        id: <идентификатор_подсети>
```

## Разверните кластер {#create-cluster}

Выполните команду:

```bash
kubectl apply -f /tmp/capy-cluster.yaml
```

За созданием кластера можно следить в [консоли управления](https://console.yandex.cloud) Yandex Cloud и в логах пода `capy-controller-manager`:

```bash
kubectl logs <имя_пода_с_capy-controller-manager> \
  --namespace capy-system \
  --follow
```

## Подключитесь к кластеру {#connect-to-cluster}

Реквизиты для подключения к новому кластеру будут сохранены в управляющем кластере в секрете `<имя_создаваемого_кластера>-kubeconfig`.

1. Получите данные из секрета:

    ```bash
    kubectl get secret <имя_создаваемого_кластера>-kubeconfig \
      --output yaml | yq -r '.data.value' | base64 \
      --decode > capy-cluster-config
    ```

1. [Передайте](../../compute/operations/vm-connect/scp-sftp.md) на вспомогательную ВМ файл с конфигурацией для `kubectl`:

    ```bash
    scp <путь_к_файлу_capy-cluster-config_на_локальном_компьютере> \
    <имя_пользователя>@<публичный_IP-адрес_ВМ>:/home/<имя_пользователя>/.kube/config
    ```

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к вспомогательной ВМ по SSH.
1. Убедитесь, что созданный кластер доступен:

    ```bash
    kubectl cluster-info
    ```

## Установите CCM в созданный кластер {#install-ccm}

Чтобы обеспечить связь между ресурсами кластера и ресурсами Yandex Cloud, установите в созданный кластер [Cloud Controller Manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller/), например [Kubernetes Cloud Controller Manager for Yandex Cloud](https://github.com/deckhouse/yandex-cloud-controller-manager/tree/master).

{% note info %}

Если вы хотите использовать Kubernetes Cloud Controller Manager for Yandex Cloud, добавьте в пример манифеста [yandex-cloud-controller-manager.yaml](https://github.com/deckhouse/yandex-cloud-controller-manager/blob/master/manifests/yandex-cloud-controller-manager.yaml) для `DaemonSet` актуальную версию Docker-образа и переменную окружения `YANDEX_CLUSTER_NAME` с именем созданного кластера.

{% endnote %}

## Установите CNI в созданный кластер {#install-cni}

Чтобы обеспечить сетевую функциональность для подов в новом кластере, установите в него [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), например, [Cilium](https://github.com/cilium/cilium) или [Calico](https://github.com/projectcalico/calico).

Подробнее в документации:
* [Cilium Quick Installation](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/).
* [Quickstart for Calico on Kubernetes](https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart).

## Проверьте связь управляющего кластера с созданным {#check-connection}

1. Подключитесь к вспомогательной ВМ и убедитесь, что в кластере развернуты все поды с необходимыми системными компонентами:

    ```bash
    kubectl get pods --all-namespaces
    ```

    Пример вывода:

    ```bash
    NAMESPACE     NAME                                                       READY   STATUS    RESTARTS   AGE
    kube-system   calico-kube-controllers-695bcfd99c-rcc42                   1/1     Running   0          3h55m
    kube-system   calico-node-9qhxj                                          1/1     Running   0          3h55m
    kube-system   coredns-7c65d6cfc9-52tvn                                   1/1     Running   0          4h50m
    kube-system   coredns-7c65d6cfc9-dpgvg                                   1/1     Running   0          4h50m
    kube-system   etcd-capy-cluster-control-plane-p646q                      1/1     Running   0          4h50m
    kube-system   kube-apiserver-capy-cluster-control-plane-p646q            1/1     Running   0          4h50m
    kube-system   kube-controller-manager-capy-cluster-control-plane-p646q   1/1     Running   0          4h50m
    kube-system   kube-proxy-wb7jr                                           1/1     Running   0          4h50m
    kube-system   kube-scheduler-capy-cluster-control-plane-p646q            1/1     Running   0          4h50m
    kube-system   yandex-cloud-controller-manager-nwhwv                      1/1     Running   0          26s
    ```

1. С локального компьютера проверьте связь управляющего кластера с созданным кластером:

    ```bash
    clusterctl describe cluster <имя_созданного_кластера>
    ```

    Результат:

    ```bash
    NAME                                                             READY  SEVERITY  REASON  SINCE  MESSAGE                                  
    Cluster/capy-cluster                                             True                     10s
    ├─ClusterInfrastructure - YandexCluster/capy-cluster                                   
    └─ControlPlane - KubeadmControlPlane/capy-cluster-control-plane  True                     10s                                                                                       
      └─3 Machines...                                                True                     3m9s   See capy-cluster-control-plane-cf72l, capy-cluster-control-plane-g9jw7, ...
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите кластер Kubernetes, созданный с помощью Cluster API:

    ```bash
    kubectl delete -f /tmp/capy-cluster.yaml
    ```

1. Удалите CRD из управляющего кластера Managed Service for Kubernetes:

    ```bash
    make uninstall
    ```

1. Удалите контроллер провайдера Yandex Cloud из управляющего кластера:

    ```bash
    make undeploy
    ```

1. Удалите вспомогательные ресурсы Yandex Cloud, если вы их создавали:
    * [Группу узлов](../operations/node-group/node-group-delete.md) управляющего кластера Managed Service for Kubernetes.
    * [Управляющий кластер](../operations/kubernetes-cluster/kubernetes-cluster-delete.md) Managed Service for Kubernetes.
    * [Вспомогательную ВМ](../../compute/operations/vm-control/vm-delete.md).
    * [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    * [Образ ОС](../../compute/operations/image-control/delete.md) в Compute Cloud.
    * [Образ ОС](../../storage/operations/objects/delete.md) в Object Storage.
    * [Бакет](../../storage/operations/buckets/delete.md).
    * [Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md).
    * [Реестр](../../container-registry/operations/registry/registry-delete.md).