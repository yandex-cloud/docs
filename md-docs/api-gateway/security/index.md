# Управление доступом в API Gateway

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `api-gateway.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса Yandex Resource Manager.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль на облако:

1. При необходимости [добавьте](../../organization/operations/add-account.md) нужного пользователя.
1. В [консоли управления](https://console.yandex.cloud) слева [выберите](../../resource-manager/operations/cloud/switch-cloud.md) облако.
1. Перейдите на вкладку **Права доступа**.
1. Нажмите кнопку **Настроить доступ**.
1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
1. Выберите пользователя из списка или воспользуйтесь поиском.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль в облаке.
1. Нажмите кнопку **Сохранить**.

Подробнее о назначении ролей см. в документации сервиса [Yandex Identity and Access Management](../../iam/operations/roles/grant.md).

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

На [API-шлюз](../concepts/index.md) роль можно назначить через Yandex Cloud [CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/add-access-binding.md) или [API](../api-ref/apigateway/authentication.md).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе API Gateway.

### Сервисные роли {#service-roles}

```mermaid
flowchart BT
    auditor["api-gateway.auditor"] --> viewer1["api-gateway.viewer"]
    viewer1 --> editor["api-gateway.editor"]
    viewer1 --> websocketWriter["api-gateway.websocketWriter"]
    websocketWriter --> websocketBroadcaster["api-gateway.websocketBroadcaster"]
    viewer1 --> websocketBroadcaster
    websocketWriter --> editor
    editor --> admin["api-gateway.admin"]
```

#### api-gateway.auditor {#api-gateway-auditor}

Роль `api-gateway.auditor` позволяет просматривать список [API-шлюзов](../concepts/index.md) и информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также метаинформацию [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### api-gateway.viewer {#api-gateway-viewer}

Роль `api-gateway.viewer` позволяет просматривать список [API-шлюзов](../concepts/index.md), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.auditor`.

#### api-gateway.editor {#api-gateway-editor}

Роль `api-gateway.editor` позволяет просматривать информацию об API-шлюзах и управлять ими, а также работать с API WebSocket.

Пользователи с этой ролью могут:
* просматривать список [API-шлюзов](../concepts/index.md), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также создавать, изменять и удалять API-шлюзы;
* использовать ограничение [скорости обработки запросов](../concepts/extensions/rate-limit.md);
* просматривать информацию о соединениях [WebSocket](../concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.websocketWriter`.

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

Роль `api-gateway.websocketWriter` позволяет работать с API WebSocket, а также просматривать список API-шлюзов, информацию о них и о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о соединениях [WebSocket](../concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* просматривать список [API-шлюзов](../concepts/index.md), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.viewer`.

#### api-gateway.websocketBroadcaster {#api-gateway-websocketBroadcaster}

Роль `api-gateway.websocketBroadcaster` позволяет отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам, а также просматривать список API-шлюзов, информацию о них и о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о соединениях [WebSocket](../concepts/index.md#websocket) и закрывать их, а также отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам;
* просматривать список [API-шлюзов](../concepts/index.md), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.websocketWriter`.

#### api-gateway.admin {#api-gateway-admin}

Роль `api-gateway.admin` позволяет управлять API-шлюзами и доступом к ним, просматривать информацию об API-шлюзах, а также работать с API WebSocket.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к API-шлюзам и изменять такие права доступа;
* просматривать список [API-шлюзов](../concepts/index.md) и информацию о них, а также создавать, изменять и удалять API-шлюзы;
* просматривать информацию о соединениях [WebSocket](../concepts/index.md#websocket) и закрывать их, а также отправлять данные через такие соединения;
* использовать ограничение [скорости обработки запросов](../concepts/extensions/rate-limit.md);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.editor`.

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

Подробнее о примитивных ролях см. в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md#primitive-roles).