---
title: Управление доступом в {{ speechkit-full-name }}
description: "Управление доступом в сервисе речевых технологии, распознавания и синтеза речи {{ speechkit-full-name }}. Разрешения выдаются при назначении роли. Роль можно назначить на каталог или облако — все разрешения от облака наследуются. Чтобы пользоваться сервисом, необходима одна из ролей — editor, admin, resource-manager.cloud.owner."
---

# Управление доступом в {{ speechkit-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control-without-service-account.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### {{ roles-speechkit-stt }} {#ai-speechkit-stt-user}

{% include notitle [roles-speechkit-stt-user](../../_includes/roles-speechkit-stt-user.md) %}

#### {{ roles-speechkit-tts }} {#ai-speechkit-tts-user}

{% include notitle [roles-speechkit-tts-user](../../_includes/roles-speechkit-tts-user.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

{% if product == "yandex-cloud" %}

### Роли других сервисов {#integration-roles}

При работе с {{ speechkit-name }} вам могут понадобиться роли других сервисов, например, чтобы загружать результаты и исходные материалы в бакет облачного хранилища {{ objstorage-name }}.

{% include [roles-integration](../../_includes/roles-integration-roles-speechkit.md) %}

{% endif %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md)
* [Как отозвать роль](../../iam/operations/roles/revoke.md)
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
