  * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}** укажите настройки резервного копирования в случае сбоя копирования:
    * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. Попытки будут прекращены, как только операция будет успешно выполнена или по достижении указанного количества попыток, в зависимости от того, что наступит раньше.
        Не действует, если резервное копирование запущено вручную.
    * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.

  * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-overview.field_error-handling }}** настройте поведение {{ backup-name }} при возникновении ошибок:
    *  **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}** — настройки повторных попыток при ошибках копирования:
        * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток.
        * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.
    * **{{ ui-key.yacloud.backup.policy-form.field_snapshot-reaatempt }}** — настройки повторных попыток при ошибках создания снимка:
        *  **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}** — максимальное количество попыток.
        *  **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}** — длительность интервала между повторениями попыток.

  * (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-overview.field_files-filters }}** вы можете с помощью фильтров исключить из резервных копий определенные файлы и папки или, наоборот, делать резервные копии только конкретных элементов файловой системы:
    * **{{ ui-key.yacloud.backup.policy-overview.field_exclusion-masks }}**.
    * **{{ ui-key.yacloud.backup.policy-overview.field_inclusion-masks }}**.

    Исключающий фильтр имеет преимущество над включающим.

    Чтобы включить или исключить файлы, добавьте критерии, которым они должны соответствовать, например, имена файлов, пути или маски. Поддерживаются подстановочные символы `*` и `?`. Каждый критерий указывается с новой строки. В критериях не учитывается регистр.
