# Управление доступом в {{ interconnect-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему [ролями](../../iam/concepts/access-control/roles.md). Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ interconnect-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть [назначена](../../iam/operations/roles/grant.md) на родительский ресурс (каталог или облако) и на организацию.

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль на облако:

1. При необходимости [добавьте](../../organization/operations/add-account.md) нужного пользователя.
1. В [консоли управления]({{ link-console-main }}) слева [выберите](../../resource-manager/operations/cloud/switch-cloud.md) облако.
1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.user-accounts }}**.
1. Выберите пользователя из списка или воспользуйтесь поиском.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль в облаке.
1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

Подробнее о назначении ролей см. в документации сервиса [{{ iam-full-name }}](../../iam/operations/roles/grant.md).

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.


## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ interconnect-name }}.

```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    cic.auditor --> cic.viewer
    cic.viewer --> cic.editor
    cic.editor --> cic.admin
    cic.secretViewer --> cic.secretEditor
```

### Сервисные роли {#service-roles}

#### cic.auditor {#cic-auditor}

Роль `cic.auditor` позволяет просматривать информацию о ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [точках присутствия](../concepts/pops.md);
* просматривать информацию о [партнерах CIC](../concepts/partners.md);
* просматривать информацию о [транковых подключениях](../concepts/trunk.md);
* просматривать информацию о [приватных соединениях](../concepts/priv-con.md);
* просматривать информацию о [публичных соединениях](../concepts/pub-con.md);
* просматривать информацию о [квотах](../concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

#### cic.viewer {#cic-viewer}

Роль `cic.viewer` позволяет просматривать информацию о ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [точках присутствия](../concepts/pops.md);
* просматривать информацию о [партнерах CIC](../concepts/partners.md);
* просматривать информацию о [транковых подключениях](../concepts/trunk.md);
* просматривать информацию о [приватных соединениях](../concepts/priv-con.md);
* просматривать информацию о [публичных соединениях](../concepts/pub-con.md);
* просматривать информацию о [квотах](../concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.auditor`.

#### cic.editor {#cic-editor}

Роль `cic.editor` позволяет управлять транковыми подключениями, приватными и публичными соединениями, а также просматривать информацию о квотах и ресурсах сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [транковых подключениях](../concepts/trunk.md), а также создавать, изменять и удалять их;
* просматривать информацию о [приватных соединениях](../concepts/priv-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [публичных соединениях](../concepts/pub-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [точках присутствия](../concepts/pops.md);
* просматривать информацию о [партнерах CIC](../concepts/partners.md);
* просматривать информацию о [квотах](../concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.viewer`.

#### cic.admin {#cic-admin}

Роль `cic.admin` позволяет управлять ресурсами сервиса {{ interconnect-name }}.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [транковых подключениях](../concepts/trunk.md), а также создавать, изменять и удалять их;
* просматривать информацию о [приватных соединениях](../concepts/priv-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [публичных соединениях](../concepts/pub-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [точках присутствия](../concepts/pops.md);
* просматривать информацию о [партнерах CIC](../concepts/partners.md);
* просматривать информацию о [квотах](../concepts/limits.md#interconnect-quotas) сервиса {{ interconnect-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.editor`.

#### cic.secretViewer {#cic-secretviewer}

Роль `cic.secretViewer` позволяет получать секреты [приватных](../concepts/priv-con.md) и [публичных](../concepts/pub-con.md) соединений {{ interconnect-name }}.

#### cic.secretEditor {#cic-secreteditor}

Роль `cic.secretEditor` позволяет получать и изменять секреты [приватных](../concepts/priv-con.md) и [публичных](../concepts/pub-con.md) соединений {{ interconnect-name }}.

Включает разрешения, предоставляемые ролью `cic.secretViewer`.

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