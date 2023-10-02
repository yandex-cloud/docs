{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Укажите базу данных {{ ydb-full-name }} или [создайте](../../ydb/quickstart.md#create-db) новую. Если вы создали новую БД, после ее создания нажмите кнопку ![refresh-button](../../_assets/data-streams/refresh-button.svg) для обновления списка БД.
  1. Введите имя потока данных. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Укажите количество [сегментов поставки данных](../../data-streams/concepts/glossary.md#shard).

     {% note warning %}

     Количество сегментов у созданного потока нельзя уменьшить.

     {% endnote %}

  1. Задайте максимальную [пропускную способность сегмента](../../data-streams/concepts/glossary.md#shard-thoughput). Пропускная способность потока данных равняется произведению числа сегментов на пропускную способность каждого из них.
  1. Выберите [режим тарификации](../../data-streams/pricing.md) (для [бессерверных баз данных](../../ydb/concepts/serverless-and-dedicated.md#serverless)).
  1. Выберите режим хранения данных:
     * `{{ ui-key.yacloud.data-streams.label_data-storage-size-limit }}` — укажите максимальный объем хранения данных.
     * `{{ ui-key.yacloud.data-streams.label_data-storage-time-limit }}` — укажите максимальное [время хранения данных](../../data-streams/concepts/glossary.md#retention-time) в потоке.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `CREATING` на `ACTIVE`.

{% endlist %}
