{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать поток данных.
    1. Выберите сервис **{{ yds-full-name }}**.
    1. Нажмите кнопку **Создать поток**.
    1. Укажите [бессерверную]{% if audience == "external" %}(../../ydb/concepts/serverless-and-dedicated.md#serverless){% else %}(https://cloud.yandex.ru/docs/ydb/concepts/serverless-and-dedicated#serverless){% endif %} базу данных {{ ydb-short-name }} или [создайте]{% if audience == "external" %}(../../ydb/quickstart.md#create-db){% else %}(https://cloud.yandex.ru/docs/ydb/quickstart#create-db){% endif %} новую. Если вы создали новую базу данных, после ее создания нажмите кнопку **Обновить** для обновления списка баз.
    1. Введите имя потока данных. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите количество [сегментов поставки данных](../../data-streams/concepts/glossary.md#shard).

        {% note warning %}

        Количество сегментов у созданного потока нельзя уменьшить.

        {% endnote %}

    1. Задайте максимальную [пропускную способность сегмента](../../data-streams/concepts/glossary.md#shard-thoughput). Пропускная способность потока данных равняется произведению числа сегментов на пропускную способность каждого из них.
    1. Укажите максимальное [время хранения данных](../../data-streams/concepts/glossary.md#retention-time) в потоке.
    1. Нажмите кнопку **Создать**.

    Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `CREATING` на `ACTIVE`.

{% endlist %}