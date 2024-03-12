---
title: "Интерфейсы и порты компонентов {{ dataproc-full-name }}"
description: "Из статьи вы узнаете, какие интерфейсы и порты компонентов поддерживаются в {{ dataproc-name }}, а также как их использовать."
---

# Интерфейсы и порты компонентов {{ dataproc-name }}

Пользовательские веб-интерфейсы некоторых компонентов {{ dataproc-name }}, например Hadoop, Spark, Yarn и Zeppelin, доступны на хосте-мастере кластера. Эти интерфейсы могут быть использованы:

* для управления и мониторинга ресурсов кластеров — YARN Resource Manager и HDFS Name Node;
* для просмотра статуса и отладки заданий — Spark History и JobHistory;
* для совместной работы, экспериментов или ad-hoc операций — Apache Zeppelin.

{{ dataproc-name }} позволяет создавать кластеры с доступом из интернета или только из облачной сети, однако при любой конфигурации интерфейсы компонентов сервиса рекомендуется делать недоступными извне {{ yandex-cloud }}. Вы можете подключиться к интерфейсам компонентов {{ dataproc-name }} либо с помощью [UI Proxy](../operations/connect-interfaces.md#ui-proxy), либо с помощью [промежуточной виртуальной машины](../operations/connect-interfaces.md#routing).

UI Proxy — это механизм, который позволяет проксировать интерфейс компонентов кластера с шифрованием HTTP-трафика и аутентификацией через IAM {{ yandex-cloud }}. Чтобы получить доступ к интерфейсам, пользователь должен быть авторизован в {{ yandex-cloud }}, иметь права на просмотр кластера и обладать ролью `dataproc.user`.

UI Proxy по умолчанию отключен. Чтобы воспользоваться UI Proxy, включите его при [создании](../operations/cluster-create.md#create) или [настройке](../operations/connect-interfaces.md#ui-proxy-enable) кластера и [посмотрите](../operations/connect-interfaces.md#ui-proxy-list) список доступных веб-интерфейсов для подключения.

{% note warning %}

Для использования UI Proxy может потребоваться дополнительная [настройка групп безопасности](../operations/connect.md#configuring-security-groups).

{% endnote %}

## Компоненты и порты {#port-numbers}

{% include [ports-table](../../_includes/data-proc/ports-table.md) %}
