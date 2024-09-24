---
title: "Как начать работать с {{ cloud-desktop-name }}"
description: "Следуя данной инструкции, вы сможете создать и настроить группу рабочих столов."
---

# Как начать работать с {{ cloud-desktop-full-name }}

{% note info %}

Инструкция содержит информацию о создании и настройке [группы рабочих столов](concepts/desktops-and-groups.md). Если вы получили от администратора ссылку на [витрину пользовательских рабочих столов](concepts/showcase.md), перейдите к подразделу [{#T}](#get-credentials).

{% endnote %}

{{ cloud-desktop-name }} — сервис для управления виртуальной инфраструктурой рабочих столов на базе Linux.

Создайте [группу пользователей](../organization/concepts/groups.md) {{ org-full-name }} и разверните для нее [группу рабочих столов](./concepts/desktops-and-groups.md) {{ cloud-desktop-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу пользователей](#create-user-group).
1. [Разверните группу рабочих столов](#create-desktop-group).
1. [Настройте ACL группы рабочих столов](#setup-acl).
1. [Создайте рабочий стол](#create-desktop).
1. [Получите данные для подключения](#get-credentials).
1. [Подключитесь к рабочему столу](#connect-desktop).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Убедитесь, что у вас есть следующие _минимальные_ роли:
    * [organization-manager.admin](../organization/security/index.md#organization-manager-admin) на [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) — для создания группы пользователей.
    * [vdi.admin](./security/index.md#vdi-admin) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) — для создания группы рабочих столов и назначения ей [ACL](./concepts/acl.md).

    Если у вас примитивная роль [admin](../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

1. Чтобы рабочие столы имели доступ в интернет, для [подсетей](../vpc/concepts/network.md#subnet), в которых они будут размещены, [настройте](../vpc/operations/create-nat-gateway.md) NAT-шлюз.

## Создайте группу пользователей {#create-user-group}

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![persons](../_assets/console-icons/persons.svg).
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud_org.entity.group.action_create }}** и введите название для группы пользователей.

      Название должно быть уникальным в [организации](../overview/roles-and-resources.md) и соответствовать требованиям:

      {% include [group-name-format](../_includes/organization/group-name-format.md) %}

  1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_create }}**.
  1. На открывшейся вкладке **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
  1. В окне **{{ ui-key.yacloud_org.component.subject-select-dialog.title_dialog }}** выберите пользователей, для которых будет развернута группа рабочих столов.
  1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

{% endlist %}

## Разверните группу рабочих столов {#create-desktop-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Введите имя группы рабочих столов.
  1. Выберите [образ](./concepts/images.md) операционной системы — `Ubuntu 20.04 LTS`.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Выберите [типы](../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](./concepts/disks.md) — `SSD`.
      * Укажите размер загрузочного диска — `60 ГБ`.
      * Укажите размер рабочего диска — `4 ГБ`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Укажите количество ядер vCPU — `2`.
      * Выберите [гарантированную долю](../compute/concepts/performance-levels.md) vCPU — `100%`.
      * Укажите объем RAM — `8 ГБ`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [облачную сеть](../vpc/concepts/network.md#network) и [подсети](../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройте ACL группы рабочих столов {#setup-acl}

{% include [access-options](../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Справа от группы рабочих столов, созданной ранее, нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_acl }}**.
  1. В появившемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выберите группу пользователей, созданную ранее, укажите для нее [роль](./security/index.md#vdi-viewer) `vdi.viewer` и нажмите **{{ ui-key.yacloud.common.add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Создайте рабочий стол {#create-desktop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_desktop-create }}**.
  1. Выберите группу рабочих столов, созданную ранее.
  1. Укажите подсеть, в которой будет размещен рабочий стол.

      {% note info %}

      Чтобы рабочий стол имел доступ в интернет, в подсети должен быть [настроен NAT-шлюз](../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. Укажите пользователя, для которого создается рабочий стол.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Получите данные для подключения {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Подключитесь к рабочему столу {#connect-desktop}

Для подключения к рабочему столу используется [Remote Desktop Protocol](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
