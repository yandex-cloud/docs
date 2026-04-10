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
      zone = "{{ region-id }}-a"
    }

    location {
      zone = "{{ region-id }}-b"
    }

    location {
      zone = "{{ region-id }}-d"
    }
  }
}
```

Где:
* `cluster_id` — [идентификатор](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
* `variables` — [пользовательские переменные](../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) с [идентификаторами](../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ в разных зонах доступности.
* `name` — имя узла в группе, которое будет сформировано с использованием [системных переменных](../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и `instance.index` (уникальный номер узла в группе, начиная с 1).
* `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки системной переменной `instance.zone_id` и пользовательских переменных, заданных в параметре `variables`.
* `subnet_ids` — [идентификаторы](../../vpc/operations/subnet-get-info.md) подсетей.
* `security_group_ids` — [идентификаторы](../../vpc/operations/security-group-get-info.md) групп безопасности.
