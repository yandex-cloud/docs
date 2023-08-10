# Общий порядок подключения

Для отправления запросов к поисковой базе Яндекса с помощью сервиса {{ search-api-full-name }} вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). 

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте сервисный аккаунт {#prepare-sa}

### Создайте сервисный аккаунт {#create-sa}

{% include [create-sa](../../_includes/iam/create-sa-via-console.md %}

### Назначьте роль {#grant-role}

Чтобы сервисный аккаунт мог отправлять запросы, ему понадобится [роль](../../iam/concepts/access-control/roles.md) работы с сервисом {{ search-api-name }}. Назначьте сервисному аккаунту роль `{{ roles-search-api-executor }}`:

{% include [create-sa](../../_includes/grant-role-console-sa.md %}

### Создайте API-ключ {#create-api-key}

Для аутентификации в сервисе {{ search-api }} сервисному аккаунту понадобится [API-ключ](../../iam/concepts/authorization/api-key.md). Создайте API-ключ для сервисного аккаунта:

{% include [create-console](../../_includes/iam/create-api-key-console.md) %}  
Для подключения и использования сервиса {{ search-api }} выполните следующие действия:

## Регистрация {#registration}

{% include [registration](../../_includes/search-api/registration.md) %}

## Создайте тестовый запрос {#test-request}

{% include [test-request](../../_includes/search-api/test-request.md) %}


## Настройте интеграцию с {{ search-api }} {#results}

1. Узнайте об особенностях [аутентификации](../operations/auth.md) в {{ yandex-cloud }} и настройте отправку запросов.
1. Настройте обработку ответа с учетом [формата ответа](../concepts/response.md).
1. При необходимости [запросите](../concepts/limits.md) информацию о часовых ограничениях на ближайшие сутки.