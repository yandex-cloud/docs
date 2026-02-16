---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.REQUEST_TIMEOUT
description: На странице приведено описание ошибки {{ datalens-full-name }} Backend app request timeout exceeded.
---

# [{{ datalens-full-name }}] Backend app request timeout exceeded

`ERR.DS_API.REQUEST_TIMEOUT`

Превышено время на обработку запроса.

Возможные причины ошибки:

* долгая обработка запроса на стороне источника данных;
* долгая подготовка запроса в источник данных на стороне {{ datalens-short-name }}.

{% include [datalens-dataset-timeout-recommendations](../../../_includes/datalens/datalens-dataset-timeout-recommendations.md) %}
