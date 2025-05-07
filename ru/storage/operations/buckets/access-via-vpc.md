---
title: Доступ в бакет с помощью сервисного подключения из {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете настроить доступ в бакет с помощью сервисного подключения из {{ vpc-name }}.
---

# Доступ в бакет с помощью сервисного подключения из {{ vpc-full-name }}

{% include [vpc-pe-preview](../../../_includes/vpc/pe-preview.md) %}

{% include [intro-access-via-vpc](../../../_includes/storage/intro-access-via-vpc.md) %}

Чтобы организовать доступ в бакет с помощью сервисного подключения из {{ vpc-short-name }}:
1. [Создайте сервисное подключение {{ vpc-short-name }}](#create-endpoint).
1. [Настройте политику доступа для бакета](#setup-policy).
1. [Настройте ограничение для доступа только из сервисных подключений](#setup-service-restriction).

## Создайте сервисное подключение {{ vpc-short-name }} {#create-endpoint}

{% include [private-endpoint-create-roles](../../../_includes/vpc/private-endpoint-create-roles.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../../_includes/vpc/private-endpoint-create-cli.md) %}

{% endlist %}

Сохраните идентификатор сервисного подключения.

Теперь бакеты {{ objstorage-name }} доступны по внутреннему IP-адресу {{ vpc-short-name }} без использования доступа в интернет.

## Настройте политику доступа для бакета {#setup-policy}

Чтобы разрешить доступ к бакету только по внутренним IP-адресам {{ vpc-short-name }}, настройте для бакета политику доступа для сервисного подключения.

{% include [private-endpoint-policy-tabs](../../../_includes/storage/private-endpoint-policy-tabs.md) %}

## Настройте ограничение для доступа только из сервисных подключений {#setup-service-restriction}

{% include [private-endpoint-storage-restriction](../../../_includes/storage/private-endpoint-storage-restriction.md) %}

{% include [private-endpoint-ssc](../../../_includes/storage/private-endpoint-ssc.md) %}

#### См. также {#see-also}

* [Сервисные подключения {{ vpc-short-name }}](../../../vpc/concepts/private-endpoint.md)
* [Работа с сервисными подключениями {{ vpc-short-name }}](../../../vpc/operations/index.md#private-endpoint)
* [Политика доступа (bucket policy)](../../../storage/concepts/policy.md)
* [Подключение к {{ objstorage-name }} из {{ vpc-name }}](../../../storage/tutorials/storage-vpc-access.md)
* [{#T}](../../security/overview.md)
