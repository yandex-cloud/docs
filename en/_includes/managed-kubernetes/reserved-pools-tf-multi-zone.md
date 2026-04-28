```hcl
resource "yandex_kubernetes_node_group" "k8s-multizone-reserved-ng" {
  cluster_id = "<cluster_ID>"
  name       = "k8s-multizone-reserved-ng"

  # Variables for reserved instance pools
  variables = {
    pool_ru-central1-a = "<reserved_instance_pool_ID_in_zone_a>"
    pool_ru-central1-b = "<reserved_instance_pool_ID_in_zone_b>"
    pool_ru-central1-d = "<reserved_instance_pool_ID_in_zone_d>"
  }

  instance_template {
    name = "test-{instance.zone_id}-{instance.index}"
    # instance.zone_id: System variable with the zone ID
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
        "<subnet_ID_in_zone_a>",
        "<subnet_ID_in_zone_b>",
        "<subnet_ID_in_zone_d>"
      ]
      security_group_ids = ["<security_group_IDs>"]
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

Where:
* `cluster_id`: [Cluster ID](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
* `variables`: [User-defined variables](../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) with [IDs](../../compute/cli-ref/reserved-instance-pool/list.md) of reserved instance pools in different availability zones.
* `name`: Node name in the group, generated using the following [system variables](../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage): `instance.zone_id` (the node’s availability zone) and `instance.index` (unique node number in the group, starting from 1).
* `reserved_instance_pool_id`: Reserved instance pool IDs you will get as a result of substituting the `instance.zone_id` system variable and the user-defined variables specified in the `variables` parameter.
* `subnet_ids`: Subnet [IDs](../../vpc/operations/subnet-get-info.md).
* `security_group_ids`: Security group [IDs](../../vpc/operations/security-group-get-info.md).
