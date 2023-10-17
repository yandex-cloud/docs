# Управление таблицами и директориями

В этом разделе описано, как с помощью облачной консоли управления создать, отредактировать или удалить таблицы и директории.

Для создания таблицы вам понадобится [база данных](../operations/).

## Создать таблицу {#create-table}

Вы можете создать строковую таблицу или [документную таблицу](../concepts/dynamodb-tables.md).

{% list tabs %}

- Строковая таблица

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Выберите базу данных, в которой нужно создать таблицу.
  1. Перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
  1. Выберите **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** в правой части страницы.
  1. Настройте параметры таблицы:
     * **{{ ui-key.yacloud.ydb.table.form.field_name }}** таблицы. Должно быть уникальным в рамках базы данных.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}** — `{{ ui-key.yacloud.ydb.table.form.label_row-table }}`.
  1. Добавьте колонки:
     * **{{ ui-key.yacloud.ydb.table.form.column_name }}** колонки. Должно быть уникальным в рамках таблицы.
     * **{{ ui-key.yacloud.ydb.table.form.column_type }}** данных колонки. Независимо от типа данных, каждая колонка может содержать значение `NULL`.
     * **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**. Укажите, входит ли колонка в состав первичного ключа. По первичному ключу автоматически строятся первичные индексы.
  1. При необходимости настройте [вторичные индексы](https://ydb.tech/ru/docs/concepts/secondary_indexes):
     * **{{ ui-key.yacloud.ydb.table.form.column_name }}** вторичного индекса. Должно быть уникальным в рамках таблицы.
     * **{{ ui-key.yacloud.ydb.table.form.column_index-key }}** — одна или несколько колонок, которые образуют ключ для построения вторичного индекса.
  1. Настройте политику [партиционирования](https://ydb.tech/ru/docs/concepts/datamodel):
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-none }}` — таблица не партиционируется.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-uniform }}` — весь диапазон значений ключевой колонки типа Uint32 или Uint64 (от 0 до максимального значения) разбивается на интервалы одинаковой длины. При использовании такой политики задайте число интервалов в поле **{{ ui-key.yacloud.ydb.table.form.field_uniform-partitions }}**.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-explicit }}` — позволяет явно указать значения ключей, которые будут выступать границами для первоначального разбиения таблицы на партиции. Чтобы добавить очередное граничное значение, нажмите кнопку **{{ ui-key.yacloud.ydb.table.form.button_add-split-point }}**.
  1. Настройте автопартицирование:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}** — если включено, то партиция разделяется на две при достижении определенного размера данных.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}** — если включено, то партиция разделяется на две если в течение некоторого промежутка времени испытывает высокую нагрузку (потребляет много процессорного времени).
  1. Задайте расширенные настройки таблицы:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}** — пороговое значение размера данных, при котором срабатывает автопартицирование по размеру.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}** — количество партиций в таблице, ниже которого не происходит слияние партиций по размеру или нагрузке.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}** — количество партиций в таблице, выше которого не происходит разбиение по размеру или нагрузке.
     * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}** — если включено, использует [Блум-фильтр](https://ru.wikipedia.org/wiki/Фильтр_Блума) для поиска по ключу. В некоторых случаях позволяет ускорить чтение по ключу.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

  Для создания строковых таблиц также можно воспользоваться командой [`CREATE TABLE`](https://ydb.tech/ru/docs/yql/reference/syntax/create_table) языка запросов [YQL](https://ydb.tech/ru/docs/yql/reference/).

- Документная таблица

  {% note info %}

  Документные таблицы доступны только в бессерверном режиме работы {{ ydb-name }}.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Выберите базу данных, в которой нужно создать таблицу.
  1. Выберите **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** в правой части страницы.
  1. Настройте параметры таблицы:
     * **{{ ui-key.yacloud.ydb.table.form.field_name }}** таблицы. Должно быть уникальным в рамках базы данных.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}** — `{{ ui-key.yacloud.ydb.table.form.label_document-table }}`.
  1. Добавьте колонки:
     * **{{ ui-key.yacloud.ydb.table.form.column_name }}** колонки. Должно быть уникальным в рамках таблицы.
     * **{{ ui-key.yacloud.ydb.table.form.column_type }}** данных колонки. Независимо от типа данных, каждая колонка может содержать значение `NULL`.
     * **{{ ui-key.yacloud.ydb.table.form.column_shard }}** — простой первичный ключ, который состоит из одного атрибута. {{ ydb-short-name }} использует значение ключа партицирования в качестве входных данных для внутренней функции хеширования. Результат вычисления хеш-функции определяет партицию, на которой элемент будет храниться.
     * **{{ ui-key.yacloud.ydb.table.form.column_sort }}**. Первичный ключ может быть составным и состоять из ключа партицирования и ключа сортировки. Все элементы с одинаковым ключом партицирования будут храниться вместе, отсортированные по значению ключа сортировки. Если в документной таблице задан ключ партицирования и ключ сортировки, два элемента могут содержать одинаковое значение ключа партицирования, но должны содержать различные значения ключа сортировки.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

{% endlist %}

## Изменить структуру таблицы {#alter-table}

В облачной консоли {{ ydb-short-name }} можно добавлять неключевые колонки в таблицу и изменять настройки автопартицирования таблиц.

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Выберите базу данных, в которой нужно изменить таблицу.
1. Найдите таблицу в списке и выберите ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_edit }}**.
1. Добавьте новые колонки в таблицу и укажите их параметры:
   * **{{ ui-key.yacloud.ydb.table.form.column_name }}** колонки. Должно быть уникальным в рамках таблицы.
   * **{{ ui-key.yacloud.ydb.table.form.column_type }}** данных колонки. Независимо от типа данных, каждая колонка может содержать значение `NULL`.
1. Чтобы удалить неключевые колонки из таблицы, нажмите на значок ![image](../../_assets/cross.svg) в нужной строке. Удалить колонки, которые образуют первичный ключ, невозможно.
1. Настройте автопартицирование:
   * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}** — если включено, то партиция разделяется на две при достижении определенного размера данных.
   * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}** — если включено, то партиция разделяется на две если в течение некоторого промежутка времени испытывает высокую нагрузку (потребляет много процессорного времени).
1. Задайте расширенные настройки таблицы:
   * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}** — пороговое значение размера данных, при котором срабатывает автопартицирование по размеру.
   * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}** — количество партиций в таблице, ниже которого не происходит слияние партиций по размеру или нагрузке.
   * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}** — количество партиций в таблице, выше которого не происходит разбиение по размеру или нагрузке.
   * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}** — если включено, использует [Блум-фильтр](https://ru.wikipedia.org/wiki/Фильтр_Блума) для поиска по ключу. В некоторых случаях позволяет ускорить чтение по ключу.
1. Нажмите кнопку **{{ ui-key.yacloud.ydb.table.edit.button_update }}**.

Для изменения строковых таблиц также предназначена команда [`ALTER TABLE`](https://ydb.tech/ru/docs/yql/reference/syntax/alter_table) языка запросов [YQL](https://ydb.tech/ru/docs/yql/reference/).

## Удалить таблицу {#drop-table}

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Выберите базу данных, в которой нужно удалить таблицу.
1. Найдите таблицу в списке и выберите ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
1. Подтвердите удаление.

Для удаления строковых таблиц также предназначена команда [`DROP TABLE`](https://ydb.tech/ru/docs/yql/reference/syntax/drop_table) языка запросов [YQL](https://ydb.tech/ru/docs/yql/reference/).

## Создать и удалить директории {#directories}

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Выберите базу данных, в которой нужно создать директорию.
1. Выберите **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_directory }}** в правой части страницы.
1. Введите имя директории и нажмите кнопку **{{ ui-key.yacloud.ydb.browse.dialogs.button_create-directory }}**.