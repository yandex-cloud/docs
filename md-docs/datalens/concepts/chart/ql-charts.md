[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > [Чарты](index.md) > QL-чарты > Обзор

# QL-чарты в Yandex DataLens. Обзор


_QL-чарты_ — чарты, созданные на основе подключения, если источник подключения — БД, Prometheus или Monitoring. Для построения таких чартов используется прямой запрос в источник. В зависимости от типа чарта запрос выполняется на SQL-диалекте исходной БД, языке запросов Prometheus или Monitoring, что позволяет расширить возможности визуализации с помощью специфических операций.


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

    {% cut "Пример запроса для БД ClickHouse®" %}
    
    ```sql
    SELECT Category, Month, ROUND(SUM(Sales))
    FROM samples.SampleLite
    WHERE Category in {{category}} -- переменная, используемая в селекторе
    GROUP BY Category, Month -- группировка по категории и месяцу
    ORDER BY Category, Month -- сортировка по категории и месяцу
    ```
    
    {% endcut %}


* **Prometheus**. Позволяют построить график по данным Prometheus. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% cut "Пример запроса для Prometheus" %}
  
  ```sql
  sum by (name) (rate(container_cpu_user_seconds_total{container_label_org_label_schema_group="monitoring"}[1m]) * 100  / scalar(count(node_cpu_seconds_total{mode="user"})))
  ```
  
  {% endcut %}

* **Monitoring**. Позволяют построить график по данным Yandex Monitoring. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% cut "Пример запроса для Monitoring" %}
  
  ```json
  {project="monitoring", sensor="nodejs.heap_space.size.bytes"}
  ```
  
  {% endcut %}

{% note warning %}

Управление правами для QL-чартов по данным Monitoring и Prometheus выполняется не только на стороне DataLens, но и в самих сервисах Monitoring и Prometheus.

Для просмотра графика в DataLens пользователю необходимы права на чарт и подключение, а также на чтение данных из конкретного Prometheus API или проекта в Monitoring.

{% endnote %}



Чтобы создать QL-чарт, перейдите к [инструкции](../../operations/chart/create-sql-chart.md).


## Примеры использования {#examples}

* [Примеры создания QL-чартов](../../tutorials/data-from-ch-to-sql-chart.md)


#### Полезные ссылки {#see-also}

* [Создание QL-чарта в Yandex DataLens](../../operations/chart/create-sql-chart.md)
* [Чарт в Yandex DataLens](index.md)
* [Создание чарта в Yandex DataLens](../../operations/chart/create-chart.md)

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._