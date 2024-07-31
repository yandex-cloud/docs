{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-mysql }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера, например `Bitrix{{ MY }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите `s3-c2-m8`. Данных характеристик хватит для работы системы «1С-Битрикс».
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выберите [тип хранилища](../../managed-mysql/concepts/storage.md) — `network-ssd` и укажите размер `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:
     * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**. В этом руководстве оставьте значение по умолчанию `db1`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**, которое является логином для подключения к БД. В этом руководстве оставьте значение по умолчанию `user1`.
     * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**, будет использоваться для доступа системой «1С-Битрикс» к БД {{ MY }}, например `p@s$woRd!`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:
     * В поле **{{ ui-key.yacloud.mdb.forms.label_network }}** выберите созданную ранее сеть `network-1`.
     * В поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}** выберите группу безопасности `bitrix-sg`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**, при необходимости, поменяйте зону доступности, в которой должна находиться база данных. Для этого нажмите значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с информацией о хосте. В открывшемся окне выберите нужную зону доступности и нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

  1. Для обеспечения отказоустойчивости вы можете добавить дополнительные хосты для вашей БД. Для этого нажмите **{{ ui-key.yacloud.mdb.forms.button_add-host }}** и укажите, в какой зоне доступности он будет размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите на кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Создание кластера БД может занять несколько минут. Проверить доступность созданного кластера вы можете в консоли управления {{ yandex-cloud }}, выбрав сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. На вкладке **{{ ui-key.yacloud.mysql.switch_list }}** статус кластера должен быть `Running`, состояние `Alive`.

{% endlist %}