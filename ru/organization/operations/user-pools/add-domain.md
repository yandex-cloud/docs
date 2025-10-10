---
title: Как привязать домен к пулу пользователей или федерации {{ org-full-name }}
description: Следуя данной инструкции, вы сможете привязать домен к пулу пользователей или федерации {{ org-name }}.
---

# Привязать домен


{% include [note-preview](../../../_includes/note-preview.md) %}

К [пулу пользователей](../../concepts/user-pools.md) или [федерации](../../concepts/add-federation.md) можно привязать [домен](../../concepts/domains.md), который дает возможность аутентифицироваться через систему [Login Discovery](../../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в вашу федерацию или пул пользователей.

Чтобы использовать домен в пуле пользователей или федерации, нужно [подтвердить](validate-domain.md) право владения им через DNS-запись.

{% note warning %}

Домен может быть привязан только к одному пулу пользователей или к одной федерации.

{% endnote %}

## Привязать домен к пулу пользователей {#userpool}

{% include [add-domain-to-pool](../../../_includes/organization/add-domain-to-pool.md) %}

## Привязать домен к федерации {#federation}

{% include [add-domain-to-fed](../../../_includes/organization/add-domain-to-fed.md) %}