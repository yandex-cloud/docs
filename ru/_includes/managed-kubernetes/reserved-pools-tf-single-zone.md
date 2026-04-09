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
* `cluster_id` — [идентификатор](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
* `subnet_ids` — [идентификатор](../../vpc/operations/subnet-get-info.md) подсети.
* `security_group_ids` — [идентификаторы](../../vpc/operations/security-group-get-info.md) групп безопасности.
* `reserved_instance_pool_id` — [идентификатор](../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.
