---
title: Общий порядок подключения к {{ search-api-full-name }} для интерфейса API v1
description: Следуя данной инструкции, вы сможете подключиться к сервису {{ search-api-name }} для работы с ним через интерфейс API v1.
---

# Общий порядок подключения

Для отправки запросов к поисковой базе Яндекса с помощью сервиса {{ search-api-full-name }} через интерфейс API v1 вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). 

Чтобы настроить сервис {{ search-api }} для использования через API v1:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте сервисный аккаунт](#prepare-sa).
1. [Зарегистрируйтесь в сервисе {{ search-api-name }}](#registration).
1. [Создайте тестовый запрос](#test-request).
1. [Настройте интеграцию с {{ search-api }}](#results).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте сервисный аккаунт {#prepare-sa}

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-sa](../../_includes/iam/create-sa-via-console-without-role.md) %}

{% endlist %}

### Назначьте роль {#grant-role}

Чтобы сервисный аккаунт мог отправлять запросы к сервису {{ search-api-name }} через API v1, [назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) ему [роль](../security/index.md#search-api-executor) `{{ roles-search-api-executor }}`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-sa](../../_includes/grant-role-console-sa.md) %}

{% endlist %}

### Создайте API-ключ {#create-api-key}

Для [аутентификации](./auth.md) в API v1 {{ search-api }} сервисному аккаунту понадобится [API-ключ](../../iam/concepts/authorization/api-key.md). Создайте API-ключ для сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-console](../../_includes/iam/create-api-key-console.md) %}  

{% endlist %}

## Зарегистрируйтесь в сервисе {{ search-api-name }} {#registration}

Чтобы использовать интерфейс API v1, необходимо зарегистрироваться в сервисе {{ search-api-name }}:

{% include [registration](../../_includes/search-api/registration.md) %}

## Создайте тестовый запрос {#test-request}

{% include [test-request](../../_includes/search-api/test-request.md) %}


## Настройте интеграцию с {{ search-api }} {#results}

1. Узнайте об особенностях [аутентификации](./auth.md) в API v1 и настройте отправку запросов.
1. Настройте обработку ответа с учетом формата ответа в [XML](../concepts/response.md) или [HTML](../concepts/html-response.md).
1. При необходимости [запросите](../concepts/limits.md) информацию о часовых ограничениях на ближайшие сутки.