{% cut "networks.tf" %} 

```hcl
resource "yandex_vpc_network" "cluster-net" { name = "cluster-net" }

resource "yandex_vpc_subnet" "cluster-subnet-a" {
  name           = "cluster-subnet-{{ region-id }}-a"
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.cluster-net.id
  v4_cidr_blocks = ["172.16.1.0/24"]
}
```

{% endcut %}
