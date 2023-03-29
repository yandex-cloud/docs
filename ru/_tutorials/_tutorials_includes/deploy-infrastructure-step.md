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
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<имя бакета>"
       region     = "{{ region-id }}"
       key        = "<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   provider "yandex" {
     token     = "<OAuth или статический ключ сервисного аккаунта>"
     cloud_id  = "<идентификатор облака>"
     folder_id = "<идентификатор каталога>"
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = yandex_compute_image.ubuntu_2004.id
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
       cores  = 2
       memory = 4
     }

     boot_disk {
       initialize_params {
         image_id = yandex_compute_image.ubuntu_2004.id
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

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```



1. Проверьте конфигурацию с помощью команды `terraform plan`.
1. Разверните конфигурацию с помощью команды `terraform apply`.