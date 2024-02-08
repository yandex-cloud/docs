* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-full-name }}, зарегистрированную в [{{ yds-full-name }}](../../../../data-streams/) в качестве приемника.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока, ассоциированного с базой данных.

* {% include [Field Service Account](../../fields/yds/ui/service-account-target.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).
