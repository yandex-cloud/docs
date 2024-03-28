* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}** — укажите IP-адрес или FQDN хоста-мастера. Если хосты находятся на разных портах, то вы можете задать несколько значений хостов в формате `хост:порт`. Если вы выбираете такой формат, то значение поля **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** не будет учитываться. 

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.

* {% include [Field CA certificate](../../fields/postgresql/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).


  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — укажите имя базы данных в выбранном кластере.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
