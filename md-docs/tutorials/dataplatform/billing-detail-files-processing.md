# Обработка файлов детализации в сервисе {{ billing-name }}

[{{ billing-name }}](../../billing/index.md) позволяет получать информацию об объеме использованных ресурсов, проверять расходы денежных средств и оплачивать потребление ресурсов. Детализацию расходов можно отправлять в [{{ objstorage-full-name }}](../../storage/index.md) и далее обрабатывать с помощью [{{ yq-full-name }}](../../query/index.md).

Сервисы {{ billing-name }} и {{ yq-name }} интегрированы между собой. Вы можете использовать заранее подготовленные запросы для решения типовых задач анализа детализации оплаты ресурсов, а также создавать собственные [запросы на языке YQL](../../query/yql-tutorials/index.md).

![](../../_assets/query/billing-query.png)

В {{ yq-name }} заранее подготовлены запросы для получения следующей информации:

* потребление по месяцам;
* потребление текущего месяца с разбивкой по сервисам и продуктам;
* потребление текущего месяца с разбивкой по облакам и каталогам;
* 10 наиболее дорогих ресурсов;
* оплата фиксированного потребления;
* утилизация фиксированного потребления;
* детализация по кластерам {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Настройте интеграцию сервисов {{ billing-name }} и {{ yq-name }} {#integration}

Для настройки интеграции выполните следующие действия:

1. Перейдите к списку выгрузок детализации расходов в консоли {{ yandex-cloud }}.
1. Выберите необходимую детализацию и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.exports.button_open-yandex-query }}**.
1. При первом переходе из сервиса {{ billing-name }} в {{ yq-full-name }} необходимо выполнить настройку интеграции:
   1. В интерфейсе {{ yq-name }} в диалоге создания соединения выберите сервисный аккаунт, от имени которого будет выполняться чтение данных из {{ objstorage-name }}, и нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
   1. В интерфейсе {{ yq-name }} в диалоге создания привязки к данным проверить предустановленные параметры, нажав кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**, после чего завершить интеграцию, нажав кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.
   1. После завершения настроек интеграции, вы будете автоматически перемещены в раздел **{{ ui-key.yql.yq-billing.billing.title }}**.

## Выполните запрос к данным {#query}

Для выполнения запросов к аналитическим данным сервиса {{ billing-name }}, хранящимся в {{ objstorage-name }}, выполните следующие действия:

1. В разделе **{{ ui-key.yql.yq-billing.billing.title }}** в интерфейсе {{ yq-name }} выберите в списке [привязок к данным](../../query/concepts/glossary.md#binding) нужную.
1. Выберите нужный запрос к данным из {{ objstorage-name }} из списка и нажмите кнопку **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

Результаты обработки данных можно:

* скачать через интерфейс пользователя {{ yq-full-name }} с помощью кнопки **Экспорт**;
* [сохранить в бакет](../../query/sources-and-sinks/object-storage-write.md) {{ objstorage-name }};
<!-- * [визуализировать](../../query/tutorials/datalens.md) в {{ datalens-full-name }}; -->
* получить и обработать через [{{ yq-name }} HTTP API](../../query/api/index.md).

## См. также {#see-also}

* [{{ objstorage-full-name }}](../../storage/index.md).
* [{{ datalens-full-name }}](../../datalens/index.md).