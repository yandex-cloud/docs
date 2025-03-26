# Интеграция с Crossplane

[Crossplane](https://crossplane.io/) — надстройка для {{ k8s }} с открытым исходным кодом, которая позволяет собрать решения от разных поставщиков в единую инфраструктуру и предоставить разработчикам приложений доступ к ней через высокоуровневые [API](../../../glossary/rest-api.md). С помощью Crossplane пользователи могут управлять сторонними сервисами так же, как ресурсами {{ k8s }}.

Чтобы создать [виртуальную машину](../../../compute/concepts/vm.md) {{ compute-full-name }} с помощью [приложения Crossplane](/marketplace/products/yc/crossplane), установленного в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ресурсы {{ managed-k8s-name }}](#k8s-create).
1. [Создайте ресурсы {{ yandex-cloud }} с помощью Crossplane](#create-crossplane-res).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md#prices-public-ip)).
* Плата за использование NAT-шлюза (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md#nat-gateways)).


## Подготовьте облако к работе {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Установите [утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).

## Создайте ресурсы {{ managed-k8s-name }} {#k8s-create}

1. Создайте кластер и [группу узлов](../../../managed-kubernetes/concepts/index.md#node-group) {{ k8s }}.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
     1. [Создайте сервисные аккаунты](../../../iam/operations/sa/create.md):
        * Сервисный аккаунт с [ролями](../../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
        * Сервисный аккаунт с [ролью](../../../iam/concepts/access-control/roles.md) [{{ roles-cr-puller }}](../../../container-registry/security/index.md#container-registry-images-puller). От его имени узлы будут скачивать из [реестра](../../../container-registry/concepts/registry.md) необходимые [Docker-образы](../../../container-registry/concepts/docker-image.md).

        {% note tip %}

        Вы можете использовать один и тот же [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для управления кластером {{ k8s }} и его группами узлов.

        {% endnote %}

     1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Создайте кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../../vpc/concepts/network.md#network).
        * [Подсеть](../../../vpc/concepts/network.md#subnet).
        * Кластер {{ k8s }}.
        * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
        * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * Версию {{ k8s }} для кластера и групп узлов {{ k8s }}.
        * CIDR кластера {{ k8s }}.
        * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Установите Crossplane в кластер {{ k8s }}](../../operations/applications/crossplane.md).
1. [Настройте NAT-шлюз для подсети узлов кластера {{ k8s }}](../../../vpc/operations/create-nat-gateway.md).

## Создайте ресурсы {{ yandex-cloud }} с помощью Crossplane {#create-crossplane-res}

1. Определите, какие ресурсы вы хотите создать с помощью Crossplane. Чтобы получить список доступных ресурсов, выполните команду:

   ```bash
   kubectl get crd | grep yandex-cloud.jet.crossplane.io
   ```

1. Определите параметры этих ресурсов. Чтобы посмотреть доступные параметры для конкретного ресурса, выполните команду:

   ```bash
   kubectl describe crd <имя_ресурса>
   ```

1. Создайте манифест-шаблон `vm-instance-template.yml`, в котором описаны существующие в каталоге сеть и подсеть, а также новая ВМ `crossplane-vm`, создаваемая с помощью Crossplane:

    ```yaml
    # Добавление в конфигурацию существующей сети
    apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Network
    metadata:
      name: <имя_существующей_сети>
      annotations:
        # Указать провайдеру на существующую сеть
        crossplane.io/external-name: <идентификатор_существующей_сети>
    spec:
      # Запретить удаление существующей сети
      deletionPolicy: Orphan
      forProvider:
        name: <имя_существующей_сети>
      providerConfigRef:
        name: default
    ---
    # Добавление в конфигурацию существующей подсети
    apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Subnet
    metadata:
      name: <имя_существующей_подсети>
      annotations:
        # Указать провайдеру на существующую подсеть
        crossplane.io/external-name: <идентификатор_существующей_подсети>
    spec:
      # Запретить удаление существующей подсети
      deletionPolicy: Orphan
      forProvider:
        name: <имя_существующей_подсети>
        networkIdRef:
          name: <имя_существующей_сети>
        v4CidrBlocks:
          - <IPv4_CIDR_существующей_подсети>
      providerConfigRef:
        name: default
    ---
    # Создание ВМ
    apiVersion: compute.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Instance
    metadata:
      name: crossplane-vm
    spec:
      forProvider:
        name: crossplane-vm
        platformId: standard-v1
        zone: {{ region-id }}-a
        resources:
          - cores: 2
            memory: 4
        bootDisk:
          - initializeParams:
              - imageId: fd80bm0rh4rkepi5ksdi
        networkInterface:
          - subnetIdRef:
              name: <имя_существующей_подсети>
            # Автоматически предоставить ВМ публичный IP-адрес
            nat: true
        metadata:
          ssh-keys: "<публичный_ключ_SSH>"
      providerConfigRef:
        name: default
      # Записать реквизиты для подключения к ВМ в секрет
      writeConnectionSecretToRef:
        name: instance-conn
        namespace: default
      ```

   В блоке с конфигурацией ВМ:
   * `zone: {{ region-id }}-a` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет развернута ВМ.
   * `name: crossplane-vm` — имя ВМ, которая будет создана средствами Crossplane.
   * `imageId: fd80bm0rh4rkepi5ksdi` — идентификатор загрузочного образа ВМ. Его можно получить вместе [со списком образов](../../../compute/operations/image-control/get-list.md). В данном примере используется образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).

   Примеры конфигурации ресурсов {{ yandex-cloud }} см. в [репозитории провайдера на GitHub](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main/examples).

1. Примените манифест `vm-instance-template.yml`:

   ```bash
   kubectl apply -f vm-instance-template.yml
   ```

1. Проверьте состояние созданных ресурсов:

   ```bash
   kubectl get network
   kubectl get subnet
   kubectl get instance
   ```

1. Убедитесь, что созданная ВМ `crossplane-vm` появилась в каталоге:

   ```bash
   yc compute instance list
   ```

1. Чтобы получить из секрета данные для подключения к ВМ, выполните команду:
   
   ```bash
   kubectl get secret instance-conn -o json | jq -r '.data | map_values(@base64d)'
   ```

   Ожидаемый результат:
   
   ```json
   {
     "external_ip": "<публичный_IP-адрес>",
     "fqdn": "<полное_доменное_имя>",
     "internal_ip": "<внутренний_IP-адрес>"
   }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите ВМ `crossplane-vm`:

   ```bash
   kubectl delete instance crossplane-vm
   ```

1. Удалите остальные ресурсы:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md).
     1. [Удалите таблицу маршрутизации](../../../vpc/operations/delete-route-table.md).
     1. [Удалите NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).
     1. [Удалите сети](../../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
