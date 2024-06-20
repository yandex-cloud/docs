# Начало работы с {{ TF }}


{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы создать вашу первую инфраструктуру в {{ yandex-cloud }} с помощью {{ TF }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите {{ TF }}](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Подготовьте план инфраструктуры](#prepare-plan).
1. [Проверьте и отформатируйте файлы конфигурации](#check-resources).
1. [Создайте ресурсы](#create-resources).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки созданных с помощью {{ TF }} ресурсов входят:
* Плата за постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Установите {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/_tutorials_includes/terraform-install.md) %}

## Получите данные для аутентификации {#get-credentials}

{% include [terraform-credentials-sa](../../_tutorials/_tutorials_includes/terraform-credentials-sa.md) %}

{% cut "Управление ресурсами от имени от имени аккаунта на Яндексе или федеративного аккаунта" %}

{% include [terraform-credentials-user](../../_tutorials/_tutorials_includes/terraform-credentials-user.md) %}

{% endcut %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [terraform-configure](../../_tutorials/_tutorials_includes/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/_tutorials_includes/terraform-configure-provider.md) %}

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью {{ TF }} в {{ yandex-cloud }} можно создавать облачные ресурсы всех типов: ВМ, [диски](../../compute/concepts/disk.md), [образы](../../compute/concepts/image.md) и т. д. Подробную информацию о ресурсах, создающихся с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

Для создания ресурса необходимо указать набор обязательных и опциональных параметров, определяющих свойства ресурса. Такие описания ресурсов составляют план инфраструктуры.

По плану будут созданы две ВМ: `terraform1` и `terraform2`, а также [облачная сеть](../../vpc/concepts/network.md#network) `network-1` с [подсетью](../../vpc/concepts/network.md#subnet) `subnet-1`.

Имена ресурсов должны соответствовать следующим требованиям:

{% include [names](../../_includes/name-format.md) %}

У ВМ будут разные [количества ядер и объемы памяти](../../compute/concepts/vm.md#types): 2 ядра и 2 ГБ оперативной памяти у `terraform1` и 4 ядра и 4 ГБ оперативной памяти у `terraform2`. ВМ автоматически получат публичные и [приватные IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`, находящейся в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a` и принадлежащей облачной сети `network-1`. На ВМ будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к ВМ по [SSH](../../glossary/ssh-keygen.md).

В конфигурации ВМ вам потребуется указать идентификатор образа загрузочного диска. Список доступных публичных образов можно получить командой [CLI](../../cli/quickstart.md):

```bash
yc compute image list --folder-id standard-images
```

Для доступа к ВМ через SSH [сгенерируйте пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) и передайте публичную часть ключа на ВМ в параметре `ssh-keys` блока `metadata`.

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
  zone = "<зона доступности по умолчанию>"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
}
```



{% list tabs group=operating_system %}

- Создание ВМ Linux {#linux}

  {% include [terraform-prepare-plan-linux](../../_tutorials/_tutorials_includes/terraform-prepare-plan-linux.md) %}

- Создание ВМ Windows {#windows}

  {% include [terraform-prepare-plan-windows](../../_tutorials/_tutorials_includes/terraform-prepare-plan-windows.md) %}

{% endlist %}

### Создайте пользователей {#users}

{% list tabs group=operating_system %}

- Linux {#linux}

  {% include [terraform-vm-user-linux](../../_tutorials/_tutorials_includes/terraform-vm-user-linux.md) %}

- Windows {#windows}

  {% include [terraform-vm-user-windows](../../_tutorials/_tutorials_includes/terraform-vm-user-windows.md) %}

{% endlist %}

## Проверьте и отформатируйте файлы конфигураций {#check-resources}

{% include [check-resources](../../_tutorials/_tutorials_includes/terraform-check-resources.md) %}

## Создайте ресурсы {#create-resources}

{% include [create-resources](../../_tutorials/_tutorials_includes/terraform-create-resources.md) %}

## Как удалить созданные ресурсы {#delete-resources}

{% include [delete-resources](../../_tutorials/_tutorials_includes/terraform-delete-resources.md) %}

Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).

## См. также {#see-also}

* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).
* [Источники данных {{ TF }}](../../tutorials/infrastructure-management/terraform-data-sources.md).
* [IaC: Terraform](https://yandex.cloud/ru/training/terraform?utm_source=inhouse&utm_medium=telegram&utm_campaign=announcement) — обучающий курс по управлению инфраструктурой в облаке с помощью {{ TF }}.