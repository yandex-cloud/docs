# Интеграция Yandex Managed Service for Kubernetes с Crossplane

# Интеграция с Crossplane

[Crossplane](https://crossplane.io/) — надстройка для Kubernetes с открытым исходным кодом, которая позволяет собрать решения от разных поставщиков в единую инфраструктуру и предоставить разработчикам приложений доступ к ней через высокоуровневые [API](../../glossary/rest-api.md). С помощью Crossplane пользователи могут управлять сторонними сервисами так же, как ресурсами Kubernetes.

Чтобы создать [виртуальную машину](../../compute/concepts/vm.md) Yandex Compute Cloud с помощью [приложения Crossplane](https://yandex.cloud/ru/marketplace/products/yc/crossplane), установленного в [кластере Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ресурсы Managed Service for Kubernetes](#k8s-create).
1. [Создайте ресурсы Yandex Cloud с помощью Crossplane](#create-crossplane-res).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за использование NAT-шлюза (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#nat-gateways)).


## Подготовьте облако к работе {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Установите [утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).

## Создайте ресурсы Managed Service for Kubernetes {#k8s-create}

1. Создайте кластер и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group) Kubernetes.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер Kubernetes и группа узлов.
     1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
        * Сервисный аккаунт с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер Kubernetes. От его имени будут создаваться ресурсы, необходимые кластеру Kubernetes.
        * Сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller). От его имени узлы будут скачивать из [реестра](../../container-registry/concepts/registry.md) необходимые [Docker-образы](../../container-registry/concepts/docker-image.md).

        {% note tip %}

        Вы можете использовать один и тот же [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для управления кластером Kubernetes и его группами узлов.

        {% endnote %}

     1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер Kubernetes.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов Managed Service for Kubernetes.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * Версию Kubernetes для кластера и групп узлов Kubernetes.
        * CIDR кластера Kubernetes.
        * Имя сервисного аккаунта кластера Managed Service for Kubernetes.
     1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.
     1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

   {% endlist %}

   {% note warning %}
   
   Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
   
   {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Установите Crossplane в кластер Kubernetes](../../managed-kubernetes/operations/applications/crossplane.md).
1. [Настройте NAT-шлюз для подсети узлов кластера Kubernetes](../../vpc/operations/create-nat-gateway.md).

## Создайте ресурсы Yandex Cloud с помощью Crossplane {#create-crossplane-res}

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
        zone: ru-central1-a
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
   * `zone: ru-central1-a` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет развернута ВМ.
   * `name: crossplane-vm` — имя ВМ, которая будет создана средствами Crossplane.
   * `imageId: fd80bm0rh4rkepi5ksdi` — идентификатор загрузочного образа ВМ. Его можно получить вместе [со списком образов](../../compute/operations/image-control/get-list.md). В данном примере используется образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).

   Примеры конфигурации ресурсов Yandex Cloud см. в [репозитории провайдера на GitHub](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main/examples).

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

     1. [Удалите кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md).
     1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
     1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
     1. [Удалите сети](../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

   - Terraform {#tf}

     1. В терминале перейдите в директорию с планом инфраструктуры.
     
         {% note warning %}
     
         Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
     
         {% endnote %}
     
     1. Удалите ресурсы:
     
         1. Выполните команду:
     
             ```bash
             terraform destroy
             ```
     
         1. Подтвердите удаление ресурсов и дождитесь завершения операции.
     
         Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}