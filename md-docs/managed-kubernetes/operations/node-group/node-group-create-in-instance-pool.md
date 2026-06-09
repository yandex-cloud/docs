# Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud


{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации Yandex Compute Cloud](../../../compute/pricing.md). Подробнее см. в разделе [Использование пулов резервов ВМ](../../../compute/pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

_Пул резервов виртуальных машин_ — это зарезервированная пользователем в заданной [зоне доступности](../../../overview/concepts/geo-scope.md) совокупность вычислительных ресурсов, которые будут гарантированно доступны пользователю для создания в этой зоне доступности [виртуальных машин](../../../compute/concepts/vm.md) в определенной [конфигурации](../../../compute/concepts/performance-levels.md#available-configurations).

В Managed Service for Kubernetes вы можете использовать пулы резервов ВМ для [групп узлов](../../concepts/index.md#node-group) фиксированного размера. Это обеспечивает гарантированную доступность ресурсов для узлов кластера.

Подробнее читайте на страницах [Пулы резервов виртуальных машин для групп узлов Yandex Managed Service for Kubernetes](../../concepts/node-group/reserved-pools.md) и [Пулы резервов виртуальных машин в Compute Cloud](../../../compute/concepts/reserved-pools.md). 

{% note warning %}

Использование пулов резервов ВМ _не поддерживается_ для групп узлов со следующими параметрами:
* с [автоматическим масштабированием](../../concepts/node-group/cluster-autoscaler.md);
* c [уровнем производительности vCPU](../../../compute/concepts/performance-levels.md) менее 100%;
* c [прерываемыми ВМ](../../../compute/concepts/preemptible-vm.md);
* с использованием [групп размещения ВМ](../../../compute/concepts/placement-groups.md).

{% endnote %}

## Создать группу узлов в одной зоне доступности с узлами из пула резервов ВМ этой зоны {#single-zone}

1. [Создайте](../../../compute/operations/reserved-pools/create-reserved-pool.md) пул резервов ВМ с конфигурацией, которую вы хотите использовать для узлов кластера Managed Service for Kubernetes.

    {% note info %}
    
    Конфигурация группы узлов должна соответствовать конфигурации пула резервов ВМ в части:
    * [платформы](../../../compute/concepts/vm-platforms.md);
    * количества vCPU;
    * объема RAM;
    * [зоны доступности](../../../overview/concepts/geo-scope.md).
    
    Количество узлов в группе в каждой зоне доступности не должно превышать размер пулов резервов ВМ в этих зонах.
    
    {% endnote %}

1. [Создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер Managed Service for Kubernetes.
1. Создайте группу узлов:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      В терминале выполните команду:

      ```bash
      yc managed-kubernetes node-group create \
        --name k8s-reserved-ng \
        --cluster-id <идентификатор_кластера> \
        --platform-id standard-v4a \
        --cores 4 \
        --memory 8 \
        --disk-size 64 \
        --disk-type network-ssd \
        --fixed-size 2 \
        --location zone=ru-central1-a,subnet-id=<идентификатор_подсети> \
        --network-interface security-group-ids=[<идентификаторы_групп_безопасности>] \
        --reserved-instance-pool-id <идентификатор_пула_резервов>
      ```
      
      Где:
      * `--cluster-id` — [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) кластера.
      * `--location` — зона доступности и [идентификатор](../../../vpc/operations/subnet-get-info.md) подсети.
      * `--network-interface security-group-ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
      * `--reserved-instance-pool-id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.

      Подробнее о команде читайте в [справочнике CLI](../../cli-ref/node-group/create.md).

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры группы узлов:

          ```hcl
          resource "yandex_kubernetes_node_group" "k8s-reserved-ng" {
            cluster_id = "<идентификатор_кластера>"
            name       = "k8s-reserved-ng"
          
            instance_template {
              platform_id = "standard-v4a"
              reserved_instance_pool_id = "<идентификатор_пула_резервов>"
          
              resources {
                cores  = 4
                memory = 8
              }
          
              boot_disk {
                size = 64
                type = "network-ssd"
              }
          
              network_interface {
                subnet_ids = ["<идентификатор_подсети>"]
                security_group_ids = ["<идентификаторы_групп_безопасности>"]
                nat        = true
              }
            }
          
            scale_policy {
              fixed_scale {
                size = 2
              }
            }
          
            allocation_policy {
              location {
                zone = "ru-central1-a"
              }
            }
          }
          ```
          
          Где:
          * `cluster_id` — [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) кластера.
          * `subnet_ids` — [идентификатор](../../../vpc/operations/subnet-get-info.md) подсети.
          * `security_group_ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
          * `reserved_instance_pool_id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.

      1. Создайте группу узлов:

          1. В терминале перейдите в директорию с конфигурационным файлом.
          1. Проверьте корректность конфигурации с помощью команды:
          
             ```bash
             terraform validate
             ```
          
             Если конфигурация является корректной, появится сообщение:
          
             ```bash
             Success! The configuration is valid.
             ```
          
          1. Выполните команду:
          
             ```bash
             terraform plan
             ```
          
             В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
          1. Примените изменения конфигурации:
          
             ```bash
             terraform apply
             ```
          
          1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Подробнее о ресурсе `yandex_kubernetes_node_group` читайте в [справочнике Terraform](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

## Создать группу узлов в трех зонах доступности с узлами из пулов резервов ВМ в каждой зоне {#multi-zone}

1. [Создайте](../../../compute/operations/reserved-pools/create-reserved-pool.md) пулы резервов ВМ в трех зонах доступности с конфигурацией, которую вы хотите использовать для узлов кластера Managed Service for Kubernetes.

    {% note info %}
    
    Конфигурация группы узлов должна соответствовать конфигурации пула резервов ВМ в части:
    * [платформы](../../../compute/concepts/vm-platforms.md);
    * количества vCPU;
    * объема RAM;
    * [зоны доступности](../../../overview/concepts/geo-scope.md).
    
    Количество узлов в группе в каждой зоне доступности не должно превышать размер пулов резервов ВМ в этих зонах.
    
    {% endnote %}

1. [Создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер Managed Service for Kubernetes.
1. Создайте группу узлов:

    {% note tip %}
    
    Пулы резервов ВМ создаются в конкретной зоне доступности. Чтобы автоматизировать распределение узлов мультизональной группы в пулах резервов ВМ конкретной зоны доступности, используйте [переменные в шаблоне узла](../../concepts/node-group/variables-in-the-template.md). 
    
    {% endnote %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      В терминале выполните команду:

      ```bash
      yc managed-kubernetes node-group create \
        --name k8s-multizone-reserved-ng \
        --cluster-id <идентификатор_кластера> \
        --platform-id standard-v4a \
        --cores 4 \
        --memory 8 \
        --disk-size 64 \
        --disk-type network-ssd \
        --fixed-size 3 \
        --location zone=ru-central1-a,subnet-id=<идентификатор_подсети_в_зоне_a> \
        --location zone=ru-central1-b,subnet-id=<идентификатор_подсети_в_зоне_b> \
        --location zone=ru-central1-d,subnet-id=<идентификатор_подсети_в_зоне_d> \
        --network-interface security-group-ids=[<идентификаторы_групп_безопасности>] \
        --reserved-instance-pool-id '{pool_{instance.zone_id}}' \
        --variables \
      pool_ru-central1-a=<идентификатор_пула_в_зоне_a>,\
      pool_ru-central1-b=<идентификатор_пула_в_зоне_b>,\
      pool_ru-central1-d=<идентификатор_пула_в_зоне_d>
      ```
      
      Где:
      * `--cluster-id` — [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) кластера.
      * `--location` — зоны доступности и [идентификаторы](../../../vpc/operations/subnet-get-info.md) подсетей в них.
      * `--network-interface security-group-ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
      * `--reserved-instance-pool-id` — [идентификаторы](../../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и [пользовательских переменных](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `--variables`.
      * `--variables` — пользовательские переменные с идентификаторами пулов резервов ВМ в разных зонах доступности.

      Подробнее о команде читайте в [справочнике CLI](../../cli-ref/node-group/create.md).

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры группы узлов:

          ```hcl
          resource "yandex_kubernetes_node_group" "k8s-multizone-reserved-ng" {
            cluster_id = "<идентификатор_кластера>"
            name       = "k8s-multizone-reserved-ng"
          
            # Переменные для пулов резервов
            variables = {
              pool_ru-central1-a = "<идентификатор_пула_резервов_в_зоне_a>"
              pool_ru-central1-b = "<идентификатор_пула_резервов_в_зоне_b>"
              pool_ru-central1-d = "<идентификатор_пула_резервов_в_зоне_d>"
            }
          
            instance_template {
              name = "test-{instance.zone_id}-{instance.index}"
              # instance.zone_id - системная переменная с идентификатором зоны
              reserved_instance_pool_id = "{pool_{instance.zone_id}}"
              platform_id = "standard-v4a"
          
              resources {
                cores = 4
                memory = 8
              }
          
              boot_disk {
                size = 64
                type = "network-ssd"
              }
          
              network_interface {
                nat = true
                subnet_ids = [
                  "<идентификатор_подсети_в_зоне_a>",
                  "<идентификатор_подсети_в_зоне_b>",
                  "<идентификатор_подсети_в_зоне_d>"
                ]
                security_group_ids = ["<идентификаторы_групп_безопасности>"]
              }
            }
          
            scale_policy {
              fixed_scale {
                size = 3
              }
            }
          
            allocation_policy {
              location {
                zone = "ru-central1-a"
              }
          
              location {
                zone = "ru-central1-b"
              }
          
              location {
                zone = "ru-central1-d"
              }
            }
          }
          ```
          
          Где:
          * `cluster_id` — [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) кластера.
          * `variables` — [пользовательские переменные](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) с [идентификаторами](../../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ в разных зонах доступности.
          * `name` — имя узла в группе, которое будет сформировано с использованием [системных переменных](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и `instance.index` (уникальный номер узла в группе, начиная с 1).
          * `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки системной переменной `instance.zone_id` и пользовательских переменных, заданных в параметре `variables`.
          * `subnet_ids` — [идентификаторы](../../../vpc/operations/subnet-get-info.md) подсетей.
          * `security_group_ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.

      1. Создайте группу узлов:

          1. В терминале перейдите в директорию с конфигурационным файлом.
          1. Проверьте корректность конфигурации с помощью команды:
          
             ```bash
             terraform validate
             ```
          
             Если конфигурация является корректной, появится сообщение:
          
             ```bash
             Success! The configuration is valid.
             ```
          
          1. Выполните команду:
          
             ```bash
             terraform plan
             ```
          
             В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
          1. Примените изменения конфигурации:
          
             ```bash
             terraform apply
             ```
          
          1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Подробнее о ресурсе `yandex_kubernetes_node_group` читайте в [справочнике Terraform](../../../terraform/resources/kubernetes_node_group.md).

    {% endlist %}

### См. также {#see-also}

* [Пулы резервов виртуальных машин для групп узлов Yandex Managed Service for Kubernetes](../../concepts/node-group/reserved-pools.md)
* [Переменные в шаблоне узла Yandex Managed Service for Kubernetes](../../concepts/node-group/variables-in-the-template.md)
* [Пулы резервов виртуальных машин в Compute Cloud](../../../compute/concepts/reserved-pools.md)
* [Работа с пулами резервов ВМ](../../../compute/operations/index.md#reserved-pools)
* [Переменные в шаблоне виртуальной машины](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [Создание группы узлов](node-group-create.md)