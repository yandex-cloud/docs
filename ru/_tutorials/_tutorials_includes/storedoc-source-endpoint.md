[Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

* **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MongoDB`.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.

    Укажите параметры подключения к кластеру-источнику.

{% note info %}

Так как сервис не поддерживает перенос коллекций `Time Series`, необходимо [исключить](../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) такие коллекции в настройках эндпоинта.

{% endnote %}
