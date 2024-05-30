# Как начать работать с {{ websql-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

{{ websql-full-name }} — это сервис {{ yandex-cloud }}, который позволит вам подключаться к кластерам управляемых баз данных и публично доступным базам данных. Вы можете просматривать таблицы и схемы базы данных, а также выполнять SQL-запросы. Сервис работает в браузере и предлагает удобные подсказки и команды для выполнения SQL-запросов.

В этом разделе вы научитесь подключаться:

* к [кластерам управляемых баз данных](#connect-cluster) внутри {{ yandex-cloud }};
* к [публично доступным базам данных](#connect-db) через Интернет.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или [зарегистрируйтесь](https://yandex.ru/support/id/authorization/registration.html), если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
1. Выберите организацию, в которой вы будете работать с {{ websql-full-name }}, или [создайте новую](../organization/operations/enable-org).

## Подключиться к кластеру управляемых баз данных внутри {{ yandex-cloud }} {#connect-cluster}

{% include [clickhouse-warning](../_includes/websql/clickhouse-warning.md) %}

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

Если подключение прошло успешно, то в дереве диспетчера подключений отобразится структура кластера. Хосты одного и того же кластера будут отображаться в _группе соединений_.

## Подключиться к публично доступной базе данных {#connect-db}

Чтобы подключиться к публично доступной базе данных через Интернет:

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

Если подключение прошло успешно, то в дереве диспетчера подключений отобразится структура базы данных.

## Что дальше {#what-is-next}

* [Выполняйте SQL-запросы](operations/query-executor.md).
* [Создавайте шаблоны запросов](operations/templates.md).
* [Просматривайте историю запросов](operations/history.md).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
