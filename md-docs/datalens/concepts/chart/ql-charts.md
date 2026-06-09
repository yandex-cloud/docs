# QL-чарты в {{ datalens-full-name }}. Обзор


_QL-чарты_ — чарты, созданные на основе подключения, если источник подключения — БД, {{ prometheus-name }} или {{ monitoring-short-name }}. Для построения таких чартов используется прямой запрос в источник. В зависимости от типа чарта запрос выполняется на SQL-диалекте исходной БД, языке запросов {{ prometheus-name }} или {{ monitoring-short-name }}, что позволяет расширить возможности визуализации с помощью специфических операций.


При выполнении запроса отдельный объект [Датасет](../../dataset/index.md) не создается — чарт генерируется сразу и отображается на панели превью.

В отличие от [чартов на основе датасета](dataset-based-charts.md), в QL-чартах логика использования области визуализации смещена в сторону запроса в источник, то есть область визуализации только отображает данные из запроса. Также QL-чарты можно сохранять и [добавлять на дашборды](../../operations/dashboard/add-chart.md) в виде виджетов.



{% note alert %}

Если выдать пользователю [доступ для просмотра](../../security/manage-access.md#permission-read) вашего QL-чарта, он сможет выполнить любые запросы к любым данным источника этого QL-чарта.

При использовании QL-чартов настройте ограничения доступа на стороне источника данных.

Если необходимо [ограничить доступ на уровне строк данных (RLS)](../../security/row-level-security.md), используйте [чарты на основе датасета](dataset-based-charts.md).

{% endnote %}

Поддерживаются следующие типы QL-чартов:

* **SQL**. Позволяют построить визуализацию, для которой можно гибко управлять набором данных с помощью параметров SQL-запроса в БД источника.

  Особенности чартов типа SQL:

  * уменьшают нагрузку на БД благодаря прямым запросам;
  * подходят только для запросов `SELECT`;
  * позволяют применять операторы `JOIN`, `GROUP BY`, `SORT BY` и функции агрегации в SQL-запросе;
  * предоставляют возможность параметризации любой части SQL-запроса;
  * поддерживают ограниченный набор [типов визуализаций](../../visualization-ref/index.md);
  * не используют [RLS](../../security/row-level-security.md) и [вычисляемые поля](../calculations/index.md).

    {% cut "Пример запроса для БД {{ CH }}" %}
    
    ```sql
    SELECT Category, Month, ROUND(SUM(Sales))
    FROM samples.SampleLite
    WHERE Category in not_var{{category}} -- переменная, используемая в селекторе
    GROUP BY Category, Month -- группировка по категории и месяцу
    ORDER BY Category, Month -- сортировка по категории и месяцу
    ```
    
    {% endcut %}


* **{{ prometheus-name }}**. Позволяют построить график по данным {{ prometheus-name }}. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% cut "Пример запроса для {{ prometheus-name }}" %}
  
  ```sql
  sum by (name) (rate(container_cpu_user_seconds_total{container_label_org_label_schema_group="monitoring"}[1m]) * 100  / scalar(count(node_cpu_seconds_total{mode="user"})))
  ```
  
  {% endcut %}

* **{{ monitoring-short-name }}**. Позволяют построить график по данным {{ monitoring-full-name }}. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% cut "Пример запроса для {{ monitoring-short-name }}" %}
  
  ```json
  {project="monitoring", sensor="nodejs.heap_space.size.bytes"}
  ```
  
  {% endcut %}

{% note warning %}

Управление правами для QL-чартов по данным {{ monitoring-short-name }} и {{ prometheus-name }} выполняется не только на стороне DataLens, но и в самих сервисах {{ monitoring-short-name }} и {{ prometheus-name }}.

Для просмотра графика в {{ datalens-short-name }} пользователю необходимы права на чарт и подключение, а также на чтение данных из конкретного {{ prometheus-name }} API или проекта в {{ monitoring-short-name }}.

{% endnote %}



Чтобы создать QL-чарт, перейдите к [инструкции](../../operations/chart/create-sql-chart.md).


## Примеры использования {#examples}

* [{#T}](../../tutorials/data-from-ch-to-sql-chart.md)


#### См. также {#see-also}

* [{#T}](../../operations/chart/create-sql-chart.md)
* [{#T}](index.md)
* [{#T}](../../operations/chart/create-chart.md)

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._