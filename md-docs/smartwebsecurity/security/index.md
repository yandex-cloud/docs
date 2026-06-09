# Управление доступом в {{ sws-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `smart-web-security.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/index.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на профили безопасности, которые в них находятся.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![service-roles-hierarchy](../../_assets/smartwebsecurity/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

Роль `smart-web-security.auditor` позволяет просматривать метаданные ресурсов сервиса {{ sws-name }}, а также информацию об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../concepts/profiles.md);
* просматривать список [ресурсов](../operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../concepts/waf.md);
* просматривать информацию о [профилях ARL](../concepts/arl.md);
* просматривать информацию о [прокси-серверах](../concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../concepts/response-templates.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Назначить роль `smart-web-security.auditor` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.viewer {#smart-web-security-viewer}

Роль `smart-web-security.viewer` позволяет просматривать информацию о ресурсах сервиса {{ sws-name }}, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../concepts/profiles.md);
* просматривать список [ресурсов](../operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../concepts/waf.md);
* просматривать информацию о [профилях ARL](../concepts/arl.md);
* просматривать информацию о [прокси-серверах](../concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../concepts/response-templates.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.auditor`.

Назначить роль `smart-web-security.viewer` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.user {#smart-web-security-user}

Роль `smart-web-security.user` позволяет просматривать информацию о ресурсах сервиса {{ sws-name }}, а также подключать профили безопасности к защищаемым ресурсам.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../concepts/profiles.md) {{ sws-name }} и подключать их к защищаемым ресурсам;
* просматривать список [ресурсов](../operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../concepts/waf.md);
* просматривать информацию о [профилях ARL](../concepts/arl.md);
* просматривать информацию о [прокси-серверах](../concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../concepts/response-templates.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.viewer`.

Назначить роль `smart-web-security.user` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.editor {#smart-web-security-editor}

Роль `smart-web-security.editor` позволяет использовать ресурсы сервиса {{ sws-name }} и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../concepts/profiles.md) {{ sws-name }}, создавать, изменять и удалять их, а также подключать профили безопасности к защищаемым ресурсам;
* просматривать список [ресурсов](../operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../concepts/waf.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [профилях ARL](../concepts/arl.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [прокси-серверах](../concepts/domain-protect.md#proxy), а также создавать, изменять и удалять их;
* просматривать информацию о [списках](../concepts/lists.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [шаблонах страниц ответов](../concepts/response-templates.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.user`.

Чтобы включать или отключать [логирование](../concepts/logging.md) в профиле безопасности, дополнительно необходима роль `logging.writer` или выше на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Назначить роль `smart-web-security.editor` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.

#### smart-web-security.admin {#smart-web-security-admin}

Роль `smart-web-security.admin` позволяет использовать ресурсы сервиса {{ sws-name }} и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../concepts/profiles.md) {{ sws-name }}, создавать, изменять и удалять их, а также подключать профили безопасности к защищаемым ресурсам;
* просматривать список [ресурсов](../operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../concepts/waf.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [профилях ARL](../concepts/arl.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [прокси-серверах](../concepts/domain-protect.md#proxy), а также создавать, изменять и удалять их;
* просматривать информацию о [списках](../concepts/lists.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [шаблонах страниц ответов](../concepts/response-templates.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.editor`.

Чтобы включать или отключать [логирование](../concepts/logging.md) в профиле безопасности, дополнительно необходима роль `logging.writer` или выше на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Назначить роль `smart-web-security.admin` может пользователь с ролью `admin` в облаке.

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