# Начало работы с Terraform

{% include [terraform-definition](../_solutions_includes/terraform-definition.md)  %}

Конфигурации для Terraform записываются в файлы в формате `.tf` на языке HashiCorp Configuration Language (HCL).

Чтобы установить, настроить Terraform и создать первую конфигурацию:

1. [Установите Terraform](#install-terraform)
1. [Создайте файл конфигурации Terraform](#configure-terraform)
1. [Настройте провайдер](#configure-provider)
1. [Подготовьте план инфраструктуры](#prepare-plan)
1. [Создайте ресурсы](#create-resources)
1. [Удалите ресурсы](#delete-resources)

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать инфраструктуру, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).

 [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки созданных с помощью Terraform ресурсов входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Установите Terraform {#install-terraform}

{% include [terraform_install](../_solutions_includes/terraform-install.md) %}

## Создайте файл конфигурации Terraform {#configure-terraform}

{% include [terraform-configure](../_solutions_includes/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../_solutions_includes/terraform-configure-provider.md) %}

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью Terraform в {{ yandex-cloud }} можно создавать облачные ресурсы всех типов: виртуальные машины, диски, образы и т.д. Подробную информацию о ресурсах, создающихся с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

Для создания ресурса необходимо указать набор обязательных и опциональных параметров, определяющих свойства ресурса. Такие описания ресурсов составляют план инфраструктуры.

По плану будут созданы две виртуальные машины: `terraform1` и `terraform2`, а также облачная сеть `network-1` с подсетью `subnet-1`.

Имена ресурсов должны соответствовать следующим требованиям:

{% include [names](../../_includes/name-format.md) %}

У машин будут разные количества ядер и объемы памяти: 2 ядра и 2 Гб оперативной памяти у `terraform1` и 4 ядра и 4 Гб оперативной памяти у `terraform2`. Машины автоматически получат публичные IP-адреса и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`, находящейся в зоне доступности `ru-central1-a` и принадлежащей облачной сети `network-1`. На виртуальных машинах будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к машинам по SSH.

В конфигурации виртуальной машины вам потребуется указать идентификатор образа загрузочного диска. Список доступных публичных образов можно получить командой [CLI](../../cli/quickstart.md) `yc compute image list --folder-id standard-images`.

Для доступа к ВМ через SSH нужно [сгенерировать пару SSH-ключей](../../compute/operations/vm-connect/ssh#creating-ssh-keys) и передать публичную часть ключа на виртуальную машину в параметре `ssh-keys` блока `metadata`.

Конфигурации ресурсов задаются сразу после конфигурации провайдера:

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
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
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
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

### Создание пользователей {#users}

Если вам нужно создать другого пользователя, в блок `metadata` вместо параметра `ssh-keys` можно передать пользовательские метаданные в параметре `user-data`. Для этого:

1. Создайте текстовый файл с метаданными, например:

   {% include [user-data](../../_includes/compute/user-data.md) %}

1. Добавьте в конфигурацию параметр `user-data`, указав путь к файлу с метаданными:

   ```
     metadata = {
       user-data = "${file("<путь к файлу>/meta.txt")}"
     }
   ```

Подробнее о работе с метаданными читайте в разделе [Метаданные виртуальной машины](../../compute/concepts/vm-metadata).

## Создайте ресурсы {#create-resources}

После подготовки конфигурации выполните команду `terraform plan`. Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

{% note alert %}

Все созданные с помощью Terraform ресурсы тарифицируются, внимательно проверьте план.

{% endnote %}

Если в конфигурации нет ошибок, выполните команду `terraform apply`. Terraform запросит подтверждение создания ресурсов: введите в терминал слово `yes` и нажмите Enter. После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

## Удалите ресурсы {#delete-resources}

Все созданные с помощью Terraform ресурсы можно удалить с помощью команды `terraform destroy`. После выполнения команды в терминале отобразится список ресурсов, которые будут удалены. Для подтверждения введите слово `yes` и нажмите Enter.
