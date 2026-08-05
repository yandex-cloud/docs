---
title: Как удалить домен из пула пользователей или федерации {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалить домен из пула пользователей или федерации {{ org-full-name }}.
---

# Удалить домен


Нельзя удалить [домен](../../concepts/domains.md), если:
* домен является доменом по умолчанию;
* к домену привязаны пользователи — то есть в пуле пользователей или федерации существуют учётные записи, использующие адреса электронной почты с этим доменом.

## Удалить домен из пула пользователей {#userpool}

{% include [delete-domain-from-pool](../../../_includes/organization/delete-domain-from-pool.md) %}

## Удалить домен из федерации {#federation}

{% include [delete-domain-from-fed](../../../_includes/organization/delete-domain-from-fed.md) %}