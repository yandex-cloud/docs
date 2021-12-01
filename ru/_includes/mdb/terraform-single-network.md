{% cut "networks.tf" %} 

```hcl
resource "yandex_vpc_network" "cluster-net" { name = "cluster-net" }

resource "yandex_vpc_subnet" "cluster-subnet-c" {
  name           = "cluster-subnet-{{ zone-id }}"
  zone           = "{{ zone-id }}"
  network_id     = yandex_vpc_network.cluster-net.id
  v4_cidr_blocks = ["172.16.3.0/24"]
}
```

{% endcut %}
