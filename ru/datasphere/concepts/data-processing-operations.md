# Вычисления на кластерах Apache Spark™

Для работы с кластерами {{ dataproc-name }} требуется предварительная настройка проекта, см. подробнее в [концепции](data-processing.md#settings).

Все кластеры {{ dataproc-name }} вне зависимости от варианта развертывания тарифицируются по [правилам сервиса {{ dataproc-full-name }}](../../data-proc/pricing.md). Все кластеры, доступные в проекте, можно посмотреть в разделе **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ ![image](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** на странице проекта.

{% note warning %}

Используя кластер, развернутый в сервисе {{ dataproc-name }}, вы управляете его жизненным циклом самостоятельно. Даже если на нем нет вычислений, кластер не будет удален и продолжит тарифицироваться.

{% endnote %}

{{ ml-platform-name }} поддерживает работу с кластерами {{ dataproc-name }} при помощи:

 * [коннектора Spark](#spark-with-existing-cluster);
 * [Livy-сессии](#livy-sessions).

## Коннекторы Spark {#spark-with-existing-cluster}

[Коннектор Spark](spark-connector.md) — это специальный ресурс, который хранит настройки подключения к кластерам {{ dataproc-name }}. Настройки подключения к кластеру задаются при [создании коннектора Spark](../operations/data/spark-connectors.md#create). Выбранные кластеры подключаются или создаются при запуске вычислений в ячейке.

Коннектор Spark может быть [опубликован](../operations/data/spark-connectors.md#create) в сообществе для использования в других проектах. Изменение настроек коннектора Spark применится для всех проектов, в которых он используется.

Для корректной интеграции с {{ ml-platform-name }} через коннектор Spark развернутый кластер {{ dataproc-name }} должен иметь [версию образа](../../data-proc/concepts/environment.md) не ниже `2.0` с включенными сервисами `LIVY`, `SPARK` и `YARN`.

Подробнее о работе с коннекторами Spark см. в [инструкции](../operations/data/spark-connectors.md).

### Запуск Python-кода в кластере {#run-code-with-spark-connector}

{% include [run-python-code](../../_includes/datasphere/run-code-with-spark-connector.md) %}

### Синхронизация окружения Python с кластером {#synchronization}

При работе с Python Spark через {{ ml-platform-name }} нет необходимости вручную переносить виртуальное окружение. В кластере {{ dataproc-name }} есть возможность изменить базовый состав PyPI пакетов с помощью виртуального окружения:

1. Установите библиотеку `catboost`:

   ```python
   %pip install catboost
   ```

1. После завершения установки на верхней панели выберите **Kernel** ⟶ **Restart kernel...**. Если установка прошла без [ошибок](../troubleshooting/troubles-with-spark.md), виртуальное окружение будет автоматически создано и доступно в Spark-сессии c помощью переменной `spark`.

Для синхронизации окружения в настройках коннектора Spark в блоке **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** должны быть указаны идентификатор [статического ключа](../../iam/concepts/authorization/access-key.md) доступа для бакета и [секрет](secrets.md), содержащий сам статический ключ доступа.

{% note warning %}

Синхронизация окружения Python работает в тестовом режиме. Чтобы разрешить синхронизацию окружения, в настройках коннектора Spark в блоке **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}** укажите параметр `.options` = `venv`.

{% endnote %}

## Livy-сессии {#livy-sessions}

Для корректной интеграции с {{ ml-platform-name }} через Livy-сессии развернутый кластер {{ dataproc-name }} должен иметь [версию образа](../../data-proc/concepts/environment.md) не ниже `2.0` с включенными сервисами `LIVY`, `SPARK`, `YARN` и `HDFS`.

{% include [dataproc-s3-connector](../../_includes/datasphere/data-processing-s3-connector.md) %}

### Вычислительные сессии {#session}

{% include [dataproc](../../_includes/datasphere/data-processing-sessions.md) %}

### Ограничения сессий {{ dataproc-name }} {#restrictions}

{% include [cluster variables](../../_includes/datasphere/data-processing-session-vars.md) %}

### Запуск Python-кода в кластере {#run-code}

Код запускается в ячейках с заголовком:

```text
#!spark [--cluster <кластер>] [--session <сессия>] [--variables <входящая_переменная>] [--return_variables <возвращаемая_переменная>]
```

Где:

* `--cluster` — кластер {{ dataproc-name }}, на котором будут производиться вычисления. Может быть:
  * Именем кластера, созданного через интерфейс ноутбука.
  * HTTP-ссылкой на внутренний IP-адрес хоста `masternode`, например `http://10.0.0.8:8998/`.
* `--session` — идентификатор вычислительной сессии. Если параметр пропущен, используется сессия кластера {{ dataproc-name }} по умолчанию.
* `--variables` — переменная, импортированная из {{ ml-platform-name }} в кластер {{ dataproc-name }}. Поддерживаемые типы: `bool`, `int`, `float`, `str`, `pandas.DataFrame` (преобразовывается в Spark DataFrame в кластере).
* `--return_variables` — переменная, которая будет экспортирована из кластера {{ dataproc-name }} в {{ ml-platform-name }}. Поддерживаемые типы: `bool`, `int`, `float`, `str`, `pandas.DataFrame` (преобразованный Spark DataFrame).

### Пример использования вычислительных сессий с пользовательскими параметрами {#example-custom-sessions}

Чтобы запустить вычисления в сессии с заданными настройками, сначала создайте сессию, а затем передайте код в ячейке с заголовком `#!spark`:

1. Создайте сессию и определите ее параметры:

   ```python
   %create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
   ```

1. В следующей ячейке запустите вычисления:

   ```python
   #!spark --cluster my-new-cluster --session ses1
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000

   count = sc.parallelize(range(0, NUM_SAMPLES)) \
       .filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
   ```

1. Если сессия вам больше не нужна, удалите ее:

   ```python
   %delete_livy_session --cluster my-new-cluster --id ses1
   ```

### Работа с библиотекой Spark SQL {#sql}

{{ ml-platform-name }} может работать с библиотекой Spark SQL. Например, следующий запрос вернет все записи в таблице `animals`, созданной в кластере `cluster test-dataproc-cluster`:

```python
#!spark --cluster test-dataproc-cluster --return_variables df
df = spark.sql("SELECT * FROM animals;")
```

```python
df
```

Подробнее о синтаксисе SQL-запросов и работе с библиотекой Spark SQL см. в [официальной документации](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select.html).

## См. также {#see-also}

* [{#T}](../tutorials/data-processing-integration.md)
* [{#T}](spark-connector.md)
