---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.CONNECTION_CONFIG.SUBSELECT_NOT_ALLOWED
description: На странице приведено описание ошибки {{ datalens-full-name }} Subquery source is disallowed in the connection settings.
---

# [{{ datalens-full-name }}] Subquery source is disallowed in the connection settings

`ERR.DS_API.CONNECTION_CONFIG.SUBSELECT_NOT_ALLOWED`

Ошибка возникает, когда подзапросы к источнику запрещены в настройках подключения.

Чтобы исправить ошибку, в настройках подключения включите опцию **Уровень доступа SQL запросов**.

{% note info %}

Опция доступна в настройках некоторых [подключений](../../concepts/connection/index.md) к БД. Подробнее см. описание конкретного типа подключения.

{% endnote %}