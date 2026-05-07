[Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following settings:

* **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.

    Configure the source cluster connection settings.

{% note info %}

Transferring of `Time Series` collections is not supported, so you should [exclude](../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) such collections in the endpoint settings.

{% endnote %}
