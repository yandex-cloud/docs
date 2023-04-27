* {% include [Field Hosts list](../../fields/mongodb/ui/hosts-list.md) %}
* {% include [Field Replica Set](../../fields/mongodb/ui/replica-set.md) %}
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.

* {% include [Field CA certificate](../../fields/mongodb/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).


  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — укажите имя базы данных в кластере.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя для доступа к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
