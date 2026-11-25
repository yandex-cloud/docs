---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.REQUEST_TIMEOUT
description: На странице приведено описание ошибки {{ datalens-full-name }} Backend app request timeout exceeded.
---

# [{{ datalens-full-name }}] Backend app request timeout exceeded

`ERR.DS_API.REQUEST_TIMEOUT`

Превышено время на обработку запроса.

Возможные причины ошибки:

* Долгая обработка запроса на стороне источника данных.
* Долгая подготовка запроса в источник данных на стороне {{ datalens-short-name }}.


* Файрвол запрещает обращение с адресов сервиса {{ datalens-short-name }}:

  {% list tabs group=ip_address %}

  - ipv4 {#ipv4}

    * `178.154.242.176/28`
    * `178.154.242.192/28`
    * `178.154.242.208/28`
    * `178.154.242.128/28`
    * `178.154.242.144/28`
    * `178.154.242.160/28`
    * `130.193.60.0/28`
    * `130.193.60.16/28`

  - ipv6 {#ipv6}

    * `2a02:6b8:c03:500:0:f83d:a987:0/112`
    * `2a02:6b8:c02:900:0:f83d:a987:0/112`
    * `2a02:6b8:c0e:500:0:f83d:a987:0/112`
    * `2a02:6b8:c41:1300:0:f83d:a987:0/112`
    * `2a02:6b8:c32::f83d:a987:0/112`

  {% endlist %}


{% include [datalens-dataset-timeout-recommendations](../../../_includes/datalens/datalens-dataset-timeout-recommendations.md) %}
