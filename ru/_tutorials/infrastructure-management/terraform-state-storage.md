# Загрузка состояний {{ TF }} в Object Storage

В инструкции описываются шаги загрузки состояния {{ TF }} в [{{ objstorage-full-name }}](../../storage/). 

Состояние {{ TF }} описывает текущую развернутую инфраструктуру и хранится в файлах с расширением `.tfstate`. Файл состояния создается после развертывания инфраструктуры и может быть сразу загружен в {{ objstorage-name }}. Загруженный файл состояния будет обновляться после изменений созданной инфраструктуры.
 
В этом примере сохраненное состояние позволит другим пользователям получить идентификатор одной из созданных подсетей, чтобы подключить к ней новую виртуальную машину. 

Чтобы настроить хранение состояний {{ TF }} в {{ objstorage-name }} и использовать его для создания новых ресурсов:

1. [Подготовьте облако к работе](#before-you-begin).
{% if product == "yandex-cloud" %}1. [Необходимые платные ресурсы](#paid-resources).{% endif %}
1. [Установите {{ TF }}](#install-terraform).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Создайте сервисный аккаунт и статический ключ доступа](#create-service-account).
1. [Создайте бакет](#create-service-account).
1. [Настройте бэкенд](#set-up-backend).
1. [Разверните конфигурацию](#deploy).
1. [Проверьте сохраненное состояние](#set-up-backend).
1. [Получите состояние из бэкенда](#retrieve-state).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{{ TF }} и его провайдеры распространяются под лицензией [Mozilla Public License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Все созданные с помощью {{ TF }} ресурсы тарифицируются, внимательно проверьте конфигурации, которые будут использоваться далее.

{% endnote %}

В этом сценарии будут созданы три виртуальных машины с публичными IP-адресами, виртуальная сеть и две подсети.

В стоимость поддержки этой инфраструктуры входят:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)). 

{% endif %}

## Установите {{ TF }} {#install-terraform}

{% include [terraform-install](../../_tutorials/terraform-install.md) %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

1. Создайте директорию с произвольным названием, например `cloud-terraform`. В ней будут храниться конфигурационные файлы {{ TF }}.
1. Создайте в этой директории конфигурационный файл с расширением `.tf`, например, `example.tf`. 

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Создайте сервисный аккаунт и статический ключ доступа {#create-service-account}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [`editor`](../../iam/concepts/access-control/roles.md#editor) на каталог, указанный в настройках провайдера.
1. [Получите статический ключ доступа](../../iam/operations/sa/create-access-key.md). Сохраните идентификатор ключа и секретный ключ — они понадобятся в следующих разделах инструкции.

## Создайте бакет {#create-service-account}

[Создайте бакет](../../storage/operations/buckets/create.md) с любым именем, например `terraform-object-storage-tutorial`. В нем будет храниться файл состояния {{ TF }}.

## Настройте бэкенд {#set-up-backend}

Чтобы сохранить состояние {{ TF }} в {{ objstorage-name }}, укажите настройки провайдера и бэкенда:

{% if product == "yandex-cloud" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
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
  zone      = "<зона доступности по умолчанию>"
}
```

{% endif %}

{% if product == "cloud-il" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.cloudil.com"
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
  endpoint  = "{{ api-host }}:443"
  token     = "<статический ключ сервисного аккаунта>"
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "<зона доступности по умолчанию>"
}
```

{% endif %}

Подробнее о бэкенде для хранения состояний читайте на [сайте {{ TF }}](https://www.terraform.io/docs/backends/types/s3.html).

## Разверните конфигурацию {#deploy}

В этом примере будут созданы две виртуальные машины: `terraform1` и `terraform2`. Они будут подключены к подсети `subnet-1` в зоне доступности `{{ region-id }}-a`. Подсеть будет принадлежать облачной сети `network-1`.

У машин будут разные количества ядер и объемы памяти: 1 ядро и 2 Гб оперативной памяти у `terraform1` и 2 ядра и 4 Гб оперативной памяти у `terraform2`. Машины автоматически получат публичные IP-адреса и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`. На виртуальных машинах будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к машинам по SSH.

1. Сохраните следующую конфигурацию в файл `example.tf`:

   {% if product == "yandex-cloud" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoint   = "storage.yandexcloud.net"
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
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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

   {% endif %}

   {% if product == "cloud-il" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoint   = "storage.cloudil.com"
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
     endpoint  = "{{ api-host }}:443"
     token     = "<статический ключ сервисного аккаунта>"
     cloud_id  = "<идентификатор облака>"
     folder_id = "<идентификатор каталога>"
     zone      = "{{ region-id }}-a"
   }

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
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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

   {% endif %}

1. Проверьте конфигурацию c помощью команды `terraform plan`. 
1. Разверните конфигурацию с помощью команды `terraform apply`.

## Проверьте сохраненное состояние {#set-up-backend}

Убедитесь, что файл состояния загружен в {{ objstorage-name }}:

1. Откройте [консоль управления]({{ link-console-main }}) и выберите каталог, в котором находится созданный бакет.
1. Выберите сервис **{{ objstorage-name }}**.
1. В списке бакетов выберите тот, куда должно было сохраниться состояние {{ TF }}.
1. Убедитесь, что в бакете появился файл состояния.

## Получите состояние из бэкенда {#retrieve-state}

Сохраненное в {{ objstorage-name }} состояние {{ TF }} можно запросить из другой конфигурации и дополнить уже созданную инфраструктуру. 

Создайте еще одну конфигурацию и используйте сохраненное состояние, чтобы создать еще одну виртуальную машину в одной из заранее созданных подсетей:

1. Создайте директорию `remote-state`.
1. Перейдите в созданную директорию и создайте конфигурацию `remote-state.tf`:

   {% if product == "yandex-cloud" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     token     = "<OAuth или статический ключ сервисного аккаунта>"
     cloud_id  = "cloud-id"
     folder_id = "folder-id"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "storage.yandexcloud.net"
       bucket     = "<имя бакета>"
       region     = "{{ region-id }}"
       key        = "<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

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
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
     }
   }
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     endpoint  = "{{ api-host }}:443"
     token     = "<статический ключ сервисного аккаунта>"
     cloud_id  = "cloud-id"
     folder_id = "folder-id"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "storage.cloudil.com"
       bucket     = "<имя бакета>"
       region     = "{{ region-id }}"
       key        = "<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

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
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
     }
   }
   ```

   {% endif %}

1. Выполните команду `terraform init`. 
1. Выполните команду `terraform plan`. В терминале должен отобразиться план создания одной виртуальной машины.
1. Выполните команду `terraform apply`.
1. Перейдите в консоль управления и убедитесь, что в разделе {{ compute-name }} появилась виртуальная машина `vm-3`.

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить созданные ресурсы, выполните команду `terraform destroy` сначала во второй конфигурации, а затем в первой.
