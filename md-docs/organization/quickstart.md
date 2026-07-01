# Создать первую организацию

_Организация_ — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов. Также организации используются для управления пользователями и параметрами их аутентификации и авторизации.

При работе с сервисами Yandex Cloud вы создаете ресурсы: кластеры управляемых баз данных, виртуальные машины, диски, сети и другие. Большинство сервисов хранит ресурсы в [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder). Каталоги принадлежат [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud), а облака — организациям. Облако может принадлежать только одной организации, но вы можете переносить облака из одной организации в другую. Облаками и каталогами управляет сервис [Yandex Resource Manager](../resource-manager/concepts/resources-hierarchy.md), а организациями управляет сервис Yandex Identity Hub. Контроль доступа к ресурсам Yandex Cloud осуществляется с помощью ролей.


Схема организации Yandex Cloud:

![users-and-resources](../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или [зарегистрируйтесь](../getting-started/index.md), если вы еще не зарегистрированы.
1. Примите пользовательское соглашение.
1. В сервисе [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).

## Создайте организацию {#create-organization}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  
  1. Ознакомьтесь с условиями использования Yandex Cloud и нажмите кнопку **Войти**.
  
  1. Введите название и описание организации.
  
  1. Нажмите кнопку **Создать новую организацию**.

{% endlist %}

После регистрации вы станете владельцем организации и сможете управлять аккаунтами сотрудников, подключать и отключать сервисы.

## Управляйте пользователями {#manage-users}

### Добавьте пользователя в организацию {#add-user-to-organization}

Вы можете подключить сотрудников с помощью аккаунтов на Яндексе — тогда они получат доступ к сервисам организации. Если в компании уже используется другая система управления учетными данными (например, Active Directory или Google Workspace), вы можете [создать федерацию удостоверений](#create-federation), чтобы сотрудники использовали свои рабочие аккаунты для доступа к сервисам Yandex Cloud.

Чтобы подключить сотрудников с аккаунтами на Яндексе:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  
  1. На панели слева выберите ![icon-users](../_assets/console-icons/person.svg) **Пользователи**.
  
  1. В правом верхнем углу экрана нажмите кнопку ![person-plus](../_assets/console-icons/person-plus.svg) **Добавить пользователя** и в выпадающем списке выберите ![person-planet-earth](../_assets/console-icons/person-planet-earth.svg) **Пригласить пользователей с аккаунтом на Яндексе**.
  
  1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `login@yandex.ru`).
  
      Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.
  
  1. Нажмите кнопку **Отправить приглашение**.

{% endlist %}

Пользователь будет подключен к организации, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. После этого вы сможете [назначить ему необходимые роли](#add-role).

Подробнее о пользователях читайте в разделе [Членство в организации](concepts/membership.md).

### Создайте группу пользователей {#create-group}

Вы можете настроить доступ сразу для нескольких пользователей, для этого объедините их в группу и назначьте группе роль. Группе можно выдать доступ к любым ресурсам Yandex Cloud.

Чтобы создать группу пользователей:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **Группы**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **Создать группу**.

  1. Задайте название и описание [группы](concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать группу**.

{% endlist %}

### Добавьте пользователя в группу {#add-member-group}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **Группы** и нажмите строку с названием [группы](concepts/groups.md).

  1. Перейдите на вкладку **Участники**.

  1. Нажмите кнопку **Добавить участника**.

  1. В открывшемся окне выберите нужных пользователей или [сервисные аккаунты](../iam/concepts/users/service-accounts.md). При необходимости воспользуйтесь поиском.

  1. Нажмите **Сохранить**.

{% endlist %}

## Управляйте доступом {#security}

### Назначьте роль пользователю {#add-role}

Чтобы разрешить доступ к ресурсу, назначьте пользователю роль на этот ресурс. Назначать роли можно на [организацию](concepts/organization.md), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.
Вы можете также назначать пользователям роли для управления отдельными сервисами Yandex Cloud при помощи сервиса [Yandex Identity and Access Management](../iam/concepts/index.md).

Чтобы назначить роль пользователю:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../_assets/console-icons/persons-lock.svg) **Права доступа**.
  
  1. Если у нужного пользователя уже есть хотя бы одна роль, в строке с этим пользователем нажмите значок ![icon-context-menu](../_assets/console-icons/ellipsis.svg) и выберите **Назначить роли**.
  
      Если нужного пользователя нет в списке, в правом верхнем углу страницы нажмите кнопку **Назначить роли**. В открывшемся окне выберите пользователя из списка или воспользуйтесь строкой поиска.
  
  1. Нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../iam/concepts/access-control/roles.md), которую хотите назначить пользователю. Вы можете назначить несколько ролей.
  
      Описание доступных ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../iam/roles-reference.md).
  
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Назначьте группе пользователей роль на облако или каталог {#group-add-role-cloud}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud) с учетной записью администратора или владельца облака.

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), на который вы хотите назначить роль группе пользователей.

  1. В верхней части экрана перейдите на вкладку **Права доступа** и нажмите кнопку **Настроить доступ**. В открывшемся окне:

      1. Перейдите на вкладку **Группы** и выберите [группу](concepts/groups.md) или воспользуйтесь поиском по названию группы.

          Вы также можете назначить роль одной из [системных](../iam/concepts/access-control/system-group.md) групп:

          * `All users in organization X` — в группу входят все пользователи организации `X`.
          * `All users in federation N` — в группу входят все пользователи федерации `N`.

      1. Нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../iam/concepts/access-control/roles.md), которую хотите назначить группе на облако или каталог, который вы выбрали ранее. Вы можете назначить несколько ролей.

      1. Нажмите **Сохранить**.

