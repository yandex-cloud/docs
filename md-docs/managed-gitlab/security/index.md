# Управление доступом в {{ mgl-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.


Для использования сервиса необходимо аутентифицироваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) аккаунтом.


## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `gitlab.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на организацию, [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли автоматически наследуются на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

```mermaid
flowchart BT
    gitlab.auditor --> gitlab.viewer
    gitlab.viewer --> gitlab.editor
    gitlab.editor --> gitlab.admin
```

### Сервисные роли {#service-roles}

#### gitlab.auditor {#gitlab-auditor}

Роль `gitlab.auditor` позволяет просматривать информацию об [инстансах](../concepts/index.md#instance) Managed Service for GitLab и [квотах](../concepts/limits.md#quotas) сервиса.

#### gitlab.viewer {#gitlab-viewer}

Роль `gitlab.viewer` позволяет просматривать информацию об [инстансах](../concepts/index.md#instance) Managed Service for GitLab и [квотах](../concepts/limits.md#quotas) сервиса.

Включает разрешения, предоставляемые ролью `gitlab.auditor`.

#### gitlab.editor {#gitlab-editor}

Роль `gitlab.editor` позволяет управлять инстансами Managed Service for GitLab и переносить их в другую зону доступности.

Пользователи с этой ролью могут:
* просматривать информацию об [инстансах](../concepts/index.md#instance) Managed Service for GitLab, а также создавать, изменять и удалять инстансы;
* переносить инстансы в другую [зону доступности](../../overview/concepts/geo-scope.md);
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Managed Service for GitLab.

Включает разрешения, предоставляемые ролью `gitlab.viewer`.

Для создания инстансов Managed Service for GitLab дополнительно необходима роль `vpc.user`.

#### gitlab.admin {#gitlab-admin}

Роль `gitlab.admin` позволяет управлять инстансами Managed Service for GitLab и переносить их в другую зону доступности.

Пользователи с этой ролью могут:
* просматривать информацию об [инстансах](../concepts/index.md#instance) Managed Service for GitLab, а также создавать, изменять и удалять инстансы;
* переносить инстансы в другую [зону доступности](../../overview/concepts/geo-scope.md);
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Managed Service for GitLab.

Включает разрешения, предоставляемые ролью `gitlab.editor`.

Для создания инстансов Managed Service for GitLab дополнительно необходима роль `vpc.user`.

### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../../overview/concepts/services.md) {{ yandex-cloud }}.

#### {{ roles-auditor }} {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе]({{ link-docs }}/resource-manager/concepts/resources-hierarchy);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### {{ roles-viewer }} {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services) в режиме чтения.

#### {{ roles-editor }} {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления, а также удаления [ключей шифрования]({{ link-docs }}/kms/concepts/) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### {{ roles-admin }} {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) или [платежный аккаунт]({{ link-docs }}/billing/concepts/billing-account), ознакомьтесь с информацией о защите [привилегированных аккаунтов]({{ link-docs }}/security/standard/all#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях см. в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md#primitive-roles).

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль [{{ roles.gitlab.editor }} или выше](../../iam/concepts/access-control/roles.md) на каталог, в котором создаются проекты. Роль `{{ roles.gitlab.viewer }}` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Чтобы создать инстанс {{ mgl-name }}, нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль `{{ roles.gitlab.editor }}` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.gitlab.admin }}` вместо `{{ roles.gitlab.editor }}`.


## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).