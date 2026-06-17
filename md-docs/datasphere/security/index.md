# Управление доступом в DataSphere

Доступ к сервису Yandex DataSphere регулируется путем назначения прав в организации. Управление организациями осуществляется с помощью сервиса [Yandex Identity Hub](../../organization/index.md).

Список операций, доступных пользователю DataSphere, определяется его ролью. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее об управлении доступом в Yandex Cloud см. раздел [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

## На какие ресурсы можно назначить роль {#resources}

Разграничение прав доступа происходит на уровне [сообществ](../concepts/community.md) и [проектов](../concepts/project.md). Также вы можете открыть доступ к ресурсу для всех пользователей сообщества, [опубликовав](../operations/index.md#share) его в сообществе. Выданные права доступа распространяются на всю иерархию ресурсов. Например, если вы назначите пользователю роль на проект DataSphere, то все разрешения будут действовать и на ресурсы внутри этого проекта. Подробнее о [взаимосвязи ресурсов в DataSphere](../concepts/resource-model.md).

## Как назначить роль {#grant-role}

Вы можете назначить роль пользователю в интерфейсе DataSphere:
* [Добавить пользователя в сообщество](../operations/community/add-user.md).
* [Добавить пользователя в проект](../operations/projects/add-user.md).
* [Поделиться ресурсами с участниками сообщества](../operations/index.md#share).

Также вы можете назначить права доступа через [интерфейс Yandex Identity Hub в Cloud Center](https://center.yandex.cloud/organization), с помощью [Terraform](../../terraform/index.md) и [API Yandex Cloud](../api-ref/authentication.md).

## Какие роли действуют в сервисе {#roles-list}

```mermaid
flowchart BT
    datasphere.community-projects.viewer --> datasphere.community-projects.developer
    datasphere.community-projects.developer --> datasphere.community-projects.editor
    datasphere.community-projects.editor --> datasphere.community-projects.admin
    datasphere.community-projects.viewer --> datasphere.communities.viewer
    datasphere.communities.viewer --> datasphere.communities.developer
    datasphere.communities.developer --> datasphere.communities.editor
    datasphere.community-projects.editor --> datasphere.communities.editor
    datasphere.communities.editor --> datasphere.communities.admin
    datasphere.community-projects.admin --> datasphere.communities.admin
```

### Сервисные роли {#service-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

Роль `datasphere.community-projects.viewer` позволяет просматривать информацию о [проектах](../concepts/project.md), настройках проектов и закрепленных за ними [ресурсах](../concepts/resources.md), а также о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к проектам.

В интерфейсе DataSphere пользователи с ролью `datasphere.community-projects.viewer` имеют роль `Viewer` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

Роль `datasphere.community-projects.developer` позволяет работать в проектах и управлять ресурсами, которые закреплены за проектами.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../concepts/project.md), настройках проектов и закрепленных за ними [ресурсах](../concepts/resources.md);
* создавать, изменять и удалять ресурсы в проектах;
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к проектам.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.viewer`.

В интерфейсе DataSphere пользователи с ролью `datasphere.community-projects.developer` имеют роль `Developer` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

Роль `datasphere.community-projects.editor` позволяет работать в проектах, изменять и удалять их, а также управлять ресурсами, которые закреплены за проектами, и делиться такими ресурсами в сообществе.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../concepts/project.md), настройках проектов и закрепленных за ними ресурсах, а также изменять и удалять проекты;
* создавать, изменять и удалять [ресурсы](../concepts/resources.md) в проектах, а также делиться ресурсами этого проекта с сообществами, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer` и выше);
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к проектам.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.developer`.

В интерфейсе DataSphere пользователи с ролью `datasphere.community-projects.editor` имеют роль `Editor` на вкладке **Участники** на странице проекта.

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

Роль `datasphere.community-projects.admin` позволяет управлять доступом к проектам, работать в них, изменять и удалять проекты, а также управлять ресурсами, которые закреплены за проектами, и делиться такими ресурсами в сообществе.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к проектам и изменять права доступа;
* просматривать информацию о [проектах](../concepts/project.md), настройках проектов и закрепленных за ними ресурсах, а также изменять и удалять проекты;
* создавать, изменять и удалять [ресурсы](../concepts/resources.md) в проектах, а также делиться ресурсами этого проекта с сообществами, в которых пользователь имеет роль `Developer` (`datasphere.communities.developer`) и выше;
* запускать IDE и исполнение ячеек с кодом в проектах.

Включает разрешения, предоставляемые ролью `datasphere.community-projects.editor`.

В интерфейсе DataSphere пользователи с ролью `datasphere.community-projects.admin` имеют роль `Admin` на вкладке **Участники** на странице проекта.

#### datasphere.communities.viewer {#datasphere-communities-viewer}

Роль `datasphere.communities.viewer` позволяет просматривать информацию о сообществах и проектах, а также о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../concepts/community.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [проектах](../concepts/project.md) сообществ, настройках проектов и закрепленных за ними [ресурсах](../concepts/resources.md), а также о назначенных правах доступа к проектам;
* просматривать информацию об [организации](../../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролью `datasphere.community-projects.viewer`.

В интерфейсе DataSphere пользователи с ролью `datasphere.communities.viewer` имеют роль `Viewer` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.developer {#datasphere-communities-developer}

Роль `datasphere.communities.developer` позволяет создавать новые проекты и публиковать ресурсы проектов в сообществах, а также просматривать информацию о сообществах и проектах.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../concepts/community.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* создавать новые [проекты](../concepts/project.md) в сообществах;
* публиковать [ресурсы](../concepts/resources.md) проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer`) и выше;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах, а также о назначенных правах доступа к проектам;
* просматривать информацию об [организации](../../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролью `datasphere.communities.viewer`.

В интерфейсе DataSphere пользователи с ролью `datasphere.communities.developer` имеют роль `Developer` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.editor {#datasphere-communities-editor}

Роль `datasphere.communities.editor` позволяет привязывать платежный аккаунт к сообществам, удалять сообщества и редактировать их настройки, а также управлять проектами и ресурсами сообществ.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../concepts/community.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также изменять и удалять сообщества;
* привязывать [платежный аккаунт](../../billing/concepts/billing-account.md) к сообществам;
* создавать новые [проекты](../concepts/project.md) в сообществах, а также изменять и удалять проекты;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах, а также о назначенных правах доступа к проектам;
* создавать, изменять и удалять [ресурсы](../concepts/resources.md) в проектах, а также публиковать ресурсы проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer`) и выше;
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию об [организации](../../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролями `datasphere.communities.developer` и `datasphere.community-projects.editor`.

В интерфейсе DataSphere пользователи с ролью `datasphere.communities.editor` имеют роль `Editor` на вкладке **Участники** на странице сообщества.

#### datasphere.communities.admin {#datasphere-communities-admin}

Роль `datasphere.communities.admin` позволяет управлять сообществами и проектами сообществ, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [сообществах](../concepts/community.md), а также изменять и удалять сообщества;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к сообществам и изменять права доступа;
* привязывать [платежный аккаунт](../../billing/concepts/billing-account.md) к сообществам;
* создавать новые [проекты](../concepts/project.md) в сообществах, а также изменять и удалять проекты;
* просматривать информацию о проектах, настройках проектов и закрепленных за ними ресурсах;
* просматривать информацию о назначенных правах доступа к проектам и изменять права доступа;
* создавать, изменять и удалять [ресурсы](../concepts/resources.md) в проектах, а также публиковать ресурсы проектов в сообществах, в которых пользователь имеет права `Developer` (роль `datasphere.communities.developer` и выше);
* запускать IDE и исполнение ячеек с кодом в проектах;
* просматривать информацию об [организации](../../organization/concepts/organization.md).

Включает разрешения, предоставляемые ролями `datasphere.communities.editor` и `datasphere.community-projects.admin`.

В интерфейсе DataSphere пользователи с ролью `datasphere.communities.admin` имеют роль `Admin` на вкладке **Участники** на странице сообщества.

> Например, Валя работает с несколькими командами и состоит в их сообществах с разными правами доступа:
  
  * в сообществе <q>Любители котиков</q> — `Admin` (роль `datasphere.communities.admin`);
  * в сообществе <q>Считаем заборы</q> — `Developer` (роль `datasphere.communities.developer`);
  * в сообществе <q>Совершенно секретно</q> — `Viewer` (роль `datasphere.communities.viewer`), но имеет права `Editor` в проекте <q>Project_111</q> этого сообщества (роль `datasphere.community-projects.editor`).
  
  Валя может:
  
  * поделиться ресурсами любого проекта из сообщества <q>Любители котиков</q> в этом сообществе.
  * поделиться ресурсами любого проекта из сообщества <q>Любители котиков</q> в сообществе <q>Считаем заборы</q>.
  * опубликовать ресурсы проекта <q>Project_111</q> в сообществах <q>Любители котиков</q> и <q>Считаем заборы</q>, но не сможет поделиться ими в сообществе <q>Совершенно секретно</q>.

### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../../overview/concepts/services.md) Yandex Cloud.

#### auditor {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе](../../resource-manager/concepts/resources-hierarchy.md);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов](../../overview/concepts/services.md). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### viewer {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов](../../overview/concepts/services.md) в режиме чтения.

#### editor {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления, а также удаления [ключей шифрования](../../kms/concepts/index.md) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### admin {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [платежный аккаунт](../../billing/concepts/billing-account.md), ознакомьтесь с информацией о защите [привилегированных аккаунтов](../../security/standard/all.md#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md#primitive-roles).

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `Editor` вместо `Viewer`.

#|
|| **Действие** | **Необходимые роли** ||
|| **Просмотр информации** ||
|| Просмотр проекта, его настроек и пользователей | `Viewer` на проект ||
|| Просмотр сообщества, его настроек и пользователей | `Viewer` на сообщество ||
|| **Управление проектом** ||
|| [Создание проекта](../operations/projects/create.md) | `Developer` на сообщество ||
|| Запуск IDE | `Developer` на проект ||
|| Использование ресурсов | `Developer` на проект ||
|| Создание ресурсов | `Developer` на проект ||
|| Удаление ресурсов | `Developer` на проект ||
|| Публикация ресурсов в сообществе | `Editor` на проект и `Developer` на сообщество ||
|| [Изменение настроек проекта](../operations/projects/update.md) | `Editor` на проект ||
|| [Удаление проекта](../operations/projects/delete.md) | `Editor` на проект ||
|| [Выдача роли](#grant-role) в проекте | `Admin` на проект ||
|| **Управление сообществом** ||
|| Изменение настроек сообщества | `Editor` на сообщество ||
|| [Привязка платежного аккаунта](../operations/community/link-ba.md) | `Editor` на сообщество и `billing.accounts.editor` на платежный аккаунт ||
|| [Удаление сообщества](../operations/community/delete.md) | `Editor` на сообщество ||
|| [Выдача роли](#grant-role) в сообществе | `Admin` на сообщество ||
|#

#### Полезные ссылки {#see-also}

* [Yandex Identity Hub](../../organization/index.md).
* [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).
* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).