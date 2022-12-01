# Вычисления на кластерах Apache Spark™ в {{ ml-platform-name }}

Сервис {{ dataproc-full-name }} позволяет разворачивать кластеры Apache Spark™. Вы можете использовать кластеры {{ dataproc-name }}, чтобы запускать распределенные обучения на кластерах. {{ ml-platform-name }} поддерживает работу в сессиях, созданных с помощью [Apache Livy](https://livy.apache.org/).

## Варианты развертывания кластеров {#types}

Вы можете развернуть кластер для вычислений в {{ ml-platform-name }} двумя способами:
* создать кластер в {{ ml-platform-name }}, используя специальный ресурс — [шаблон {{ dataproc-name }}](data-proc-template.md);
* самостоятельно создать кластер в [сервисе {{ dataproc-full-name }}](../../data-proc/) и интегрировать его в проект {{ ml-platform-name }}.

Все кластеры {{ dataproc-name }} вне зависимости от варианта развертывания тарифицируются по [правилам сервиса {{ dataproc-full-name }}](../../data-proc/pricing.md). Все кластеры, доступные в проекте, можно посмотреть в разделе **Ресурсы проекта** ⟶ ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}** на странице проекта.

### Шаблоны {{ dataproc-name }} {#template}

В шаблоне {{ dataproc-name }} вы выбираете одну из предопределенных конфигураций кластера. На основе шаблона {{ dataproc-name }}, активированного в проекте, {{ ml-platform-name }} развернет временный кластер, используя необходимые параметры проекта. 

{{ ml-platform-name }} следит за работой временных кластеров. Если в течение двух часов кластер не используется для вычислений, {{ ml-platform-name }} его выключит. Вы можете повторно развернуть кластер в проекте, когда он вам понадобится. Вы также можете делиться шаблонами {{ dataproc-name }} с другими пользователями.

[Подробнее о работе с шаблонами {{ dataproc-name }}](../operations/data-proc-template.md).

### Интеграция с сервисом {{ dataproc-full-name }} {#clusters}

Если вы уже работали с [сервисом {{ dataproc-full-name }}](../../data-proc/), или стандартные конфигурации шаблонов вам не подходят, вы можете развернуть кластер и использовать его для вычислений в {{ ml-platform-name }}. 

{% note warning %}

Используя кластер, развернутый в сервисе {{ dataproc-name }}, вы управляете его жизненным циклом кластера самостоятельно. Даже если вычислений нет больше двух часов, кластер будет работать и тарифицироваться, пока вы его не выключите.

{% endnote %}

Для корректной интеграции с {{ ml-platform-name }} развернутый кластер {{ dataproc-name }} должен иметь [версию образа](../../data-proc/concepts/environment.md) не ниже `1.3` с включенными сервисами `LIVY`, `SPARK`, `YARN` и `HDFS`.

## Настройки проекта {{ ml-platform-name }} для работы с кластерами {{ dataproc-name }} {#settings}

{% include [preferences](../../_includes/datasphere/settings-for-dataproc.md) %}

## Вычислительные сессии {#session}

{% include [dataproc](../../_includes/datasphere/dataproc-sessions.md) %}

### Запуск python-кода в кластере {#run-code}

Код запускается в ячейках с заголовком:

```
#!spark [--cluster <кластер>] [--session <сессия>] [--variables <переменная>]
```

Где:

* `<кластер>` — кластер Data Proc, на котором будут производиться вычисления. Может быть:
  * Именем кластера, созданного через интерфейс ноутбука.
  * HTTP-ссылкой на внутренний IP-адрес хоста `masternode`, например `http://10.0.0.8:8998/`.
* `<сессия>` — идентификатор вычислительной сессии. Если параметр пропущен, используется сессия кластера {{ dataproc-name }} по умолчанию.
* `<переменная>` — переменная, импортированная в ячейку из ядра. Поддерживаемые типы: `bool`, `int`, `float`, `str`, `pandas.DataFrame` (преобразовывается в Spark DataFrame).

### Работа с библиотекой Spark SQL {#sql}

{{ ml-platform-name }} может работать с библиотекой Spark SQL. Например, следующий запрос вернет все записи в таблице `animals`, созданной в кластере `cluster test-dataproc-cluster`:

```python
#!spark --cluster test-dataproc-cluster
df = spark.sql("SELECT * FROM animals;")
df.show()
```

Подробнее о синтаксисе SQL-запросов и работе с библиотекой Spark SQL см. в [официальной документации](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select.html).

#### См. также {#see-also}

* [{#T}](data-proc-template.md).
* [{#T}](../tutorials/data-proc-integration.md).