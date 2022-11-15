1. Опишите новую облачную сеть `vm-net` с подсетью `vm-subnet-{{ region-id }}-a`: CIDR `172.17.1.0/24`, зона доступности `{{ region-id }}-a`. Для этого добавьте в конфигурационный файл `networks.tf` следующие строки:

    {% cut "networks.tf" %}

    ```hcl
    resource "yandex_vpc_network" "vm-net" { name = "vm-net" }
    
    resource "yandex_vpc_subnet" "vm-subnet-a" {
      name           = "vm-subnet-{{ region-id }}-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.vm-net.id
      v4_cidr_blocks = ["172.17.1.0/24"]
    }
    ```

    {% endcut %}

1. Опишите группы безопасности:

    * Дополнительную группу безопасности `cluster-vm-sg` в сети `cluster-net` для виртуальной машины `cluster-vm`.
    * Группу безопасности по умолчанию `other-vm-sg` в сети `vm-net` для виртуальной машины `other-vm`.

    Для этого добавьте в конфигурационный файл `security-groups.tf` следующие строки:

    {% cut "security-groups.tf" %}

    ```hcl
    resource "yandex_vpc_security_group" "cluster-vm-sg" {
      name       = "cluster-vm-sg"
      network_id = yandex_vpc_network.cluster-net.id
    
      ingress {
        description    = "Allow any ingress traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    
      egress {
        description    = "Allow any egress traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }
    
    resource "yandex_vpc_default_security_group" "other-vm-sg" {
      network_id = yandex_vpc_network.vm-net.id
    
      ingress {
        description    = "Allow any ingress traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    
      egress {
        description    = "Allow any egress traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }
    ```

    {% endcut %}

    {% note warning %}

    Приведенные выше группы разрешают прохождение любого трафика в любом направлении и используются в демонстрационных целях. Это позволяет устанавливать на виртуальные машины необходимые для подключения утилиты и подключаться к кластеру.

    Для реальных задач настройте группы безопасности так, чтобы они разрешали только необходимый трафик.

    {% endnote %}

1. Опишите виртуальные машины, которые будут использоваться при [процедуре миграции](#do-actions-for-migration) и при [проверке работы DNS](#check-cluster-availability):

    * `cluster-vm`: в облачной сети `cluster-net` (подсеть `cluster-subnet-{{ region-id }}-a`), с группой безопасности `cluster-vm-sg`.
    * `other-vm`: в облачной сети `vm-net` (подсеть `vm-subnet-{{ region-id }}-a`), с группой безопасности `other-vm-sg`.

    Для этого создайте конфигурационный файл `vms.tf` с описанием виртуальных машин.

    {% if audience != "internal" %}
    
    В этот конфигурационный файл также [добавьте открытые части SSH-ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), чтобы можно было подключаться к виртуальным машинам по {% if lang == "ru" %}[SSH](../../../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

    {% else %}
    
    В этот конфигурационный файл также нужно добавить открытые части SSH-ключей, чтобы можно было подключаться к виртуальным машинам по SSH.

    {% endif %}

    {% cut "vms.tf" %}

    ```hcl
    resource "yandex_compute_instance" "cluster-vm" {
      name        = "cluster-vm"
      platform_id = "standard-v3"
      zone        = "{{ region-id }}-a"
    
      resources {
        cores  = 2
        memory = 2
      }
    
      boot_disk {
        initialize_params {
          image_id = "{{ compute-ubuntu-lts-image-id }}"
        }
      }
    
      network_interface {
        subnet_id          = yandex_vpc_subnet.cluster-subnet-a.id
        security_group_ids = [yandex_vpc_security_group.cluster-vm-sg.id]
        nat                = true
      }
    
      metadata = {
        ssh-keys = "<любое имя пользователя>:<содержимое SSH-ключа>"
      }
    }
    
    resource "yandex_compute_instance" "other-vm" {
      name        = "other-vm"
      platform_id = "standard-v3"
      zone        = "{{ region-id }}-a"
    
      resources {
        cores  = 2
        memory = 2
      }
    
      boot_disk {
        initialize_params {
          image_id = "{{ compute-ubuntu-lts-image-id }}"
        }
      }
    
      network_interface {
        subnet_id          = yandex_vpc_subnet.vm-subnet-a.id
        security_group_ids = [yandex_vpc_default_security_group.other-vm-sg.id]
        nat                = true
      }
    
      metadata = {
        ssh-keys = "<любое имя пользователя>:<содержимое SSH-ключа>"
      }
    }
    ```

    {% endcut %}

    {% if audience != "internal" %}
    
    Подробнее процедура создания виртуальной машины описана в [документации {{ compute-full-name }}](../../../compute/operations/vm-create/create-linux-vm.md).

    {% endif %}

1. Проверьте корректность файлов конфигурации {{ TF }}:

    {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

1. Примените сделанные изменения:

    {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
