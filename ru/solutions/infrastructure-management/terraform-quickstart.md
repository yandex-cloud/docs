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

{% include [prepare-register-billing](../../solutions/_solutions_includes/prepare-register-billing.md) %}

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

{% include [terraform-prepare-plan](../../_includes/solutions/terraform-prepare-plan.md) %}

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
