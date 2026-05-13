# Переменные в шаблоне узла Yandex Managed Service for Kubernetes

В Managed Service for Kubernetes создаются [группы однотипных узлов](../index.md#node-group) кластера из шаблона. Чтобы такие узлы имели разные характеристики, используйте механизм подстановок переменных в шаблоне.

Поддерживаются [системные](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) и [пользовательские](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) переменные.

Подробнее о переменных и этапах их подстановки читайте на странице [Переменные в шаблоне виртуальной машины](../../../compute/concepts/instance-groups/variables-in-the-template.md).

Например, с помощью переменных вы можете [создать](../../operations/node-group/node-group-create-in-instance-pool.md) мультизональную группу узлов из пулов резервов ВМ, размещенных в разных [зонах доступности](../../../overview/concepts/geo-scope.md).

Использование переменных доступно с помощью [CLI](../../cli-ref/node-group/create.md), [Terraform](../../../terraform/resources/kubernetes_node_group.md) и [API](../../managed-kubernetes/api-ref/NodeGroup/create.md).

## Примеры {#examples}

В примере создается группа узлов в трех зонах доступности с одним узлом из пулов резервов ВМ в каждой зоне.

{% list tabs group=instructions %}

- CLI {#cli}

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
  * `--cluster-id` — [идентификатор](../../operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
  * `--location` — зоны доступности и [идентификаторы](../../../vpc/operations/subnet-get-info.md) подсетей в них.
  * `--network-interface security-group-ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.
  * `--reserved-instance-pool-id` — [идентификаторы](../../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и [пользовательских переменных](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `--variables`.
  * `--variables` — пользовательские переменные с идентификаторами пулов резервов ВМ в разных зонах доступности.

- Terraform {#tf}

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
  * `cluster_id` — [идентификатор](../../operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
  * `variables` — [пользовательские переменные](../../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) с [идентификаторами](../../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ в разных зонах доступности.
  * `name` — имя узла в группе, которое будет сформировано с использованием [системных переменных](../../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и `instance.index` (уникальный номер узла в группе, начиная с 1).
  * `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки системной переменной `instance.zone_id` и пользовательских переменных, заданных в параметре `variables`.
  * `subnet_ids` — [идентификаторы](../../../vpc/operations/subnet-get-info.md) подсетей.
  * `security_group_ids` — [идентификаторы](../../../vpc/operations/security-group-get-info.md) групп безопасности.

{% endlist %}

Примеры для группы с узлами из пула резервов ВМ в одной зоне доступности приведены на странице [Пулы резервов виртуальных машин для групп узлов](reserved-pools.md#examples).

### См. также {#see-also}

* [Переменные в шаблоне виртуальной машины](../../../compute/concepts/instance-groups/variables-in-the-template.md)
* [Пулы резервов виртуальных машин для групп узлов Yandex Managed Service for Kubernetes](reserved-pools.md)
* [Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud](../../operations/node-group/node-group-create-in-instance-pool.md)