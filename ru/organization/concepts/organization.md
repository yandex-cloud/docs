---
title: Организация
description: Организация — это рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и дает пользователям возможность работать с ними.
---

# Организация

_Организация_ — это высший ресурс в иерархии ресурсной модели {{ yandex-cloud }}, который объединяет ресурсы всех остальных сервисов. Также организации используются для управления пользователями и параметрами их аутентификации и авторизации.

При работе с сервисами {{ yandex-cloud }} вы создаете ресурсы: кластеры управляемых баз данных, виртуальные машины, диски, сети и другие. Большинство сервисов хранит ресурсы в [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder). Каталоги принадлежат [облакам](../../resource-manager/concepts/resources-hierarchy.md#cloud), а облака — организациям. Облако может принадлежать только одной организации, но вы можете переносить облака из одной организации в другую. Облаками и каталогами управляет сервис [{{ resmgr-full-name }}](../../resource-manager/concepts/resources-hierarchy.md), а организациями управляет сервис {{ org-name }}. Контроль доступа к ресурсам {{ yandex-cloud }} осуществляется с помощью ролей.

Структура организации {{ yandex-cloud }}:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Управление доступом в организации {#access-management}

В рамках организации пользователи взаимодействуют с ресурсами {{ yandex-cloud }}. Организации не взаимодействуют друг с другом, поэтому доступ к ресурсам организации имеют только [члены этой организации](membership.md). Исключение составляют ресурсы, доступ к которым выдан для [публичных групп](../../iam/concepts/access-control/public-group.md) `All users` и `All authenticated users`.

Вы можете настроить доступ к ресурсам организации для отдельных пользователей или групп пользователей. Для этого доступны следующие инструменты:

* [Группы пользователей](groups.md) — позволяют назначить одинаковые права доступа для нескольких пользователей одновременно.
* [Федерация удостоверений](add-federation.md) — реализует систему единого входа для пользователей организации, даже если у них нет аккаунта в Яндексе.
* [Пулы пользователей](user-pools.md) — позволяют объединить [локальных пользователей](../../iam/concepts/users/accounts.md#local) в контейнеры.
* Сервис [{{ iam-full-name }}](../../iam/concepts/index.md) — позволяет назначить пользователям роли для выполнения определенных операций с конкретным ресурсом {{ yandex-cloud }}.

## Управление сервисами {#service-management}

Большинство сервисов {{ yandex-cloud }} хранят свои ресурсы в [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder) внутри [организации](organization.md). Однако некоторые сервисы обособлены от общей ресурсно-ролевой модели. Они работают на уровне организации и могут обмениваться данными с другими сервисами в рамках одной организации. К таким сервисам относятся:

* [{{ tracker-full-name }}]({{ link-tracker }});
* [{{ datalens-full-name }}]({{ link-datalens-main }});
* [{{ wiki-full-name }}]({{ link-wiki }});
* [{{ forms-full-name }}]({{ link-forms-b2b }});
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }});
* [{{ speechsense-full-name }}]({{ link-speechsense-main }}).

Чтобы перейти к управлению сервисами:

1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

1. Перейдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}).

1. Если вы хотите управлять одним из обособленных сервисов, найдите его в списке сервисов на панели справа и нажмите на него.

   Чтобы управлять остальными сервисами, нажмите **{{ ui-key.yacloud_org.dashboard.products.action.console }}** в правом верхнем углу.

## Примеры использования {#examples}

* [{#T}](../../tutorials/security/user-group-access-control.md)
* [{#T}](../../tutorials/security/integration-gworkspace.md)
* [{#T}](../../tutorials/security/integration-azure.md)
* [{#T}](../../tutorials/security/integration-adfs.md)

## Что дальше {#what-is-next}

* [{#T}](membership.md)
* [Управление организациями](../operations/organizations-overview.md)
* [Управление группами пользователей](../operations/manage-groups.md)
* [Управление федерациями удостоверений](../operations/manage-federations.md)
* [{#T}](os-login.md)
* [Начало работы с {{ sd-full-name }}](../../security-deck/quickstart-overview.md)
* [{#T}](../tutorials/user-group-access-control.md)
