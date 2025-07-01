
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную:

      * {% include [Field Primary IP FQDN](../../fields/greenplum/ui/primary-host.md) %}
      * {% include [Field Primary port](../../fields/greenplum/ui/primary-port.md) %}
      * {% include [Field Mirror IP FQDN](../../fields/greenplum/ui/mirror-host.md) %}
      * {% include [Field Mirror port](../../fields/greenplum/ui/mirror-port.md) %}
      * {% include [Field Segments](../../fields/greenplum/ui/segments.md) %}
      * {% include [Field CA certificate](../../fields/greenplum/ui/ca-certificate.md) %}
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.

        Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

      * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
      * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
        *  **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.

            Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}        

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и БД в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и БД. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
  