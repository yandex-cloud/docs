# Интеграция с Crossplane


[Crossplane](https://crossplane.io/) — надстройка для {{ k8s }} с открытым исходным кодом, которая позволяет собрать решения от разных поставщиков в единую инфраструктуру и предоставить разработчикам приложений доступ к ней через высокоуровневые API. С помощью Crossplane пользователи могут управлять сторонними сервисами так же, как ресурсами {{ k8s }}.

Чтобы создать [виртуальную машину](../../../compute/concepts/vm.md) {{ compute-full-name }} с помощью [приложения Crossplane](/marketplace/products/yc/crossplane), установленного в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster):
1. [{#T}](#k8s-create).
1. [{#T}](#create-crossplane-res).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

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

     1. [Создайте кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../../vpc/concepts/network.md#network).
        * [Подсеть](../../../vpc/concepts/network.md#subnet).
        * [Группа безопасности](../../../vpc/concepts/security-groups.md) и [правила](../../operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}, группы узлов и контейнера {{ container-registry-full-name }}:
          * Правила для служебного трафика.
          * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
        * Кластер {{ k8s }}.
        * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
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

## Создайте ресурсы с помощью Crossplane {#create-crossplane-res}

1. Создайте манифест Crossplane `providerconfig.yml`:

   ```yaml
   apiVersion: yandex-cloud.jet.crossplane.io/v1alpha1
   kind: ProviderConfig
   metadata:
     name: yc-config
   spec:
     credentials:
       source: Secret
       secretRef:
         name: yc-creds
         namespace: <пространство_имен_для_Crossplane>
         key: credentials
   ```

1. Создайте манифест-шаблон `vm-instance-template.yml`, в котором описаны сеть, подсеть и ВМ `crossplane-vm`, создаваемые с помощью Crossplane:

   ```yaml
   apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Network
   metadata:
     name: <NET_NAME>
     annotations:
       crossplane.io/external-name: <NET_ID>
   spec:
     deletionPolicy: Orphan
     forProvider:
       name: <NET_NAME>
       folderId: <FOLDER_ID>
   ---
   apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Subnet
   metadata:
     name: <SUBNET_NAME>
     annotations:
       crossplane.io/external-name: <SUBNET_ID>
   spec:
     deletionPolicy: Orphan
     forProvider:
       name: <SUBNET_NAME>
       networkIdRef:
         name: <NET_NAME>
       v4CidrBlocks:
         - <SUBNET_PREFIX>
       zone: <ZONE_ID>
       folderId: <FOLDER_ID>
   ---
   apiVersion: compute.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Instance
   metadata:
     name: <VM_NAME>
   spec:
     forProvider:
       name: <VM_NAME>
       platformId: standard-v2
       zone: <ZONE_ID>
       resources:
         - cores: 2
           memory: 4
       bootDisk:
         - initializeParams:
             # LEMP stack
             # yc compute image get --folder-id standard-images --name=lemp-v20220606 --format=json | jq -r .id
             - imageId: <IMAGE_ID>
       networkInterface:
         - subnetIdRef:
             name: <SUBNET_NAME>
       folderId: <FOLDER_ID>
   ```

   Где:
   * `ZONE_ID` — [зона доступности](../../../overview/concepts/geo-scope.md).
   * `VM_NAME` — имя ВМ, которая будет создана средствами Crossplane.
   * `NET_NAME` — имя облачной сети кластера {{ k8s }}.
   * `SUBNET_NAME` — имя подсети узлов кластера {{ k8s }}.
   * `SUBNET_ID` — идентификатор подсети.
   * `NET_ID` — идентификатор сети.
   * `SUBNET_PREFIX` — CIDR подсети.
   * `FOLDER_ID` — идентификатор каталога.
   * `IMAGE_ID` — идентификатор загрузочного образа ВМ. Его можно получить вместе [со списком образов](../../../compute/operations/image-control/get-list.md). В данном примере используется образ [LEMP](/marketplace/products/yc/lemp).
1. Примените манифест `providerconfig.yml`:

   ```bash
   kubectl apply -f providerconfig.yml
   ```

1. Примените манифест `vm-instance.yml`:

   ```bash
   kubectl apply -f vm-instance.yml
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

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите `crossplane-vm`:

   ```bash
   kubectl delete instance crossplane-vm
   ```

1. Удалите остальные ресурсы:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
     1. Удалите конфигурационный файл `k8s-cluster.tf`.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster.tf`, будут удалены.

   {% endlist %}