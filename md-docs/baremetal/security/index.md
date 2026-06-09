# Управление доступом в {{ baremetal-full-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему [ролями](../../iam/concepts/access-control/roles.md). Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ baremetal-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ baremetal-name }} можно использовать как сервисные, так и примитивные роли.

```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    baremetal.editor --> baremetal.admin
    baremetal.viewer --> baremetal.operator
    baremetal.operator --> baremetal.editor
    baremetal.auditor --> baremetal.viewer
```

### Сервисные роли {#service-roles}

#### baremetal.auditor {#baremetal-auditor}

Роль `baremetal.auditor` позволяет просматривать метаданные ресурсов сервиса {{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../concepts/server-configurations.md);
* просматривать информацию о [приватных подсетях](../concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }};
* просматривать информацию о [квотах](../concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### baremetal.viewer {#baremetal-viewer}

Роль `baremetal.viewer` позволяет просматривать информацию о ресурсах сервиса{{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../concepts/server-configurations.md);
* просматривать информацию о [приватных подсетях](../concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }};
* просматривать информацию о [квотах](../concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.auditor`.

#### baremetal.operator {#baremetal-operator}

Роль `baremetal.operator` позволяет работать на серверах {{ baremetal-name }}, а также просматривать информацию о ресурсах сервиса {{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../concepts/server-configurations.md);
* [использовать KVM-консоль](../operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [приватных подсетях](../concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов;
* просматривать информацию о [квотах](../concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.viewer`.

#### baremetal.editor {#baremetal-editor}

Роль `baremetal.editor` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.operator`.

{% note warning %}

С 1 августа 2026 года роль `baremetal.editor` получает новый набор разрешений, позволяющий подключать серверы к сервису [{{ backup-full-name }}](../../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](../../iam/concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](../../iam/operations/access-policies/assign.md).

{% endnote %}

#### baremetal.admin {#baremetal-admin}

Роль `baremetal.admin` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.editor`.

{% note warning %}

С 1 августа 2026 года роль `baremetal.admin` получает новый набор разрешений, позволяющий подключать серверы к сервису [{{ backup-full-name }}](../../backup/index.md), а также привязывать и отвязывать их от [политик резервного копирования](../../backup/concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](../../iam/concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](../../iam/operations/access-policies/assign.md).

{% endnote %}

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

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)