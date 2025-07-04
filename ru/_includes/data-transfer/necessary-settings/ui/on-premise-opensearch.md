
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.

        Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.addresses.title }}** — нажмите на значок ![image](../../../../_assets/console-icons/plus.svg), чтобы добавить новый узел с данными. Для каждого узла укажите:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.host.title }}** — IP-адрес или FQDN хоста с ролью `DATA`, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту с ролью `DATA`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.ssl_enabled.title }}** — выберите, если используется безопасное соединение SSL.

        * {% include [Field CA certificate](../../fields/opensearch/ui/ca-certificate.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.

          Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

          Если не указать подсеть, при активации трансфера может возникнуть [ошибка](../../../../managed-opensearch/qa/index.md#data-transfer-error).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
        * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
          * 
            **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.


            Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

            Если не указать подсеть, при активации трансфера может возникнуть [ошибка](../../../../managed-opensearch/qa/index.md#data-transfer-error).

      {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и БД в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и БД. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
