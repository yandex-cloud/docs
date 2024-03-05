## Разверните конфигурацию {#deploy}

В этом примере будут созданы две виртуальные машины: `terraform1` и `terraform2`. Они будут подключены к подсети `subnet-1` в зоне доступности `{{ region-id }}-a`. Подсеть будет принадлежать облачной сети `network-1`.

У ВМ будут разные количества ядер и объемы памяти: 1 ядро и 2 ГБ оперативной памяти у `terraform1` и 2 ядра и 4 ГБ оперативной памяти у `terraform2`. ВМ автоматически получат публичные IP-адреса и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`. На ВМ будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к ВМ по [SSH](../../glossary/ssh-keygen.md).
1. Сохраните следующую конфигурацию в файл `example.tf`:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoints = {
         s3 = "{{ s3-storage-host }}"
       }
       bucket = "<имя_бакета>"
       region = "{{ region-id }}"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # необходимая опция при описании бэкенда для {{ TF }} версии 1.6.1 и старше.
       skip_s3_checksum            = true # необходимая опция при описании бэкенда для {{ TF }} версии 1.6.3 и старше.

     }
   }

   provider "yandex" {
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk-vm1" {
     name     = "boot-disk-1"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_disk" "boot-disk-vm2" {
     name     = "boot-disk-2"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm1.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
     }
   }

   resource "yandex_compute_instance" "vm-2" {
     name = "terraform2"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm2.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
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

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```



   Где:

   * `bucket` — имя бакета.
   * `key` — ключ объекта в бакете: путь и имя к файлу состояния {{ TF }} в бакете.
   * `ssh-keys` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Проверьте конфигурацию с помощью команды `terraform plan`.
1. Разверните конфигурацию с помощью команды `terraform apply`.