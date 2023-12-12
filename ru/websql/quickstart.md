# Как начать работать с {{ websql-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

В этом разделе вы научитесь подключаться к кластерам управляемых баз данных с помощью {{ websql-full-name }}.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или [зарегистрируйтесь](https://yandex.ru/support/id/authorization/registration.html), если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
1. Выберите организацию, в которой вы будете работать с {{ websql-full-name }}, или [создайте новую](../organization/operations/enable-org).

## Подключение к базе данных {#connect-to-db}

Создайте первое подключение к базе данных.

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

Если у вас есть кластер [{{ PG }}](../managed-postgresql/operations/cluster-list.md), [{{ CH }}](../managed-clickhouse/operations/cluster-list.md) или [{{ MY }}](../managed-mysql/operations/cluster-list.md), настроенный в {{ yandex-cloud }}, то вы можете подключиться прямо к нему:

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

Если подключение прошло успешно, то в дереве диспетчера подключений отобразится структура кластера или базы данных. Хосты одного и того же кластера будут отображаться в _группе соединений_.

## Что дальше {#what-is-next}

* [Выполняйте SQL-запросы](operations/query-executor.md).
* [Создавайте шаблоны запросов](operations/templates.md).
* [Просматривайте историю запросов](operations/history.md).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}