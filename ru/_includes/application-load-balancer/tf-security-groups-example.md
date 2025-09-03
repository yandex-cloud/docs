Создайте следующие группы безопасности и правила:

```hcl
locals {
  network-id = "<идентификатор_облачной_сети>"
}

resource "yandex_vpc_security_group" "alb" {
  description = "Группа безопасности балансировщика"
  name        = "alb"
  network_id  = local.network-id
  ingress {
    description    = "Правило для получения входящего HTTP-трафика"
    port           = 80
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "Правило для получения входящего HTTPS-трафика"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description       = "Правило для проверок состояния узлов балансировщика"
    port              = 30080
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  egress {
    description    = "Правило для отправки трафика на узлы, в том числе для проверок состояния"
    from_port      = 0
    to_port        = 65535
    protocol       = "TCP"
    v4_cidr_blocks = ["10.140.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-backend" {
  description = "Группа безопасности группы узлов для проверок состояния бэкендов"
  name        = "nodegroup-backend"
  network_id  = local.network-id
  ingress {
    description    = "Правило для проверок состояния бэкендов"
    port           = 10501
    protocol       = "TCP"
    v4_cidr_blocks = ["10.128.0.0/24", "10.129.0.0/24", "10.130.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-nodegroup-traffic" {
  description = "Группа безопасности кластера и группы узлов для служебного трафика"
  name        = "k8s-cluster-nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description       = "Правило для сетевого балансировщика нагрузки"
    from_port         = 0
    to_port           = 65535
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  ingress {
    description       = "Правило для трафика между мастером и узлами"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
  ingress {
    description    = "Правило для проверки работоспособности узлов из подсетей внутри Yandex Cloud"
    from_port      = 0
    to_port        = 65535
    protocol       = "IPV6_ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }
  egress {
    description       = "Правило для трафика между мастером и узлами"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
}

resource "yandex_vpc_security_group" "nodegroup-traffic" {
  description = "Группа безопасности группы узлов для служебного трафика"
  name        = "nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Правило для трафика между подами и сервисами"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
  }
  egress {
    description    = "Правило для доступа к внешним ресурсам"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-traffic" {
  description = "Группа безопасности кластера для служебного трафика"
  name        = "k8s-cluster-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Правило для доступа к API Kubernetes"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  ingress {
    description    = "Правило для доступа к API Kubernetes"
    port           = 6443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  egress {
    description    = "Правило для трафика между мастером и подами metric-server"
    port           = 4443
    protocol       = "TCP"
    v4_cidr_blocks = ["10.96.0.0/16"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-services-access" {
  description = "Группа безопасности группы узлов для подключения к сервисам из интернета"
  name        = "nodegroup-services-access"
  network_id  = local.network-id
  ingress {
    description    = "Правило для доступа к сервисам из интернета и подсетей Yandex Cloud"
    from_port      = 30000
    to_port        = 32767
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-ssh" {
  description = "Группа безопасности группы узлов для подключения к узлам по SSH"
  name        = "nodegroup-ssh"
  network_id  = local.network-id
  ingress {
    description    = "Правило для подключения к узлам по SSH"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
}
```
