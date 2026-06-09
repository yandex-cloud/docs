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

1. Введите в ячейку Python-код, например:

   ```python
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000_0

   count = sc.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPL))
   ```
1. Выберите ячейку с кодом и запустите вычисления.
1. В открывшемся окне **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** перейдите на вкладку **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}**.
1. Выберите конфигурацию вычислительных ресурсов и коннектор Spark.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.select }}**.

Коннектор и конфигурация окружения задаются вручную только при первом запуске вычисления. Все последующие вычисления в этом ноутбуке будут производиться на созданной при первом запуске ВМ. Кластер {{ dataproc-name }} подключается к ней при помощи коннектора Spark.

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

{% note info %}

Чтобы получить из кластера {{ dataproc-name }} данные больше 100 МБ, используйте [коннектор S3](../operations/data/s3-connectors.md).

{% endnote %}

### Вычислительные сессии {#session}

В кластере {{ dataproc-name }} ваш код выполняется в [сессиях](https://livy.incubator.apache.org/docs/latest/rest-api.html#session). Сессия хранит промежуточное состояние до тех пор, пока вы не удалите ее или кластер. У каждого кластера есть сессия по умолчанию. Ее идентификатор равен идентификатору проекта.

Для управления сессиями используйте следующие команды:
* `%create_livy_session --cluster <имя_кластера> --id <идентификатор_сессии>` — создание сессии;
* `%delete_livy_session --cluster <имя_кластера> --id <идентификатор_сессии>` — удаление сессии.

Например, следующая команда создаст в кластере `my-new-cluster` сессию `ses1`, которая позволит каждому процессу использовать максимум 4 ядра CPU в кластере и 4 ГБ RAM (подробнее см. в [документации Spark](https://spark.apache.org/docs/latest/configuration.html)):

```python
%create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
```

По умолчанию в сессиях включено динамическое выделение ресурсов. Чтобы ограничить ресурсы сессии, используйте параметр `--conf spark.dynamicAllocation.enabled=false`.

### Параметры Livy-сессии {#parameters}

Полный список параметров для команды `%create_livy_session`:

| Параметр                     | Тип      | Описание                                   |
|------------------------------|----------|--------------------------------------------|
| `--cluster`                  | `string` | Идентификатор или имя кластера {{ dataproc-name }} |
| `--id`                       | `string` | Идентификатор сессии, произвольная строка. Если не указан, то формируется автоматически |
| `--conf`                     | `string` | Свойства конфигурации Spark                |
| `--proxyUser`                | `string` | Логин пользователя операционной системы кластера {{ dataproc-name }}, от имени которого будет выполняться задание. По умолчанию `spark` |
| `--jars`                     | `string` | Библиотеки Java для использования в сессии |
| `--files`                    | `string` | Файлы для использования в сессии           |
| `--pyFiles`                  | `string` | Python-файлы для использования в сессии    |
| `--driverMemory`             | `string` | Объем памяти драйвера                      |
| `--driverCores`              | `int`    | Количество ядер для драйвера               |
| `--executorMemory`           | `string` | Объем памяти процесса-исполнителя          |
| `--executorCores`            | `int`    | Количество ядер для процесса-процесса      |
| `--numExecutors`             | `int`    | Количество процессов-исполнителей          |
| `--archives`                 | `string` | Архивы для использования в сессии          |
| `--queue`                    | `string` | Название очереди YARN                      |
| `--variables`                | `string` | Переменные для использования в сессии      |
| `--return_variables`         | `string` | Переменные, которые передадутся из сессии  |
| `--heartbeatTimeoutInSecond` | `int`    | Время бездействия до завершения сеанса     |
| `--ttl`                      | `string` | Время ожидания неактивного сеанса          |

Подробнее о параметрах livy-сессии см. в [официальной документации](https://livy.incubator.apache.org/docs/latest/rest-api.html).

### Ограничения сессий {{ dataproc-name }} {#restrictions}

{{ ml-platform-name }} использует системные переменные для работы с кластером {{ dataproc-name }}. Не переопределяйте значения следующих переменных:
* `sc`
* `spark`
* `HiveContext`
* `StreamingContext`
* `SqlContext`

Следующие глобальные конфигурации Spark переопределяются параметрами, необходимыми для выполнения заданий Livy:
* `spark.jars`
* `spark.submit.deployMode`
* `spark.yarn.dist.archives`
* `spark.submit.pyFiles`
* `spark.yarn.maxAppAttempts`
* `spark.yarn.submit.waitAppCompletion`

Чтобы задать дополнительные библиотеки для сессии Spark, используйте параметры `spark.driver.extraClassPath` и `spark.executor.extraClassPath`, а сами библиотеки разместите на всех узлах во время создания кластера {{ dataproc-name }} с помощью скриптов инициализации. Пути к используемым библиотекам должны совпадать на всех узлах кластера.

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