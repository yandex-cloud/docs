---
title: Как настроить домен в пуле пользователей {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить домен в пуле пользователей {{ org-name }}.
---

# Управление доменами в пуле пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

[Домен](../../concepts/domains.md) дает возможность аутентифицироваться через систему [Login Discovery](../../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в ваш [пул пользователей](../../concepts/user-pools.md).

## Привязать домен {#add}

{% include [add-domain-to-pool](../../../_includes/organization/add-domain-to-pool.md) %}

## Подтвердить домен {#validate}

Для добавления пользователей можно использовать только подтвержденные домены.

{% include [validate-domain-in-pool](../../../_includes/organization/validate-domain-in-pool.md) %}

## Получить список доменов {#list}

{% include [list-domain-in-pool](../../../_includes/organization/list-domain-in-pool.md) %}

## Посмотреть информацию о домене {#get}

{% include [get-domain-in-pool](../../../_includes/organization/get-domain-in-pool.md) %}

## Удалить домен {#delete}

Нельзя удалить домен по умолчанию или домен, к которому привязаны пользователи.

{% include [delete-domain-from-pool](../../../_includes/organization/delete-domain-from-pool.md) %}
