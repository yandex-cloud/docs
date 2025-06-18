---
title: Упрощенное создание виртуальной машины Linux
description: Для первого знакомства с сервисом {{ compute-name }} создайте ВМ на Linux с помощью простой формы в консоли управления {{ yandex-cloud }}. Вы можете подключиться к виртуальной машине Linux по протоколу SSH через консоль или программу PuTTY. Для подключения необходимо указать публичный адрес виртуальной машины Linux.
keywords:
  - простое создание вм
  - linux
  - linux vm
  - linux вм
  - linux виртуальная машина
  - виртуальная машина
  - вм
---

# Упрощенное создание виртуальной машины Linux

Для первого знакомства с сервисом {{ compute-name }} создайте [ВМ](../concepts/vm.md) на Linux с помощью простой формы в консоли управления {{ yandex-cloud }}. После того как ВМ будет создана, вы сможете подключиться к ней по протоколу SSH.

{% note tip %}

С помощью простой формы вы можете создать ВМ с базовыми настройками. Чтобы детально сконфигурировать ВМ, воспользуйтесь инструкцией [{#T}](quick-create-linux.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Создайте ВМ {#create-vm}

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-simple-title }}**.

    {% include [console-default-variant](../../_includes/compute/console-default-variant.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_simple-image }}** выберите один из [образов](../concepts/image.md) и версию операционной системы на базе Linux.

    Чтобы посмотреть список всех доступных образов, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою. Чтобы создать свою конфигурацию:
    * Выберите опцию ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud.component.compute.resources.option_resources-custom-config }}**.
    * Укажите необходимое количество и [гарантированную долю](../concepts/performance-levels.md) vCPU, а также объем RAM.
    * При необходимости сделайте ВМ [прерываемой](../concepts/preemptible-vm.md).
1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_disks }}** настройте загрузочный [диск](../concepts/disk.md):
    * Выберите [тип диска](../concepts/disk.md#disks_types).
    * Задайте нужный размер диска.
1. (Опционально) Добавьте дополнительный диск:
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disks }}** нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
    * Выберите [тип диска](../concepts/disk.md#disks_types).
    * Задайте нужный размер диска.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
    * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-name }}** укажите имя ВМ.

      {% include [name-format](../../_includes/name-format.md) %}

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

      {% note alert %}

      Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
      * `{{ ui-key.yacloud.component.compute.network-select.switch_dynamic }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.

        Динамический IP-адрес высвобождается при остановке виртуальной машины. При следующем запуске ВМ назначается новый публичный IP-адрес. При перезагрузке ВМ динамический публичный IP-адрес сохраняется.

      * `{{ ui-key.yacloud.component.compute.network-select.switch_static }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).

1. Раскройте блок **{{ ui-key.yacloud.compute.instances.create.section_predefined }}** и посмотрите параметры ВМ, заданные по умолчанию.

    Значения этих параметров можно будет задать при [продвинутом создании ВМ](quick-create-linux.md).

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../vpc/concepts/address.md) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

## Подключитесь к ВМ {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной ВМ, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

* [{#T}](quick-create-linux.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/index.md)