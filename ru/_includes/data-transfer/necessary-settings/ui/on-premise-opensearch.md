* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.addresses.title }}** — нажмите на значок ![image](../../../../_assets/data-transfer/add-datanode.svg), чтобы добавить новый узел с данными. Для каждого узла укажите:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.host.title }}** — IP-адрес или FQDN хоста с ролью `DATA`, к которому необходимо подключиться.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту с ролью `DATA`.

* {% include [Field CA certificate](../../fields/opensearch/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).


  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к кластеру.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — укажите пароль пользователя для доступа к кластеру.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
