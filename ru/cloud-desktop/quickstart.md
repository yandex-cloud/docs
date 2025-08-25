---
title: Начало работы с {{ cloud-desktop-name }} для администраторов
description: Следуя данной инструкции, вы сможете создать и настроить группу рабочих столов.
---

# Начало работы с {{ cloud-desktop-full-name }} для администраторов

{% note info %}

Инструкция содержит информацию о создании и настройке [группы рабочих столов](concepts/desktops-and-groups.md). Если вы получили от администратора ссылку на [витрину пользовательских рабочих столов](concepts/showcase.md), перейдите к разделу [{#T}](quickstart-users.md).

{% endnote %}

{{ cloud-desktop-name }} — сервис для управления виртуальной инфраструктурой рабочих столов.

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
1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} _минимальные_ роли:
    * [organization-manager.admin](../organization/security/index.md#organization-manager-admin) на [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) — для создания группы пользователей.
    * [vdi.admin](./security/index.md#vdi-admin) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) — для создания группы рабочих столов и назначения ей [ACL](./concepts/acl.md).

    Если у вас примитивная роль [admin](../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Чтобы рабочие столы имели доступ в интернет, для [подсетей](../vpc/concepts/network.md#subnet), в которых они будут размещены, [настройте](../vpc/operations/create-nat-gateway.md) NAT-шлюз.

## Создайте группу пользователей {#create-user-group}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Задайте название и описание [группы](../organization/concepts/groups.md).

      Название должно быть уникальным в [организации](../overview/roles-and-resources.md) и соответствовать требованиям:

      {% include [group-name-format](../_includes/organization/group-name-format.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_org.groups.action_create-group }}**.

  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** и нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

  1. В открывшемся окне выберите пользователей, для которых будет развернута группа рабочих столов.

  1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

{% endlist %}

## Разверните группу рабочих столов {#create-desktop-group}

В этой инструкции вы создадите группу рабочих столов на базе предустановленной ОС `Ubuntu 20.04 LTS`. Также вы можете:

* [{#T}](operations/images/create-from-compute-linux.md)
* [{#T}](operations/images/create-from-windows.md)

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Введите имя группы рабочих столов.
  1. Выберите **{{ ui-key.yacloud.vdi.section_type }}** — **{{ ui-key.yacloud.vdi.value_type-personal }}**. Рабочие столы назначаются пользователям при их первом подключении и остаются зарезервированными за ними.
  1. В блоке **{{ ui-key.yacloud.vdi.section_desktop }}** задайте:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}** — `2`, максимальное количество рабочих столов в группе.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}** — `1`, количество рабочих столов, которые будут всегда загружены для быстрого подключения пользователей.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** на вкладке **{{ ui-key.yacloud.component.compute.resources.label_tab-standard }}** выберите **Базовая**.
  1. Выберите [образ](./concepts/images.md) операционной системы — `Ubuntu 20.04 LTS`.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Выберите [типы](../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](./concepts/disks.md) — `SSD`.
      * Укажите размер загрузочного диска — `60 ГБ`.
      * Укажите размер рабочего диска — `4 ГБ`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [облачную сеть](../vpc/concepts/network.md#network) и [подсети](../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
  1. В блоке **Пользователи рабочих столов** нажмите **Добавить пользователей** и укажите, кому будут доступны рабочие столы:
     * [Группы пользователей](../iam/concepts/access-control/public-group.md).
     * [Отдельные пользователи](../iam/concepts/users/accounts.md).
     * Почтовый адрес любого пользователя — ему будет отправлено приглашение в вашу организацию и назначена роль для доступа к рабочим столам.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройте ACL группы рабочих столов {#setup-acl}

{% include [access-options](../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Справа от группы рабочих столов, созданной ранее, нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите **Настроить ACL**.
  1. В появившемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выберите группу пользователей, созданную ранее, укажите для нее [роль](./security/index.md#vdi-desktopGroups-user) `vdi.desktopGroups.user` или [роль](./security/index.md#vdi-desktopGroups-maintainer) `vdi.desktopGroups.maintainer` и нажмите **{{ ui-key.yacloud.common.add }}**.
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

{% include [rdp-is-using](../_includes/cloud-desktop/rdp-is-using.md) %}

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
