---
title: Как настроить домен в федерации удостоверений {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить домен в федерации удостоверений {{ org-name }}.
---

# Настроить домен в федерации удостоверений


{% include [note-preview](../../_includes/note-preview.md) %}

[Домен](../concepts/domains.md) дает возможность аутентифицироваться через систему [Login Discovery](../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в вашу [федерацию удостоверений](../concepts/add-federation.md).

## Привязать домен {#add}

{% include [add-domain-to-fed](../../_includes/organization/add-domain-to-fed.md) %}


## Получить список доменов {#list}

{% include [list-domain-in-fed](../../_includes/organization/list-domain-in-fed.md) %}

## Посмотреть информацию о домене {#get}

{% include [get-domain-in-fed](../../_includes/organization/get-domain-in-fed.md) %}

## Удалить домен {#delete}

Нельзя удалить домен по умолчанию или домен, к которому привязаны пользователи.

{% include [delete-domain-from-fed](../../_includes/organization/delete-domain-from-fed.md) %}