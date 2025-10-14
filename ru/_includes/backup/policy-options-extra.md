* (Опционально) Включите опцию **{{ ui-key.yacloud.backup.policy-overview.field_multivolume-snapshot }}** для создания синхронизированных по времени резервных копий данных, расположенных на нескольких томах. Параметр определяет, будут ли создаваться снимки нескольких томов одновременно или последовательно. Выберите приоритетный способ создания снимков:

    * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-disabled }}` — снимки томов будут создаваться под управлением LVM с помощью агента {{ backup-name }}.
    * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-enabled }}` — снимки томов будут создаваться встроенными средствами LVM. Если создать снимок с помощью LVM не удастся, он будет создан с помощью агента {{ backup-name }}.

* (Опционально) В блоке **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands }}** задайте действия, которые {{ backup-name }} будет выполнять перед началом резервного копирования и после его завершения. Для этого включите опцию **{{ ui-key.yacloud.backup.policy-form.field_pre-command-enabled }}** и/или **{{ ui-key.yacloud.backup.policy-form.field_post-command-enabled }}** и задайте настройки:

    * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-cmd }}** — команда или путь к исполняемому файлу, которые требуется выполнить (запустить). Например: `/usr/bin/myapp`.
    * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-workdir }}** — рабочая директория выполнения команды (запуска файла). Например: `/etc/myapp/`.
    * **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-args }}** — параметры командной строки, которые будут применяться при выполнении команды (запуске файла). Например: `-d -rw`.
    * Включите опцию **{{ ui-key.yacloud.backup.policy-form.field_pre-post-commands-stop-on-error }}**, чтобы создание резервной копии останавливалось при возникновении ошибки выполнения команды (запуска файла).

    {% note info %}

    В каждую политику можно добавить не более одной команды, выполняемой до резервного копирования, и не более одной — выполняемой после.

    {% endnote %}

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