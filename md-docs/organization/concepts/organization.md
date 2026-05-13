# Организация

_Организация_ — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов. Также организации используются для управления пользователями и параметрами их аутентификации и авторизации.

При работе с сервисами Yandex Cloud вы создаете ресурсы: кластеры управляемых баз данных, виртуальные машины, диски, сети и другие. Большинство сервисов хранит ресурсы в [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder). Каталоги принадлежат [облакам](../../resource-manager/concepts/resources-hierarchy.md#cloud), а облака — организациям. Облако может принадлежать только одной организации, но вы можете переносить облака из одной организации в другую. Облаками и каталогами управляет сервис [Yandex Resource Manager](../../resource-manager/concepts/resources-hierarchy.md), а организациями управляет сервис Yandex Identity Hub. Контроль доступа к ресурсам Yandex Cloud осуществляется с помощью ролей.

Структура организации Yandex Cloud:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Управление доступом в организации {#access-management}

В рамках организации пользователи взаимодействуют с ресурсами Yandex Cloud. Организации не взаимодействуют друг с другом, поэтому доступ к ресурсам организации имеют только [члены этой организации](membership.md). Исключение составляют ресурсы, доступ к которым выдан для [публичных групп](../../iam/concepts/access-control/public-group.md) `All users` и `All authenticated users`.

Вы можете настроить доступ к ресурсам организации для отдельных пользователей или групп пользователей. Для этого доступны следующие инструменты:

* [Группы пользователей](groups.md) — позволяют назначить одинаковые права доступа для нескольких пользователей одновременно.
* [Федерации удостоверений](add-federation.md) — реализуют систему единого входа для пользователей организации, даже если у них нет аккаунта в Яндексе.
* [Пулы пользователей](user-pools.md) — позволяют объединить [локальных пользователей](../../iam/concepts/users/accounts.md#local) в контейнеры.
* Сервис [Yandex Identity and Access Management](../../iam/concepts/index.md) — позволяет запретить выполнение определенных операций с помощью [политик авторизации](../../iam/concepts/access-control/access-policies.md), а также назначить пользователям роли для выполнения определенных операций с конкретным ресурсом Yandex Cloud.

## Управление безопасностью организации {#security}

Для управления безопасностью вашей организации доступны следующие возможности:

* [Использование refresh-токенов в Yandex Cloud CLI](../operations/enable-refresh-tokens.md).
* [Доступ по OS Login](../operations/os-login-access.md).
* [Требование включения двухфакторной аутентификации](../operations/enable-2fa-access.md).
* [Запрет пользователям просматривать информацию о членах организации](../operations/hide-user-info.md).

## Управление сервисами {#service-management}

Большинство сервисов Yandex Cloud хранят свои ресурсы в [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder) внутри [организации](organization.md). Однако некоторые сервисы обособлены от общей ресурсно-ролевой модели. Они работают на уровне организации и могут обмениваться данными с другими сервисами в рамках одной организации. К таким сервисам относятся:

* [Яндекс Трекер](https://tracker.yandex.ru/);
* [Yandex DataLens](https://datalens.ru/promo);
* [Яндекс Вики](https://wiki.yandex.ru/);
* [Яндекс Формы](https://forms.yandex.ru/cloud/admin);
* [Yandex DataSphere](https://datasphere.yandex.cloud);
* [Yandex SpeechSense](https://speechsense.yandex.cloud/).

Чтобы перейти к управлению сервисами:

1. [Войдите в аккаунт](https://passport.yandex.ru/) администратора или владельца организации.

1. Перейдите в сервис [Cloud Center](https://center.yandex.cloud).

1. Если вы хотите управлять одним из обособленных сервисов, найдите его в списке сервисов на панели справа и нажмите на него.

   Чтобы управлять остальными сервисами, нажмите **Cloud Console** в правом верхнем углу.

## Примеры использования {#examples}

* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](../../tutorials/security/user-group-access-control.md)
* [Аутентификация с помощью Google Workspace](../../tutorials/security/integration-gworkspace.md)
* [Аутентификация с помощью Microsoft Entra ID](../../tutorials/security/integration-azure.md)
* [Аутентификация с помощью Active Directory](../../tutorials/security/integration-adfs.md)

## Что дальше {#what-is-next}

* [Членство в организации](membership.md)
* [Управление организациями](../operations/organizations-overview.md)
* [Управление группами пользователей](../operations/manage-groups.md)
* [Управление федерациями удостоверений](../operations/manage-federations.md)
* [OS Login](os-login.md)
* [Начало работы с Yandex Security Deck](../../security-deck/quickstart-overview.md)
* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](../tutorials/user-group-access-control.md)
* [Чеклист безопасности аутентификации и авторизации](../../security/domains/iam-checklist.md)