{% cut "security-groups.tf" %}

```hcl
resource "yandex_vpc_default_security_group" "cluster-sg" {
  network_id = yandex_vpc_network.cluster-net.id

  ingress {
    description    = "HTTPS (secure)"
    port           = 8443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "clickhouse-client (secure)"
    port           = 9440
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all egress cluster traffic"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

{% endcut %}
