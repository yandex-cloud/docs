# Как начать работать с {{ websql-full-name }}

Вы можете устанавливать подключения к кластерам управляемых БД из облаков и каталогов, которые принадлежат вашей [организации](../organization/concepts/organization.md) {{ yandex-cloud }}. Если вы [перейдете в другую организацию](../organization/operations/manage-organizations.md#switch-to-another-org), то вам будет доступен набор кластеров из других облаков и каталогов. Добавленные подключения будут доступны, пока вы работаете в текущей организации {{ yandex-cloud }}.

Подключившись к БД, вы сможете просматривать схемы, таблицы и представления БД, а также выполнять запросы. Сервис работает в браузере и предлагает удобные подсказки и команды для выполнения запросов.

{{ websql-full-name }} поддерживает работу со следующими версиями БД:

* {{ PG }}: 12 и выше.
* {{ MY }}: 5 и выше.
* {{ CH }}: 23 и выше.
* {{ RD }}/{{ VLK }} (только нешардированные кластеры): 6 и выше.
* {{ MG }}: 6 и выше.

В этом разделе вы научитесь подключаться:

* к [кластерам управляемых БД](#connect-cluster) внутри {{ yandex-cloud }};
* к [публично доступным БД](#connect-db) через Интернет.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или [зарегистрируйтесь](https://yandex.ru/support/id/authorization/registration.html), если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
1. Выберите организацию, в которой вы будете работать с {{ websql-full-name }}, или [создайте новую](../organization/operations/enable-org).

## Как подключиться к кластеру управляемых БД внутри {{ yandex-cloud }} {#connect-cluster}

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

Если подключение прошло успешно, то в дереве подключений отобразится структура кластера. Подключения к БД одного кластера группируются в разворачивающийся список под именем этого кластера.

## Как подключиться к публично доступной БД {#connect-db}

Чтобы подключиться к публично доступной БД через Интернет:

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

Если подключение прошло успешно, то в дереве подключений отобразится структура БД.

## Что дальше {#what-is-next}

* [Управляйте подключениями](operations/connect.md).
* [Выполняйте запросы](operations/query-executor.md).
* [Создавайте шаблоны запросов](operations/templates.md).
* [Просматривайте историю запросов](operations/history.md).

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