{% endlist %}

### Назначьте группе пользователей роль на организацию {#group-add-role-organization}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../_assets/console-icons/persons-lock.svg) **Права доступа**.

  1. Справа сверху нажмите кнопку **Назначить роли**.

  1. Перейдите на вкладку **Группы** и выберите [группу](concepts/groups.md) или воспользуйтесь поиском по названию группы.

     Вы также можете назначить роль одной из [системных](../iam/concepts/access-control/system-group.md) групп:

     * `All users in organization X` — в группу входят все пользователи организации `X`.
     * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.

  1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Дополнительные возможности {#additional-functionality}

### Создайте федерацию удостоверений или пул пользователей {#create-federation}

Если в вашей компании есть система управления пользователями и доступом (например, Active Directory или Google Workspace), вы можете использовать ее для аутентификации сотрудников в Yandex Identity Hub. Тогда сотрудники будут получать доступ к сервисам Yandex Cloud с помощью своих корпоративных аккаунтов.

При этом использовать сторонние системы управления пользователями и доступом необязательно. Вы можете создать [пул пользователей](concepts/user-pools.md) и заводить в нем учетные записи [локальных пользователей](../iam/concepts/users/accounts.md#local) в рамках вашей [организации](concepts/organization.md) Yandex Identity Hub.

Более того, Yandex Identity Hub может выступать в качестве поставщика удостоверений, которого вы можете использовать для аутентификации ваших пользователей в сторонних системах и сервисах с помощью [приложений](concepts/applications/index.md).

Подробнее в разделах:
* [SAML-совместимые федерации удостоверений](concepts/add-federation.md)
* [Пулы пользователей](concepts/user-pools.md)
* [Приложения в Yandex Identity Hub](concepts/applications/index.md)

### Включите доступ по OS Login {#os-login-access}

С помощью OS Login можно управлять SSH-доступом к виртуальным машинам (ВМ), полагаясь только на механизмы [сервиса Yandex Identity and Access Management](../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании. Доступ по OS Login возможен как к [виртуальным машинам сервиса Yandex Compute Cloud](../compute/concepts/vm.md#project), так и к [отдельным узлам в группах узлов](../managed-kubernetes/concepts/index.md#node-group) в составе [кластеров Yandex Managed Service for Kubernetes](../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Преимущества OS Login:

* Моментальное обновление [прав доступа](../iam/concepts/access-control/roles.md) для пользователя внутри ВМ в случае отзыва или назначения ролей. Если у пользователя отозвать роли, он потеряет доступ ко всем ВМ, для которых был включен доступ через OS Login.
* Возможность использовать разные способы доступа к ВМ: как по короткоживущим SSH-сертификатам, так и по SSH-ключам, в том числе добавленным в профиль пользователя организации.

Подробнее читайте в разделе [OS Login](concepts/os-login.md).

## Что дальше {#what-is-next}

* [Подробнее о взаимосвязи организаций с другими сервисами](concepts/organization.md)
* [Управление организациями](operations/organizations-overview.md)
* [Управление группами пользователей](operations/manage-groups.md)
* [Управление федерациями удостоверений](operations/manage-federations.md)
* [Разграничение прав доступа для групп пользователей с различными ролями](tutorials/user-group-access-control.md)
* [Чеклист безопасности аутентификации и авторизации](../security/domains/iam-checklist.md).