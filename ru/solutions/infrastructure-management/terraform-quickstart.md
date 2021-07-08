# Начало работы с Terraform

{% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

Чтобы создать первую конфигурацию Terraform:

1. [Установите Terraform](#install-terraform)
1. [Создайте файл конфигурации Terraform](#configure-terraform)
1. [Настройте провайдер](#configure-provider)
1. [Подготовьте план инфраструктуры](#prepare-plan)
1. [Проверьте и отформатируйте файлы конфигурации](#check-resources)
1. [Создайте ресурсы](#create-resources)
1. [Удалите ресурсы](#delete-resources)

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать инфраструктуру, зарегистрируйтесь в {{ yandex-cloud }} и создайте платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).

 [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки созданных с помощью Terraform ресурсов входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Установите Terraform {#install-terraform}

{% include [terraform_install](../../_includes/solutions/terraform-install.md) %}

## Создайте файл конфигурации Terraform {#configure-terraform}

{% include [terraform-configure](../../_includes/solutions/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_includes/solutions/terraform-configure-provider.md) %}

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
}
```

{% list tabs %}

- Создание ВМ Linux

  {% include [terraform-prepare-plan-linux](../../_includes/solutions/terraform-prepare-plan-linux.md) %}

- Создание ВМ Windows

  {% include [terraform-prepare-plan-windows](../../_includes/solutions/terraform-prepare-plan-windows.md) %}

{% endlist %}

### Создайте пользователей {#users}

{% list tabs %}

- Linux

  {% include [terraform-vm-user-linux](../../_includes/solutions/terraform-vm-user-linux.md) %}

- Windows

  {% include [terraform-vm-user-windows](../../_includes/solutions/terraform-vm-user-windows.md) %}

{% endlist %}

## Проверьте и отформатируйте файлы конфигураций {#check-resources}

{% include [check-resources](../../_includes/solutions/terraform-check-resources.md)  %}

## Создайте ресурсы {#create-resources}

{% include [create-resources](../../_includes/solutions/terraform-create-resources.md)  %}

## Удалите ресурсы {#delete-resources}

{% include [delete-resources](../../_includes/solutions/terraform-delete-resources.md)  %}
