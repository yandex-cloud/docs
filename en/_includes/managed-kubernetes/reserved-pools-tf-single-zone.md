```hcl
resource "yandex_kubernetes_node_group" "k8s-reserved-ng" {
  cluster_id = "<cluster_ID>"
  name       = "k8s-reserved-ng"

  instance_template {
    platform_id = "standard-v4a"
    reserved_instance_pool_id = "<reserved_instance_pool_ID>"

    resources {
      cores  = 4
      memory = 8
    }

    boot_disk {
      size = 64
      type = "network-ssd"
    }

    network_interface {
      subnet_ids = ["<subnet_ID>"]
      security_group_ids = ["<security_group_IDs>"]
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

Where:
* `cluster_id`: [Cluster ID](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
* `subnet_ids`: [Subnet](../../vpc/operations/subnet-get-info.md) ID.
* `security_group_ids`: Security group [IDs](../../vpc/operations/security-group-get-info.md).
* `reserved_instance_pool_id`: Reserved instance pool [ID](../../compute/cli-ref/reserved-instance-pool/list.md).
