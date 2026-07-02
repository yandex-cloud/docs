[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Концепции](../index.md) > [Как устроено управление доступом](index.md) > Роли

# Роли

{% note info %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) Yandex Cloud разрешена [ролью](roles.md), ее выполнение может быть заблокировано, если для [организации](../../../organization/concepts/organization.md), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) создана [политика авторизации](access-policies.md), запрещающая эту операцию.

{% endnote %}

_Роль_ — это набор разрешений, который определяет допустимые операции с ресурсами в Yandex Cloud.

Роли бывают двух типов:
* _Примитивные роли_ содержат разрешения, действующие для всех типов ресурсов Yandex Cloud. Это роли `admin`, `editor`, `viewer` и `auditor`.
* _Сервисные роли_ содержат разрешения только для определенного типа ресурсов в указанном сервисе. Идентификатор сервисной роли указывается в формате `service.resources.role`. Например, роль `compute.images.user` позволяет использовать образы в сервисе Yandex Compute Cloud.

  Сервисную роль можно назначить на ресурс, для которого предназначена роль, или на ресурс, от которого наследуются права доступа. Например, роль `compute.images.user` можно назначить на каталог или облако, так как образ наследует разрешения от них.

На данный момент пользователи не могут создавать новые роли со своим набором разрешений.

## Справочник ролей {#roles-reference}

{% note info "" %}

С 14 февраля 2024 года расширенный перечень ролей всех сервисов Yandex Cloud находится на странице [Справочник ролей Yandex Cloud](../../roles-reference.md).

{% endnote %}

## Примеры использования {#examples}

* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](../../tutorials/user-group-access-control.md)
* [Использование сервисного аккаунта с профилем OS Login для управления ВМ с помощью Ansible](../../tutorials/sa-oslogin-ansible.md)