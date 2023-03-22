Чтобы создать правило:

1. Включите опцию **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. При помощи этой опции вы можете включить или выключить правило, не удаляя его из конфигурации.
1. Заполните поля:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}** — опишите правило в произвольной форме.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}** — часть ключа объекта необходимой длины, взятая от его начала. По префиксу отбираются объекты, попадающие под действие правила. Если под действие правила должны попадать все объекты, то отметьте **{{ ui-key.yacloud.storage.bucket.lifecycle.field_no-prefix }}**.
1. Выберите тип объектов и действие, выполняемое с ними при срабатывании правила:
   * `Expiration` — удаление любых объектов из бакета;
   * `Transition` — перемещение любых объектов из стандартного (`STANDARD`) в холодное (`COLD`), из холодного в ледяное (`ICE`) или из стандартного в ледяное хранилище;
   * `NoncurrentVersionExpiration` — удаление нетекущих версий объектов из бакета;
   * `NoncurrentVersionTransition` — перемещение нетекущих версий объектов из стандартного (`STANDARD`) в холодное (`COLD`) хранилище;
   * `AbortIncompleteMultipartUpload` — удаление всех частей незавершенных составных загрузок из бакета.
1. Выберите условие срабатывания правила. В зависимости от типа можно выбрать:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-days }}** — правило срабатывает через указанное количество дней.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-date }}** — в указанную дату.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}** — после того, как у объекта осталась только одна текущая версия. Активен только для типа `Expiration`.
1. Выберите срок срабатывания правила:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** — количество дней после загрузки объекта, через которое должно сработать правило. Минимальное значение — 1.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** — дата, в которую должно сработать правило.
1. Нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

Вы можете добавить несколько правил за один раз. Чтобы добавить новое правило нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** и повторите шаги инструкции, указанные выше.