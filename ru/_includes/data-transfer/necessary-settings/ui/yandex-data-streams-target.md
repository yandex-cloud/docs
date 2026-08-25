* Выберите тип подключения **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.on_premise_connection.title }}** или **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.managed_connection.title }}**.
  
  Для настройки подключения вручную укажите:

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name-onprem.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока, ассоциированного с базой данных.

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ydb-endpoint-settings.md) %}

    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ca-sertificate.md) %}
    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/subnet-id.md) %}
  
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}

  
  Для настройки подключения к {{ ydb-full-name }}:

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}
  
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока, ассоциированного с базой данных.

    
    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

    * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}
