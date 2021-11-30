{% cut "networks.tf" %} 

```hcl
resource "yandex_vpc_network" "cluster-net" { name = "cluster-net" }

resource "yandex_vpc_subnet" "cluster-subnet-a" {
  name           = "cluster-subnet-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.cluster-net.id
  v4_cidr_blocks = ["172.16.1.0/24"]
}

resource "yandex_vpc_subnet" "cluster-subnet-b" {
  name           = "cluster-subnet-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.cluster-net.id
  v4_cidr_blocks = ["172.16.2.0/24"]
}

resource "yandex_vpc_subnet" "cluster-subnet-c" {
  name           = "cluster-subnet-ru-central1-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.cluster-net.id
  v4_cidr_blocks = ["172.16.3.0/24"]
}
```

{% endcut %}
