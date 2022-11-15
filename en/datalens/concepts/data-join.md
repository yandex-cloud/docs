---
title: "Joining {{ datalens-full-name }} data"
description: "When creating a dashboard in {{ datalens-full-name }}, a link is often used that determines how a selector affects one or more charts and other selectors. You can use links to filter the values of selectors and charts. This article describes how to join data from different datasets to set up links between widgets."
---

# Combining {{ datalens-full-name }} data

{{ datalens-full-name }} uses a [connection](connection.md) to retrieve data from a source (DB, CSV, Yandex Metrica, and so on). You can create datasets, charts, and selectors from the connection's data. If the source has multiple tables, you can join them to build the required set of data. You can link data from different datasets at the chart level or through selector links.

## Methods of combining data {#data-join}

You can use different methods to combine data:

* [{#T}](#dataset-join)

   * [{#T}](#ui-join)
   * [{#T}](#sql-join)

* [{#T}](#chart-join)

   * [{#T}](#sql-chart)
   * [{#T}](#datasets-chart)

* [{#T}](#selector-join)

### At the dataset level {#dataset-join}

To join data at the dataset level, you can [add tables](#ui-join) to the workspace or write an [SQL query](#sql-join).


{% note warning %}

You can't join data from different sources at the level of a single dataset.

{% endnote %}

#### Adding tables {#ui-join}

You can combine data through the dataset creation interface by dragging tables to the workspace and configuring links between them via the [JOIN operator](dataset/data-model.md#source). {% if product == "yandex-cloud" %}{% if audience != "internal" %} For an example of combining data by adding tables, see the [use case](../../tutorials/datalens/data-from-ch-visualization.md#step2).  {% endif %}{% endif %}

#### SQL query {#sql-join}

In a dataset, you can add an [ad-hoc SQL query](dataset/settings.md#sql-request-in-datatset) to the data source. When a data source is accessed, the query code is run as a subquery. You can use the output of the query as final dataset data or combine it with other source tables via the interface.

### At the chart level {#chart-join}

{{ datalens-short-name }} enables you to combine data at the chart level. To combine data at the chart level, you can use an [SQL chart](#sql-chart) or [multi-dataset charts](#datasets-chart).

#### QL chart {#sql-chart}

[QL charts](chart/index.md#sql-charts) are charts created from a connection if there is a database at the other end of the connection. Running a SQL query does not create a separate Dataset object. One is generated on the fly and displayed in the preview panel. For more information, see the instructions [{#T}](../operations/chart/create-sql-chart.md).

#### Multi-dataset charts {#datasets-chart}

[Multi-dataset charts](chart/index.md#multi-dataset-charts) are charts that visualize data from different datasets. Queries for each dataset are processed independently of each other. For more information, see the instructions [{#T}](../operations/chart/create-multidataset-chart.md).

### At the selector link level {#selector-join}

You can add a selector to a dashboard to modify query output in its associated widgets:
* On the dashboard, selectors and charts built from a single dataset link automatically.
* Selectors and charts built from different datasets can be linked manually using aliases.

Before creating a link, make sure that the field used by the selector as a filter is included in the dataset the chart is built from. Otherwise, the link will not work. For more information, see the instructions [{#T}](../operations/dashboard/create-alias.md).

{% if product == "yandex-cloud" %}

## Optimizing data when joining tables {#join-optimization}

In some charts based on a dataset with [joined tables](#ui-join), you can only use fields from a single table. In this case, {{ datalens-short-name }} optimizes a query to a source. No `JOIN` is used, and the query only returns data from one table without filtering data based on others. This allows reducing the amount of requested data and the query execution time. However, data returned by an optimized query may differ from that you expect.

Optimization is used under the following conditions:

* A chart only uses fields of one of the joined tables.
* There are no fields from the other tables in any of the chart sections.
* Fields from the other tables are not used in the chart's calculated fields.

{% note info %}

Optimization won't work if a dataset is described using an [SQL query to the source](../operations/dataset/add-data.md).

{% endnote %}

Let's look at examples of query optimization using different datasets for a source with tables: 

{% cut "Employees" %}

| id | name | department_id |
|----|----------|---------------|
| 1 | Ivanov | 2 |
| 2 | Petrov | 4 |
| 3 | Sidorov | 1 |
| 4 | Stepanov | 1 |
| 5 | Sokolov |               |
| 6 | Orlova | 3 |
| 7 | Shishkina | 3 |
| 8 | Semyonov |               |
| 9 | Antonova | 3 |
| 10 | Sergeev | 4 |

{% endcut %}

{% cut "Departments" %}

| id | name |
|----|-------------|
| 1 | Logistics |
| 2 | IT |
| 3 | Accounting |
| 4 | Security |

{% endcut %}

{% cut "Bonuses" %}

| employee_id | bonus |
|-------------|--------|
| 1 | 35,000 |
| 2 | 40000 |
| 5 | 28,000 |
| 7 | 30000 |
| 9 | 50,000 |

{% endcut %}

{% cut "Qualification" %}

| employee_id | category |
|-------------|-------------|
| 2 | Category 1 |
| 4 | Category 1 |
| 5 | Category 2 |
| 6 | Category 3 |
| 7 | Category 3 |
| 8 | Category 2 |
| 10 | Category 1 |

{% endcut %}

### Examples {#examples}

{% cut "INNER JOIN of two tables" %}

A dataset is based on the `Employees` and `Departments` tables joined with an [INNER JOIN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Join_(SQL)#INNER_JOIN){% else %}(https://en.wikipedia.org/wiki/Join_(SQL)#Inner_join){% endif %}.

![image](../../_assets/datalens/concepts/joins/case-1-link.png)

As a result of the Join, the dataset only contains rows that are common for the two tables. Let's create a chart containing fields from the two tables.

![image](../../_assets/datalens/concepts/joins/case-1-chart.png)

Now let's create a chart that will only contain fields from the `Employees` table. In this case, {{ datalens-short-name }} doesn't use a `JOIN` and only works with this table. The chart displays all values from the `Employees` table and not only those that overlap with the `Departments` table.

![image](../../_assets/datalens/concepts/joins/case-1-chart-opt.png)

{% endcut %}

{% cut "LEFT/RIGHT JOIN of two tables" %}

A dataset is based on the `Bonuses` and `Employees` tables joined with a [LEFT JOIN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Join_(SQL)#LEFT_OUTER_JOIN){% else %}(https://en.wikipedia.org/wiki/Join_(SQL)#Left_outer_join){% endif %}. The `Bonuses` table is used in full, while only those values which are present in the `Bonuses` table are selected from the `Employees` table.

![image](../../_assets/datalens/concepts/joins/case-2-link.png)

Let's create a chart containing fields from the two tables.

![image](../../_assets/datalens/concepts/joins/case-2-chart.png)

Next, let's only leave the `Employees` table fields in the chart. In this case, the chart will include all values from this table (without filtering data by the `Bonuses` table).

![image](../../_assets/datalens/concepts/joins/case-2-chart-opt.png)

Optimization for a [RIGHT JOIN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Join_(SQL)#RIGHT_OUTER_JOIN){% else %}(https://en.wikipedia.org/wiki/Join_(SQL)#Right_outer_join){% endif %} works the same way.

{% endcut %}

{% cut "INNER JOIN of three tables" %}

A dataset is based on three tables:

* The first table (`Departments`) is joined with the second table (`Employees`) using an `INNER JOIN`.
* The second table (`Employees`) is joined with the third table (`Bonuses`) using an `INNER JOIN`.

![image](../../_assets/datalens/concepts/joins/case-3-link.png)

Let's create a chart containing fields from all the tables.

![image](../../_assets/datalens/concepts/joins/case-3-chart-1.png)

Next, let's only leave the `Employees` table fields in the chart. In this case, the chart will include all values from this table (without filtering data by the `Bonuses` and `Departments` tables).

![image](../../_assets/datalens/concepts/joins/case-3-chart-opt.png)

Let's only add fields from the first (`Departments`) and third (`Bonuses`) tables to the chart. These tables are not linked explicitly. However, each of them is linked to the `Employees` table. Therefore, {{ datalens-short-name }} doesn't optimize a query to the source. In this case, the chart will include values from all the three tables based on filtering results.

![image](../../_assets/datalens/concepts/joins/case-3-chart-2.png)

{% endcut %}

{% cut "INNER JOIN of one table with the other two" %}

A dataset is based on three tables:

* The first table (`Employees`) is joined with the second table (`Departments`) using an `INNER JOIN`.
* The first table (`Employees`) is joined with the third table (`Bonuses`) using an `INNER JOIN`.

![image](../../_assets/datalens/concepts/joins/case-4-link.png)

Let's create a chart containing fields from all the tables.

![image](../../_assets/datalens/concepts/joins/case-4-chart.png)

Next, let's only leave the `Employees` table fields in the chart. In this case, the chart will include all values from this table (without filtering data by the `Departments` and `Bonuses` tables).

![image](../../_assets/datalens/concepts/joins/case-4-chart-opt-1.png)

Let's only add fields from the first (`Employees`) and third (`Bonuses`) tables to the chart. In this case, the chart will include values that are common for these tables (without filtering data by the `Departments` table).

![image](../../_assets/datalens/concepts/joins/case-4-chart-opt-2.png)

{% endcut %}

{% cut "INNER JOIN of four tables" %}

A dataset is based on four tables:

* The first table (`Qualification`) is joined with the second table (`Bonuses`) using an `INNER JOIN`.
* The first table (`Qualification`) is joined with the third table (`Employees`) using an `INNER JOIN`.
* The third table (`Employees`) is joined with the fourth table (`Departments`) using an `INNER JOIN`.

![image](../../_assets/datalens/concepts/joins/case-5-link.png)

Let's create a chart containing fields from all the tables.

![image](../../_assets/datalens/concepts/joins/case-5-chart.png)

Next, let's only leave the `Qualification` table fields in the chart. In this case, the chart will include all values from this table (without filtering data by the other tables).

![image](../../_assets/datalens/concepts/joins/case-5-chart-opt-1.png)

If we only use a pair of joined tables (the first and the second, the first and the third, and the third and the fourth) in the chart, it will show common values from these tables (without filtering data by the other tables). For example, let's only add fields from the first (`Qualification`) and second (`Bonuses`) tables to the chart.

![image](../../_assets/datalens/concepts/joins/case-5-chart-opt-2.png)

{% endcut %}

{% endif %}
