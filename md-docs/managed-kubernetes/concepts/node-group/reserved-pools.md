# Пулы резервов виртуальных машин для групп узлов {{ managed-k8s-full-name }}

{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации {{ compute-full-name }}](../../../compute/pricing.md). Подробнее см. в разделе [{#T}](../../../compute/pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

_Пул резервов виртуальных машин_ — это зарезервированная пользователем в заданной [зоне доступности](../../../overview/concepts/geo-scope.md) совокупность вычислительных ресурсов, которые будут гарантированно доступны пользователю для создания в этой зоне доступности [виртуальных машин](../../../compute/concepts/vm.md) в определенной [конфигурации](../../../compute/concepts/performance-levels.md#available-configurations).

Подробнее читайте на странице [{#T}](../../../compute/concepts/reserved-pools.md).

В {{ managed-k8s-name }} вы можете использовать пулы резервов ВМ для [групп узлов](../index.md#node-group) фиксированного размера. Это обеспечивает гарантированную доступность ресурсов для узлов кластера.

Использование пулов резервов в {{ managed-k8s-name }} доступно с помощью [CLI](../../cli-ref/node-group/create.md), [{{ TF }}](../../../terraform/resources/kubernetes_node_group.md) и [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

{% note tip %}

Пулы резервов ВМ создаются в конкретной зоне доступности. Чтобы автоматизировать распределение узлов мультизональной группы в пулах резервов ВМ конкретной зоны доступности, используйте [переменные в шаблоне узла](variables-in-the-template.md). 

{% endnote %}

## Ограничения {#restrictions}

Использование пулов резервов ВМ _не поддерживается_ для групп узлов со следующими параметрами:
* с [автоматическим масштабированием](cluster-autoscaler.md);
* c [уровнем производительности vCPU](../../../compute/concepts/performance-levels.md) менее 100%;
* c [прерываемыми ВМ](../../../compute/concepts/preemptible-vm.md);
* с использованием [групп размещения ВМ](../../../compute/concepts/placement-groups.md).

{% note info %}

Конфигурация группы узлов должна соответствовать конфигурации пула резервов ВМ в части:
* [платформы](../../../compute/concepts/vm-platforms.md);
* количества vCPU;
* объема RAM;
* [зоны доступности](../../../overview/concepts/geo-scope.md).

Количество узлов в группе в каждой зоне доступности не должно превышать размер пулов резервов ВМ в этих зонах.

{% endnote %}

## Примеры {#examples}

В примере создается группа узлов в одной зоне доступности с двумя узлами из пула резервов ВМ этой зоны.

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  {{ yc-k8s }} node-group create \
    --name k8s-reserved-ng \
    --cluster-id <идентификатор_кластера> \
    --platform-id standard-v4a \
    --cores 4 \
    --memory 8 \
    --disk-size 64 \
    --disk-type network-ssd \
    --fixed-size 2 \
    --location zone={{ region-id }}-a,subnet-id=<идентификатор_подсети> \
    --network-interface security-group-ids=[<идентификаторы_групп_безопасности>] \
    --reserved-instance-pool-id <идентификатор_пула_резервов>
  ```
  
  Где:
  * `--cluster-id` — [идентификатор](../../operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
  * `--location` — зона доступности и [идентификатор](../../../vpc/operations/subnet-get-info.md) подсети.
  * `--network-interface security-group-ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
  * `--reserved-instance-pool-id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.

- {{ TF }} {#tf}

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
        zone = "{{ region-id }}-a"
      }
    }
  }
  ```
  
  Где:
  * `cluster_id` — [идентификатор](../../operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
  * `subnet_ids` — [идентификатор](../../../vpc/operations/subnet-get-info.md) подсети.
  * `security_group_ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
  * `reserved_instance_pool_id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.

{% endlist %}

Примеры для мультизональной группы с узлами из пула резервов ВМ с использованием переменных приведены на странице [Переменные в шаблоне узла](variables-in-the-template.md#examples).

### См. также {#see-also}

* [{#T}](../../../compute/concepts/reserved-pools.md)
* [Работа с пулами резервов ВМ](../../../compute/operations/index.md#reserved-pools)
* [{#T}](variables-in-the-template.md)
* [{#T}](../../operations/node-group/node-group-create-in-instance-pool.md)