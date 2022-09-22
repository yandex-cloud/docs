# Настройки датасета

Настройки датасета определяют, каким образом датасет будет работать с данными источника.

{% if audience == "internal" %}

 {{ datalens-short-name }} работает с источником в режиме прямого доступа:

 * {{ datalens-short-name }} не хранит у себя данные. CSV загружаются и хранятся в S3.
 * Все вычисления для отображения превью датасета, графиков и дашбордов выполняются средствами источника данных.

{% endif %}

## Подключение нескольких таблиц {#multi-table}

Если в источнике доступно несколько таблиц, вы можете объединять их с помощью оператора JOIN.
Объединение происходит через создание связи. В связи вы указываете поля исходной таблицы и поля таблицы, с которой происходит объединение.

Доступны следующие операторы JOIN:
* [INNER](https://en.wikipedia.org/wiki/Join_(SQL)#Inner_join)
* [LEFT](https://en.wikipedia.org/wiki/Join_(SQL)#Left_outer_join)
* [RIGHT](https://en.wikipedia.org/wiki/Join_(SQL)#Right_outer_join)
* [FULL](https://en.wikipedia.org/wiki/Join_(SQL)#Full_outer_join)

{% if audience != "internal" %}

## Режимы работы с источником данных {#mode}

Датасет может работать в одном из двух режимов, который зависит от источника данных.

Датасет может работать с источником в следующих режимах:

- [Прямой доступ](#direct). Все запросы к данным {{ datalens-short-name }} выполняет на стороне источника.
- [Материализация](#materialization). {{ datalens-short-name }} предварительно сохраняет данные в свою БД и работает с ними.
  - [Единовременная материализация](#one-time-materialization). Данные загружаются в БД материализации {{ datalens-short-name }} один раз.
  - [Периодическая материализация](#periodic-materialization). Данные загружаются в БД материализации {{ datalens-short-name }} неограниченное количество раз по расписанию.

В таблице приведены режимы работы с источниками данных:

Режим работы<br/>Источник  | Прямой доступ | Единовременная<br/>материализация | Периодическая<br/>материализация
----|----|----|----
File | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/no.svg)
{{ CH }} | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
{{ PG }} | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
{{ MY }} | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
MS SQL Server | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
Oracle Database| ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
Greenplum | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
Google Sheets | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)
{{ ydb-name }} | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg)
Metrica | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg)
AppMetrica | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg)

### Прямой доступ {#direct}

Все запросы к данным исполняются на стороне источника.

### Материализация {#materialization}

Материализация — процесс загрузки данных из источника в базу данных {{ datalens-short-name }}.
Материализация может происходить как единовременно, так и периодически по расписанию.

#### Единовременная материализация {#one-time-materialization}

Данные загружаются в БД материализации единовременно. После этого {{ datalens-short-name }} делает запросы только к материализованным данным.

Чтобы синхронизировать хранилище {{ datalens-short-name }} с источником, данные можно загрузить повторно.

{% note info %}

Если вы используете в качестве источника данных CSV-файл, {{ datalens-short-name }} автоматически материализует датасет.

{% endnote %}

#### Периодическая материализация {#periodic-materialization}

Данные загружаются в БД материализации {{ datalens-short-name }} по расписанию. Расписание задается в настройках датасета.

Например, по четвергам каждую вторую неделю в 03:00.

Минимальный доступный интервал — 1 раз в день.

{% endif %}

## Фильтрация по умолчанию для новых чартов {#default-filters}

В датасете можно [создать](../../operations/dataset/create-filter.md) фильтр по умолчанию. Он будет применен к любому новому чарту, созданному на основе данных из текущего датасета.

{% note info %}

- Фильтр для отдельного чарта задается в настройках чарта.
- Фильтры по умолчанию не применяются к данным в области предпросмотра датасета.

{% endnote %}

Фильтрация по умолчанию для новых чартов позволяет:
* Уменьшить объем данных, запрашиваемых из источника при построении чарта.
* Не добавлять одинаковые фильтры в новые чарты, созданные на основе данных из одного датасета.


## Управление доступом {#access-management}

Вы можете настроить права доступа ко всему датасету. {% if audience != "internal" %} Подробнее в разделе [{#T}](../../operations/dataset/manage-access.md). {% endif %}

Также можно разграничить доступ к данным на уровне строк (_Row-level security_ или _RLS_). Подробнее в разделе [{#T}](../../operations/dataset/manage-row-level-security.md).

## Выполнение SQL-запросов в датасетах {#sql-request-in-datatset}

Источник данных датасета можно определять произвольными SQL-запросами над подключениями к БД. Текст запроса при обращении к источнику данных исполняется в виде подзапроса. Подробнее о том, как использовать SQL-запросы в датасете, читайте в разделе [{#T}](../../operations/dataset/add-data.md).
При использовании SQL-запросов в датасетах рекомендуется:
* Ограничить права пользователя, прописанного в подключении, до `read-only`.
* Пользователям, которые не должны иметь права на выполнение произвольного запроса, назначить право доступа `Исполнение` на подключение и связанные с ним датасеты.

Включить или отключить использование подзапросов в качестве источника можно при [создании подключения](../../operations/index.md#creating-connection) и при его редактировании.

#### См. также {#see-also}
- [{#T}](../../operations/dataset/create.md)
{% if audience != "internal" %}- [{#T}](../../operations/dataset/materialize.md){% endif %}
- [{#T}](../calculations/index.md)
- [{#T}](../calculations/index.md#how-to-create-calculated-field)
