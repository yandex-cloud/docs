---
title: Организация
description: Организация — это глобальное рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и дает пользователям возможность работать с ними.
---

# Организация

Организация — это высший ресурс в иерархии ресурсной модели {{ yandex-cloud }}, в котором хранятся ресурсы всех остальных сервисов. Также организации используются для управления пользователями и параметрами их аутентификации и [авторизации](#access-management). Подробнее см. в разделе [{#T}](#organizations-and-yc-resources).

## Взаимосвязь организаций с ресурсами {{ yandex-cloud }} {#organizations-and-yc-resources}

В организации хранятся ресурсы сервисов {{ yandex-cloud }}. Ресурсы одной организации не могут взаимодействовать с ресурсами другой организации средствами {{ yandex-cloud }}. Организациями управляет сервис {{ org-name }}.

Каждой организации принадлежит одно или несколько [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud). Облако может принадлежать только одной организации, но вы можете переносить облака из одной организации в другую.

В облаке находятся [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder). Каждый каталог принадлежит одному облаку. Не существует каталогов вне облака. Нельзя создать каталог внутри другого каталога. Облака и каталоги управляются сервисом [{{ resmgr-full-name }}](../../resource-manager/concepts/resources-hierarchy.md).

Большинство ресурсов {{ yandex-cloud }} — кластеры управляемых баз данных, виртуальные машины, диски, сети и другие — размещаются в каталогах. При создании ресурса указывается каталог, в котором он будет создан. Однако некоторые сервисы обособлены от общей ресурсно-ролевой модели и работают на уровне организации. К таким сервисам относятся:

* [{{ tracker-full-name }}]({{ link-tracker }});
* [{{ datalens-full-name }}]({{ link-datalens-main }});
* [{{ wiki-full-name }}]({{ link-wiki }});
* [{{ forms-full-name }}]({{ link-forms-b2b }});
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }});
* [{{ speechsense-full-name }}]({{ link-speechsense-main }}).

Взаимосвязь организаций и ресурсов {{ yandex-cloud }} представлена на схеме:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Управление доступом в организации {#access-management}

Организация — это базовый объект, в котором пользователи взаимодействуют с ресурсами {{ yandex-cloud }}. Доступ к ресурсам организации имеют только [члены этой организации](membership.md). Исключение составляют ресурсы, доступ к которым выдан для [публичных групп](../../iam/concepts/access-control/public-group.md) `All users` и `All authenticated users`.

Вы также можете настраивать управление доступом в рамках организации для отдельных пользователей, групп пользователей или конкретных сервисов. Для этого доступны следующие инструменты:

* [Группы пользователей](groups.md) — позволяют назначить одинаковые права доступа для нескольких пользователей одновременно.
* [Федерация удостоверений](add-federation.md) — реализовывает систему единого входа для пользователей организации, даже если у них нет аккаунта в Яндексе.
* Сервис [{{ iam-full-name }}](../../iam/concepts/index.md) — позволяет назначить пользователям роли для выполнения определенных операций с конкретным ресурсом {{ yandex-cloud }}.

## Управление сервисами {#service-management}

Большинство сервисов {{ yandex-cloud }} хранят свои ресурсы в [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder) внутри [организации](organization.md). Для управления такими сервисами:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}).

  1. Нажмите **Cloud Console** в правом верхнем углу.

{% endlist %}

Некоторые сервисы обособлены от общей ресурсно-ролевой модели. Они работают на уровне организации и могут обмениваться данными с другими сервисами в рамках одной организации. К таким сервисам относятся:

* [{{ tracker-full-name }}]({{ link-tracker }});
* [{{ datalens-full-name }}]({{ link-datalens-main }});
* [{{ wiki-full-name }}]({{ link-wiki }});
* [{{ forms-full-name }}]({{ link-forms-b2b }});
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }});
* [{{ speechsense-full-name }}]({{ link-speechsense-main }}).

Чтобы перейти к управлению такими сервисами:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}).

  1. Найдите нужный сервис в списке сервисов на панели справа и нажмите на него.      

{% endlist %}

## Что дальше {#what-is-next}

* [{#T}](membership.md)
* [Управление организациями](../operations/organizations-overview.md)
* [Управление группами пользователей](../operations/manage-groups.md)
* [Управление федерациями удостоверений](../operations/manage-federations.md)
* [{#T}](os-login.md)
* [Начало работы с {{ sd-full-name }}](../../security-deck/quickstart-overview.md)
* [{#T}](../tutorials/user-group-access-control.md)
