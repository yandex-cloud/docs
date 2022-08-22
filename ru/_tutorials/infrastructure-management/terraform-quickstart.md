# Начало работы с {{ TF }}

{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

Чтобы создать вашу первую инфраструктуру в {{ yandex-cloud }} с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
{% if product == "cloud-il" %}
1. [Создайте сервисный аккаунт](#create-sa).
{% endif %}
1. [Установите {{ TF }}](#install-terraform).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Подготовьте план инфраструктуры](#prepare-plan).
1. [Проверьте и отформатируйте файлы конфигурации](#check-resources).
1. [Создайте ресурсы](#create-resources).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки созданных с помощью {{ TF }} ресурсов входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

{% endif %}


{% if product == "cloud-il" %}

## Создайте сервисный аккаунт {#create-sa}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md), необходимые для управления ресурсами {{ yandex-cloud }}. Список ролей разных сервисов см. в разделе [{#T}](../../iam/concepts/access-control/roles.md).
1. [Создайте статические ключи доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сразу сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

{% endif %}


## Установите {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/terraform-install.md) %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [terraform-configure](../../_tutorials/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью {{ TF }} в {{ yandex-cloud }} можно создавать облачные ресурсы всех типов: виртуальные машины, диски, образы и т.д. Подробную информацию о ресурсах, создающихся с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

Для создания ресурса необходимо указать набор обязательных и опциональных параметров, определяющих свойства ресурса. Такие описания ресурсов составляют план инфраструктуры.

По плану будут созданы две виртуальные машины: `terraform1` и `terraform2`, а также облачная сеть `network-1` с подсетью `subnet-1`.

Имена ресурсов должны соответствовать следующим требованиям:

{% include [names](../../_includes/name-format.md) %}

У машин будут разные количества ядер и объемы памяти: 2 ядра и 2 Гб оперативной памяти у `terraform1` и 4 ядра и 4 Гб оперативной памяти у `terraform2`. Машины автоматически получат публичные IP-адреса и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `subnet-1`, находящейся в зоне доступности `{{ region-id }}-a` и принадлежащей облачной сети `network-1`. На виртуальных машинах будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к машинам по SSH.

В конфигурации виртуальной машины вам потребуется указать идентификатор образа загрузочного диска. Список доступных публичных образов можно получить командой [CLI](../../cli/quickstart.md) `yc compute image list --folder-id standard-images`.  

Для доступа к ВМ через SSH [сгенерируйте пару SSH-ключей](../../compute/operations/vm-connect/ssh#creating-ssh-keys) и передайте публичную часть ключа на виртуальную машину в параметре `ssh-keys` блока `metadata`.

Конфигурации ресурсов задаются сразу после конфигурации провайдера:

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
  token     = "<OAuth>"
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "<зона доступности по умолчанию>"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
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
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "<зона доступности по умолчанию>"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
}
```

{% endif %}

{% list tabs %}

- Создание ВМ Linux

  {% include [terraform-prepare-plan-linux](../../_tutorials/terraform-prepare-plan-linux.md) %}

- Создание ВМ Windows

  {% include [terraform-prepare-plan-windows](../../_tutorials/terraform-prepare-plan-windows.md) %}

{% endlist %}

### Создайте пользователей {#users}

{% list tabs %}

- Linux

  {% include [terraform-vm-user-linux](../../_tutorials/terraform-vm-user-linux.md) %}

- Windows

  {% include [terraform-vm-user-windows](../../_tutorials/terraform-vm-user-windows.md) %}

{% endlist %}

## Проверьте и отформатируйте файлы конфигураций {#check-resources}

{% include [check-resources](../../_tutorials/terraform-check-resources.md) %}

## Создайте ресурсы {#create-resources}

{% include [create-resources](../../_tutorials/terraform-create-resources.md) %}

## Как удалить созданные ресурсы {#delete-resources}

{% include [delete-resources](../../_tutorials/terraform-delete-resources.md) %}

Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).
