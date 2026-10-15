# Начало работы с {{ TF }}


{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы создать первую инфраструктуру в {{ yandex-cloud }} с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите {{ TF }}](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).
1. [Подготовьте план инфраструктуры](#prepare-plan).
1. [Проверьте и отформатируйте файлы конфигураций](#check-resources).
1. [Создайте ресурсы](#create-resources).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры, которую вы создадите с помощью {{ TF }}, входят:

* плата за постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) ([тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Установите {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/_tutorials_includes/terraform-install.md) %}

## Получите данные для аутентификации {#get-credentials}

Для аутентификации в {{ yandex-cloud }} и управления инфраструктурой используйте {{ TF }} от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) или пользователя: [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) или [локального пользователя](../../iam/concepts/users/accounts.md#local).

{% list tabs group=authentication %}

- Сервисный аккаунт {#service-account}

  {% include [authentication-sa](../../_includes/terraform/authentication-sa.md) %}

- Аккаунт на Яндексе, федеративный или локальный пользователь {#yandex-account}

  {% include [authentication-users](../../_includes/terraform/authentication-users.md) %}

{% endlist %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [terraform-configure](../../_tutorials/_tutorials_includes/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/_tutorials_includes/terraform-configure-provider.md) %}

## Подготовьте план инфраструктуры {#prepare-plan}

С помощью {{ TF }} в {{ yandex-cloud }} можно создавать облачные ресурсы разных типов, например ВМ, [диски](../../compute/concepts/disk.md) и [образы](../../compute/concepts/image.md). Полный список ресурсов приведен в [документации провайдера]({{ tf-provider-link }}).

Для каждого ресурса укажите обязательные и необязательные параметры, которые определяют его свойства. Описания ресурсов составляют план инфраструктуры.

План включает две ВМ (`terraform1` и `terraform2`), [облачную сеть](../../vpc/concepts/network.md#network) `network1` и [подсеть](../../vpc/concepts/network.md#subnet) `subnet1`.

Имена ресурсов должны соответствовать следующим требованиям:

{% include [names](../../_includes/name-format.md) %}

ВМ будут различаться количеством ядер и объемом памяти: у `terraform1` будет два ядра и 2 ГБ оперативной памяти, а у `terraform2` — четыре ядра и 4 ГБ оперативной памяти. Обе ВМ автоматически получат публичные и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24`. Подсеть `subnet1` находится в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d` и принадлежит сети `network1`. Для ВМ используйте образ Ubuntu.

В конфигурации ВМ укажите идентификатор образа загрузочного диска. Получите список доступных публичных образов с помощью команды [CLI](../../cli/quickstart.md):

```bash
yc compute image list --folder-id standard-images
```

Для доступа к ВМ по SSH [сгенерируйте пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) и укажите путь к публичной части ключа в параметре `ssh-keys` блока `metadata`.

Ниже приведены фрагменты конфигурации провайдера и одной ВМ для разных регионов. Полные конфигурации ресурсов приведены во вкладках Linux и Windows ниже.


```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "<зона_доступности_по_умолчанию>"
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

## Удалите созданные ресурсы {#delete-resources}

{% include [delete-resources](../../_tutorials/_tutorials_includes/terraform-delete-resources.md) %}

Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}).

#### Полезные ссылки {#see-also}

* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).
* [Источники данных {{ TF }}](../../tutorials/infrastructure-management/terraform-data-sources.md).
* [IaC: Terraform](https://yandex.cloud/ru/training/terraform?utm_source=inhouse&utm_medium=telegram&utm_campaign=announcement) — обучающий курс по управлению инфраструктурой в облаке с помощью {{ TF }}.
