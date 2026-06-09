# Создание потока данных в {{ yds-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [поток данных](../concepts/glossary.md#stream-concepts).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Нажмите **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Укажите базу данных {{ ydb-full-name }} или [создайте](../../ydb/quickstart.md#create-db) новую. Если вы создали новую БД, после ее создания нажмите ![refresh-button](../../_assets/console-icons/arrow-rotate-right.svg) для обновления списка БД.
  1. Введите имя потока данных. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Выберите [режим тарификации](../pricing.md) (для [бессерверных баз данных](../../ydb/concepts/serverless-and-dedicated.md#serverless)).
  1. Задайте максимальную [пропускную способность сегмента](../concepts/glossary.md#shard-thoughput). Пропускная способность потока данных равняется произведению числа сегментов на пропускную способность каждого из них.
  1. (Опционально) Включите [автопартиционирование](../concepts/glossary.md#autopartitioning) и укажите параметры:

     * **{{ ui-key.yacloud.data-streams.label_shards }}** — минимальное и максимальное количество [сегментов поставки данных](../concepts/glossary.md#shard).
     * **{{ ui-key.yacloud.data-streams.label_auto-partitioning-mode }}**:
     
         * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-scale-up }}` — количество сегментов может быть увеличено до указанного максимального количества.
         * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-paused }}` — количество сегментов будет оставаться на текущем уровне.
     
     * **{{ ui-key.yacloud.data-streams.label_auto-partitioning-stabilization-window }}** — период времени в секундах, по истечении которого будет меняться количество сегментов при изменении нагрузки.
     * **{{ ui-key.yacloud.data-streams.label_auto-partitioning-up-utilization }}** — порог нагрузки в процентах, при котором количество сегментов будет увеличиваться.

     {% note warning %}

     После создания потока данных можно включить автопартиционирование или изменить его параметры, но отключить его нельзя.

     Если текущее количество сегментов у созданного потока будет автоматически увеличено, его нельзя уменьшить.

     {% endnote %}

  1. Укажите количество [сегментов поставки данных](../concepts/glossary.md#shard).

     {% note warning %}

     Количество сегментов у созданного потока нельзя уменьшить.

     {% endnote %}

  1. Выберите режим хранения данных:

     * `{{ ui-key.yacloud.data-streams.label_data-storage-size-limit }}` — укажите максимальный объем хранения данных.
     * `{{ ui-key.yacloud.data-streams.label_data-storage-time-limit }}` — укажите максимальное [время хранения данных](../concepts/glossary.md#retention-time) в потоке.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `CREATING` на `ACTIVE`.

{% endlist %}