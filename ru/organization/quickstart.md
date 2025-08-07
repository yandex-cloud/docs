# Создать первую организацию

_Организация_ — это высший ресурс в иерархии ресурсной модели {{ yandex-cloud }}, который объединяет ресурсы всех остальных сервисов. Также организации используются для управления пользователями и параметрами их аутентификации и авторизации.

При работе с сервисами {{ yandex-cloud }} вы создаете ресурсы: кластеры управляемых баз данных, виртуальные машины, диски, сети и другие. Большинство сервисов хранит ресурсы в [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder). Каталоги принадлежат [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud), а облака — организациям. Облако может принадлежать только одной организации, но вы можете переносить облака из одной организации в другую. Облаками и каталогами управляет сервис [{{ resmgr-full-name }}](../resource-manager/concepts/resources-hierarchy.md), а организациями управляет сервис {{ org-name }}. Контроль доступа к ресурсам {{ yandex-cloud }} осуществляется с помощью ролей.


Схема организации {{ yandex-cloud }}:

![users-and-resources](../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или [зарегистрируйтесь](../getting-started/), если вы еще не зарегистрированы.
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).

## Создайте организацию {#create-organization}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [create-new-org](../_includes/organization/create-new-org.md) %}

{% endlist %}

После регистрации вы станете владельцем организации и сможете управлять аккаунтами сотрудников, подключать и отключать сервисы.

## Управляйте пользователями {#manage-users}

### Добавьте пользователя в организацию {#add-user-to-organization}

Вы можете подключить сотрудников с помощью аккаунтов на Яндексе — тогда они получат доступ к сервисам организации. Если в компании уже используется другая система управления учетными данными (например, Active Directory или Google Workspace), вы можете [создать федерацию удостоверений](#create-federation), чтобы сотрудники использовали свои рабочие аккаунты для доступа к сервисам {{ yandex-cloud }}.

Чтобы подключить сотрудников с аккаунтами на Яндексе:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-yandex-user](../_includes/organization/add-yandex-user.md) %}

{% endlist %}

Пользователь будет подключен к организации, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. После этого вы сможете [назначить ему необходимые роли](#add-role).

Подробнее о пользователях см. в разделе [Членство в организации](../organization/concepts/membership.md).

### Создайте группу пользователей {#create-group}

Вы можете настроить доступ сразу для нескольких пользователей, для этого объедините их в группу и назначьте группе роль. Группе можно выдать доступ к любым ресурсам {{ yandex-cloud }}.

Чтобы создать группу пользователей:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Задайте название и описание [группы](../organization/concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](../_includes/organization/group-name-format.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_org.groups.action_create-group }}**.

{% endlist %}

### Добавьте пользователя в группу {#add-member-group}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием [группы](../organization/concepts/groups.md).

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

  1. В открывшемся окне выберите нужных пользователей или [сервисные аккаунты](../iam/concepts/users/service-accounts.md). При необходимости воспользуйтесь поиском.

  1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

{% endlist %}

## Управляйте доступом {#security}

### Назначьте роль пользователю {#add-role}

Чтобы разрешить доступ к ресурсу, назначьте пользователю роль на этот ресурс. Назначать роли можно на [организацию](concepts/organization), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.
Вы можете также назначать пользователям роли для управления отдельными сервисами {{ yandex-cloud }} при помощи сервиса [{{ iam-full-name }}](../iam/concepts/index.md).

Чтобы назначить роль пользователю:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [assign-role-to-user](../_includes/organization/assign-role-to-user.md) %}

{% endlist %}

### Назначьте группе пользователей роль на облако или каталог {#group-add-role-cloud}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}) с учетной записью администратора или владельца облака.

  1. В левой части экрана нажмите на строку с именем [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), на который вы хотите назначить роль группе пользователей.

  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

          Вы также можете назначить роль одной из [системных](../iam/concepts/access-control/system-group.md) групп:

          * `All users in organization X` — в группу входят все пользователи организации `X`.
          * `All users in federation N` — в группу входят все пользователи федерации `N`.

      1. Нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../iam/concepts/access-control/roles.md), которую хотите назначить группе на облако или каталог, который вы выбрали ранее. Вы можете назначить несколько ролей.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Назначьте группе пользователей роль на организацию {#group-add-role-organization}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

     Вы также можете назначить роль одной из [системных](../iam/concepts/access-control/system-group.md) групп:

     * `All users in organization X` — в группу входят все пользователи организации `X`.
     * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Дополнительные возможности {#additional-functionality}

### Создайте федерацию удостоверений {#create-federation}

Если в вашей компании есть система управления пользователями и доступом (например, Active Directory или Google Workspace), вы можете использовать ее для авторизации сотрудников в {{ org-full-name }}. Тогда сотрудники будут получать доступ к сервисам {{ yandex-cloud }} с помощью своих корпоративных аккаунтов.

Подробнее см. в разделе [Федерация удостоверений](./concepts/add-federation.md).

### Включите доступ по {{ oslogin }} {#os-login-access}

С помощью {{ oslogin }} можно управлять SSH-доступом к виртуальным машинам (ВМ), полагаясь только на механизмы [сервиса {{ iam-full-name }}](../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании. Доступ по {{ oslogin }} возможен как к [виртуальным машинам сервиса {{ compute-full-name }}](../compute/concepts/vm.md#project), так и к [отдельным узлам в группах узлов](../managed-kubernetes/concepts/index.md#node-group) в составе [кластеров {{ managed-k8s-full-name }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Преимущества {{ oslogin }}:

* Моментальное обновление [прав доступа](../iam/concepts/access-control/roles.md) для пользователя внутри ВМ в случае отзыва или назначения ролей. Если у пользователя отозвать роли, он потеряет доступ ко всем ВМ, для которых был включен доступ через {{ oslogin }}.
* Возможность использовать разные способы доступа к ВМ: как по короткоживущим SSH-сертификатам, так и по SSH-ключам, в том числе добавленным в профиль пользователя организации.

Подробнее см. в разделе [{{ oslogin }}](./concepts/os-login.md).

## Что дальше {#what-is-next}

* [Подробнее о взаимосвязи организаций с другими сервисами](./concepts/organization.md)
* [Управление организациями](./operations/organizations-overview.md)
* [Управление группами пользователей](./operations/manage-groups.md)
* [Управление федерациями удостоверений](./operations/manage-federations.md)
* [Разграничение прав доступа для групп пользователей с различными ролями](./tutorials/user-group-access-control.md)
