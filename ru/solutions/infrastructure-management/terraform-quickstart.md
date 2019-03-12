# Начало работы с Terraform

Terraform позволяет быстро создать облачную инфраструктуру в Яндекс.Облаке. Состав инфраструктуры определяется с помощью конфигурационных файлов, в которых указываются требуемые облачные ресурсы и их параметры.

Конфигурации для Terraform записываются в файлы в формате `.tf` на языке HashiCorp Configuration Language (HCL).

Чтобы установить, настроить Terraform и создать первую конфигурацию:

1. [Установите Terraform](#install-terraform)
1. [Настройте Terraform ](#configure-terraform)
1. [Настройте провайдер](#configure-provider)
1. [Подготовьте план инфраструктуры](#prepare-plan)
1. [Создайте ресурсы](#create-resources)
1. [Удалите ресурсы](#delete-resources)

## 1. Установите Terraform {#install-terraform}

Установите Terraform:

---

**[!TAB macOS]**

Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh):

```
$ brew install terraform
```

**[!TAB Windows/Linux]**

Скачайте дистрибутив Terraform и установите его по [инструкции](https://www.terraform.io/intro/getting-started/install.html).

---

## 2. Настройте Terraform {#configure-terraform}

Создайте в любом месте новую директорию с произвольным названием, например `yandex-cloud-terraform` — в ней будут храниться конфигурационные файлы и сохраненные состояния Terraform и инфраструктуры.

Чтобы создать ресурсы в Яндекс.Облаке с помощью Terraform, создайте в новой директории конфигурационный файл в формате `.tf`, например, `example.tf`. 

## 3. Настройте провайдер {#configure-provider}

В начале конфигурационного файла необходимо задать настройки провайдера. 

~~~
provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
}
~~~

* `provider` — название провайдера.
* `token` — OAuth токен для доступа к Яндекс.Облаку.
* `cloud_id` — идентификатор облака, с которым ведется работа.
* `folder_id` — идентификатор каталога, в котором Terraform создаст облачные ресурсы.
* `zone` — зона доступности, в которой по умолчанию будут создаваться все облачные ресурсы. 

После настройки сохраните файл и выполните команду `terraform init` в папке с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в файлах `.tf` в поле `provider` и позволяет работать с ресурсами и источниками данных провайдера.

## 4. Подготовьте план инфраструктуры {#prepare-plan}

С помощью Terraform в Яндекс.Облаке можно создавать облачные ресурсы всех типов: виртуальные машины, диски, образы и т.д. Подробную информацию о ресурсах, создающихся с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

Для создания ресурса необходимо указать набор обязательных и опциональных параметров, определяющих свойства ресурса. Такие описания ресурсов составляют план инфраструктуры.

По плану будут созданы две виртуальные машины: `terraform1` и `terraform2`, а также облачная сеть `network-1` с подсетью `subnet-1`. 

У машин будут разные количества ядер и объемы памяти: 1 ядро и 2 Гб оперативной памяти у `terraform1` и 2 ядра и 4 Гб оперативной памяти у `terraform2`. Машины автоматически получат публичные IP-адреса и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`, находящейся в зоне доступности `ru-central1-a` и принадлежащей облачной сети `network-1`. На виртуальных машинах будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к машинам по SSH.

Конфигурации ресурсов задаются сразу после конфигурации провайдера:

~~~
provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata {
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
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = "${yandex_compute_instance.vm-1.network_interface.0.ip_address}"
}

output "internal_ip_address_vm_2" {
  value = "${yandex_compute_instance.vm-2.network_interface.0.ip_address}"
}


output "external_ip_address_vm_1" {
  value = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
}

output "external_ip_address_vm_2" {
  value = "${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}"
}
~~~ 

## 5. Создайте ресурсы {#create-resources}

После подготовки конфигурации выполните команду `terraform plan`. Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

> [!WARNING]
>
> Все созданные с помощью Terraform ресурсы тарифицируются, внимательно проверьте план.
>

Если в конфигурации нет ошибок, выполните команду `terraform apply`. Terraform запросит подтверждение создания ресурсов: введите в терминал слово `yes` и нажмите Enter. После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.cloud.yandex.ru).

## 6. Удалите ресурсы {#delete-resources}

Все созданные с помощью Terraform ресурсы можно удалить с помощью команды `terraform destroy`. После выполнения команды в терминале отобразится список ресурсов, которые будут удалены. Для подтверждения введите слово `yes` и нажмите Enter. 