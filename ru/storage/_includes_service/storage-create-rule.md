Чтобы создать правило:

1. Включите опцию **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. При помощи этой опции вы можете включить или выключить правило, не удаляя его из конфигурации.
1. Заполните поля:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}** — опишите правило в произвольной форме.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}** — часть [ключа](../concepts/object.md#key) объекта необходимой длины, взятая от его начала. По префиксу отбираются объекты, попадающие под действие правила. Если под действие правила должны попадать все объекты, оставьте поле пустым.
   * **{{ ui-key.yacloud_components.labelset.button_add-label }}** — правило срабатывает для всех объектов c указанными [метками](../concepts/tags.md).
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_max-size }}** — правило срабатывает для всех объектов, размер которых меньше или равен указанному.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_min-size }}** — правило срабатывает для всех объектов, размер которых больше или равен указанному.
1. Выберите и настройте нужные типы действий, выполняемые с объектами при срабатывании правила:
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_expiration-type }}` — удаление любых объектов из бакета:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}` — срабатывает через указанное в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** количество дней после загрузки объекта.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}` — срабатывает в дату, указанную в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}**.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}` — удаляет маркер удаления, для которого больше не существует неактуальных версий объекта.

     Для бакетов со включенным [версионированием](../operations/buckets/versioning.md) действие будет применяться для текущих версий объектов. Для взаимодействия с неактивными версиями объектов воспользуйтесь параметром `NoncurrentVersionExpiration`.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_transition-type }}` — перемещение любых объектов из стандартного (`STANDARD`) в холодное (`COLD`) или (`ICE`) ледяное хранилище:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}` — срабатывает через указанное в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** количество дней после загрузки объекта.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}` — срабатывает в дату, указанную в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}**.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}** — тип хранилища, в которое будут перемещены объекты.

     Для бакетов со включенным версионированием действие будет применяться для текущих версий объектов. Для взаимодействия с неактивными версиями объектов воспользуйтесь параметром `NoncurrentVersionTransition`.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-expiration-type }}` — удаление нетекущих версий объектов из бакета. Срабатывает через указанное в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** количество дней после того, как версия объекта стала нетекущей.
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-transition-type }}` — перемещение нетекущих версий объектов из стандартного (`STANDARD`) в холодное (`COLD`)  или (`ICE`) ледяное хранилище:
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** — количество дней, через которое сработает правило после того, как версия объекта стала нетекущей.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}** — тип хранилища, в которое будут перемещены объекты.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_abort-incomplete-multipart-upload-type }}` — удаление всех частей незавершенных составных загрузок из бакета. Срабатывает через указанное в поле **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** количество дней после загрузки объекта.

1. Нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

Вы можете добавить одновременно несколько правил. Чтобы добавить новое правило нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** и повторите шаги инструкции, указанные выше.