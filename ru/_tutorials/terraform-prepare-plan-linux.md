По плану будут созданы следующие ресурсы:

* Облачная сеть `network-1` с подсетью `subnet-1` в зоне доступности `{{ region-id }}-a`.
* Две виртуальные машины Linux: `terraform1` (2 ядра и 2 Гб оперативной памяти) и `terraform2` (4 ядра и 4 Гб оперативной памяти). Они автоматически получат публичные и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`.

1. Получите идентификатор образа загрузочного диска из {{ marketplace-name }}, например [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts), который будет установлен на ВМ. Получите список доступных публичных образов, выполнив следующую команду [CLI](../cli/quickstart.md):

    ```
    yc compute image list --folder-id standard-images
    ```

1. Сгенерируйте [пару SSH-ключей](../compute/operations/vm-connect/ssh#creating-ssh-keys) для доступа к ВМ по SSH.
1. Опишите параметры ресурсов в файле `main.tf`:

    * В параметре `ssh-keys` блока `metadata` укажите путь к публичной части SSH-ключа.
    * В `image_id` задайте идентификатор образа загрузочного диска.

    {% cut "Файл main.tf " %}

    ```hcl
    <настройки провайдера>

    resource "yandex_compute_instance" "vm-1" {
      name = "terraform1"

      resources {
        cores  = 2
        memory = 2
      }

      boot_disk {
        initialize_params {
          image_id = "fd87va5cc00gaq2f5qfb"
        }
      }

      network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
      }

      metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
      }
    }

    resource "yandex_compute_instance" "vm-2" {
      name = "terraform2"

      resources {
        cores  = 4
        memory = 4
      }

      boot_disk {
        initialize_params {
          image_id = "fd87va5cc00gaq2f5qfb"
        }
      }

      network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
      }

      metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
      }
    }

    resource "yandex_vpc_network" "network-1" {
      name = "network1"
    }

    resource "yandex_vpc_subnet" "subnet-1" {
      name           = "subnet1"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.network-1.id
      v4_cidr_blocks = ["192.168.10.0/24"]
    }

    output "internal_ip_address_vm_1" {
      value = yandex_compute_instance.vm-1.network_interface.0.ip_address
    }

    output "internal_ip_address_vm_2" {
      value = yandex_compute_instance.vm-2.network_interface.0.ip_address
    }


    output "external_ip_address_vm_1" {
      value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
    }

    output "external_ip_address_vm_2" {
      value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
    }
    ```

    {% endcut %}
