# Анализ данных с помощью {{ jlab }}

{{ yq-full-name }} поддерживает интеграцию с [{{ jlab }}](https://jupyter.org) и [VSCode](https://code.visualstudio.com/docs/datascience/jupyter-notebooks) через магические команды Python `cell` (`%%yq`) и `line` (`%yq`). Интеграция позволяет упростить рабочие процессы сбора и анализа данных, делая их более эффективными и удобными.

![jupyter-screenshot](../../_assets/query/jupyter-screenshot.png)

Чтобы анализировать данные {{ yq-name }} с помощью {{ jlab }}:

1. [Установите и настройте пакет {{ yq-name }} magic](#setup-plugin).
1. [Шаблонизируйте запросы](#templating).
1. [Захватите результаты выполнения команд](#capture-command-result).

## Перед началом работы {#before-you-begin}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

1. [Получите доступ](https://jupyter.org/install) к окружению {{ jlab }}Lab или {{ jlab }} Notebook.

## Установите и настройте пакет {{ yq-name }} magic {#setup-plugin}

{% list tabs %}

- {{ jlab }}

  Установите пакет [yandex_query_magic](https://pypi.org/project/yandex-query-magic/), выполнив в ячейке ноутбука команду:
  
  ```python
  %pip install yandex_query_magic --upgrade
  ```

- Shell

  1. Установите пакет [yandex_query_magic](https://pypi.org/project/yandex-query-magic/) c помощью pip:
  
     ```shell
     pip install yandex_query_magic --upgrade
     ```
  
  1. Включите {{ jlab }}-расширение для элементов управления интерфейса в {{ jlab }} Notebook:
  
     ```shell
     %jupyter contrib nbextension install --user
     ```
 
     Если вы столкнетесь с ошибкой `"No module named 'notebook.base'"`, попробуйте перейти на версию {{ jlab }} Notebook 6.4.12:
 
     ```shell
     pip install --upgrade notebook==6.4.12
     ```  

{% endlist %}

### Настройте пакет {#global-settings}

Настройки пакета `yandex_query_magic` можно задать с помощью line команды `yq_settings`, где указываются необходимые аргументы:

```shell
%yq_settings --folder-id <идентификатор_каталога> ...
```

Доступные параметры:

* `--folder-id <идентификатор_каталога>` — идентификатор каталога для выполнения запросов {{ yq-name }}. По умолчанию используется каталог, где запущена виртуальная машина с {{ jlab }}.
* `--vm-auth` — устанавливает режим аутентификации ключом учетной записи виртуальной машины. Подробнее см. в инструкции [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).
* `--env-auth <переменная_окружения_environment_variable>` — устанавливает режим аутентификации авторизованным ключом, содержимое которого находится в переменной окружения (Environment Variable). Этот режим предназначен для работы в условиях, когда нет доступа к файловой системе компьютера, где установлен {{ jlab }}. Например, в [{{ ml-platform-full-name }}](../../datasphere/concepts/index.md). В этом случае создайте [секрет {{ ml-platform-name }}](../../datasphere/operations/data/secrets.md), а имя созданного секрета укажите в параметре `--env-auth`.
* `--sa-file-auth <авторизованный_ключ>` — устанавливает режим аутентификации авторизованными ключами. Подробнее см. в инструкции [{#T}](../../iam/operations/authorized-key/create.md).

### Проверьте работу пакета {#check-installation}

Команду `%yq line magic` можно использовать, когда весь SQL-запрос представлен одной строкой. В этом случае SQL-запрос выполняется с помощью ключевого слова `%yq`.

Если {{ jlab }} запущен в виртуальной машине с [привязанным к ней сервисным аккаунтом](../../compute/operations/vm-connect/auth-inside-vm), загрузите расширение в {{ jlab }}:

```sql
%load_ext yandex_query_magic
%yq SELECT "Hello, world!"
```

Где:

* `%yq` — имя {{ jlab }} magic.
* `SELECT "Hello, world!"` — текст запроса к {{ yq-name }}.

Если к виртуальной машине не привязан сервисный аккаунт:

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `yq.viewer`.

1. [Создайте авторизованный ключ](../../iam/operations/authorized-key/create.md) для сервисного аккаунта.

1. Выполните следующие команды, указав путь к файлу с авторизованным ключом:

    ```sql
    %load_ext yandex_query_magic
    %yq_settings --sa-file-auth '<путь_к_файлу_с_ключом>'
    %yq SELECT "Hello, world!"
    ```

    Например:

    ```sql
    %load_ext yandex_query_magic
    %yq_settings --sa-file-auth '/home/test/authorized_key.json'
    %yq SELECT "Hello, world!"
    ```

    Путь к файлу `authorized_key.json` указывается относительно директории, в которой сохранен файл с текущим {{ jlab }} Notebook.

Чтобы выполнять многострочные SQL-запросы, необходимо использовать `%%yq cell magic`. Текст запроса должен начинаться с ключевого слова `%%yq`:

```sql
%%yq --folder-id <идентификатор_каталога> --name "Мой запрос" --description "Тестовый запрос" --raw-results

SELECT
    col1,
    COUNT(*)
FROM table
GROUP BY col1
```

Где:

* `--folder-id` — идентификатор каталога для выполнения запроса {{ yq-name }}. По умолчанию используется каталог, указанный ранее через `%yq_settings`. Если он не указан, то используется каталог, в котором запущена виртуальная машина.
* `--name` — имя запроса.
* `--description` — описание запроса.
* `--raw-results` — возвращает необработанные результаты выполнения запроса в {{ yq-name }}. Спецификация формата доступна в разделе [{#T}](../api/yql-json-conversion-rules.md).

## Шаблонизируйте запросы с помощью mustache-синтаксиса {#templating}

Шаблоны вычислений между {{ jlab }} и {{ yq-name }} можно использовать для работы с запросами, а также для выполнения типовых операций без написания кода на языках программирования. Для этого в {{ yq-name }} встроена поддержка написания запросов в [mustache-синтаксисе](https://mustache.github.io), когда все ключевые слова и директивы шаблонов размещаются внутри ключевых символов `{{}}`. Mustache-синтаксис можно использовать с [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/) или с разными типами таблиц.

Встроенные mustache-шаблоны {{ yq-name }} позволяют передавать переменные из среды исполнения {{ jlab }} прямо внутрь SQL-запросов, не конвертируя их в типы SQL. При этом передаваемые переменные автоматически будут конвертированы в нужные структуры данных {{ yq-name }}. Например:

```python
myQuery = "select * from Departments"
%yq not_var{{myQuery}}
```

Mustache-строка `not_var{{myQuery}}` будет интерпретирована как название переменной, откуда нужно взять текст. При этом в {{ yq-name }} будет отправлен для исполнения текст `select * from Departments`.

Использование mustache-шаблонов упрощает интеграцию между {{ jlab }} и {{ yq-name }}. Например, у вас есть Python list `lst=["Academy", "Physics"]`, содержащий названия департаментов, данные из которых вы хотите обработать. Без поддержки mustache-синтаксиса в {{ yq-name }} вам предварительно нужно было бы превратить Python list в строку и передать ее в SQL запрос. Пример запроса:

```python
var lstStr = ",".join(lst)
sqlQuery = f'select "Academy" in ListCreate({lstStr});
%yq not_var{{sqlQuery}}
```

То есть для работы со сложными типами данных нужно знать детали синтаксиса SQL {{ yq-name }}. При использовании mustache-синтаксиса запрос можно написать проще:

```sql
%yq select "Academy" in not_var{{lst}}
```

При этом `lst` будет распознан как Python list и будет автоматически вставлена правильная SQL-конструкция для работы со списками. В данном случае в результате всех преобразований в {{ yq-name }} будет отправлен следующий текст запроса:

```sql
%yq select "Academy" in ListCreate("Academy", "Physics") as lst
```

### Jinja2 {#jinja2}

При типовой работе в {{ jlab }} и {{ yq-name }} рекомендуется использовать встроенный mustache-синтаксис. Если вам нужны расширенные возможности шаблонизации, используйте шаблоны Jinja2.

Чтобы установить Jinja2, выполните команду:

```python
%pip install Jinja2
```

Пример использования Jinja-шаблона с циклом `for`:

```python
{% for user in users %}
    command = "select * from users where name='not_var{{ user }}'"
{% endfor %}
```

Также c помощью Jinja-шаблонов можно выполнять различные операции обработки данных. В следующем примере, в зависимости от департамента, где обучается студент, выполняются различные операции над названием департамента:

```python
{% if student.department == "Academy" %}
    not_var{{ student.department|upper }}
{% elif  upper(student.department) != "MATHS DEPARTMENT" %}
    not_var{{ student.department|capitalize }}
{% endif %}
```

Для полноценной интеграции с jinja2 необходимо подсказывать, что она работает внутри {{ yq-name }}. Чтобы указать Jinja, что конвертация должна выполняться по правилам {{ yq-name }}, используйте специальный фильтр `to_yq`. Например, Python list `lst=["Academy", "Physics"]` из предыдущего примера в Jinja-шаблоне будет иметь вид:

```sql
%%yq --jinja2
select "Academy" in not_var{{lst|to_yq}}
```

В случаях, когда нужно отключить шаблонизацию, используйте аргумент `--no-var-expansion`:

```sql
%%yq --no-var-expansion
...
```

### Использования mustache-синтаксиса с таблицами {#tables}

Mustache-синтаксис позволяет упростить получение данных из таблиц. Во время выполнения запроса переменной присваивается значение временно созданной таблицы. Таблица может использоваться в пределах текущего исполняемого запроса в {{ yq-name }}.

#### Использование переменных Pandas DataFrame {#capture-dataframe}

Пример использования `yandex_query_magic` и mustache-синтаксиса с [Pandas DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html):

1. Объявите переменную в {{ jlab }}:

    ```python
    df = pandas.DataFrame({'_float': [1.0],
                        '_int': [1],
                        '_datetime': [pd.Timestamp('20180310')],
                        '_string': ['foo']})
    ```

1. Получите данные:

    ```sql
    %%yq
    SELECT
        *
    FROM mytable
    INNER JOIN not_var{{df}}
        ON mytable.id=df._int
    ```

Таблица соответствия типов Pandas и типов {{ yq-name }}:

| Тип Pandas | Тип YQL | Примечание |
|-----|-----|-----|
| int64 | Int64 | При выходе значения за диапазон `int64` возникнет ошибка выполнения SQL-запроса |
| float64 | Double ||
| datetime64[ns] | Timestamp | Точность до микросекунд. При задании наносекунд ([поле `nanosecond`](https://pandas.pydata.org/docs/user_guide/timeseries.html#time-date-components)) возвращается исключение |
| str | String ||

#### Использование переменных Python dict {#capture-dict}

Пример использования `yandex_query_magic` и mustache-синтаксиса с Python dict:

1. Объявите переменную в {{ jlab }}:

    ```python
    dct = {"a": "1", "b": "2", "c": "test", "d": "4"}
    ```

    Теперь переменная `dct` может использоваться напрямую в запросах {{ yq-name }}. Во время выполнения запроса `dct` будет преобразован в соответствующий объект [YQL Dict](https://ydb.tech/docs/ru/yql/reference/builtins/dict):

    | Ключ | Значение |
    |---|---|
    | а | "1" |
    | b | "2" |
    | c | "test" |
    | d | "4" |

1. Получите данные:

    ```sql
    %%yq
    SELECT "a" in not_var{{dct}}
    ```

Таблица соответствия типов Python dict и типов {{ yq-name }}:

| Тип Python | Тип YQL | Примечание |
|-----|-----|-----|
| int | Int64 | При выходе значения за диапазон int64 возникнет ошибка выполнения SQL-запроса |
| float | Double ||
| datetime | Timestamp ||
| str | String ||

Словарь также можно преобразовать в таблицу [Pandas DataFrame](#capture-dataframe) с помощью конструктора:

```python
df = pandas.DataFrame(dct)
```

#### Использование переменных Python list {#capture-list}

Пример использования `yandex_query_magic` и mustache-синтаксиса с Python list:

1. Объявите переменную в {{ jlab }}:

    ```python
    lst = [1,2,3]
    ```

    Тогда переменная `lst` может использоваться напрямую в запросах {{ yq-name }}. Во время выполнения запроса `lst` будет преобразован в соответствующий объект [YQL List](https://ydb.tech/docs/ru/yql/reference/types/containers).

1. Получите данные:

    ```sql
    %%yq
    SELECT 1 IN not_var{{lst}}
    ```

Таблица соответствия типов Python list и типов {{ yq-name }}:

| Тип Python | Тип YQL | Примечание |
|-----|-----|-----|
| int | Int64 | При выходе значения за диапазон int64 возникнет ошибка выполнения SQL-запроса |
| float | Double ||
| datetime | Timestamp ||
| str | String ||

Список также можно преобразовать в таблицу [Pandas DataFrame](#capture-dataframe) с помощью конструктора:

```python
df = pandas.DataFrame(lst,
                      columns =['column1', 'column2', 'column3'])
```

## Захватите результаты выполнения команд {#capture-command-result}

Результат выполнения команд может быть захвачен в переменную с помощью команды присваивания или оператора `<<`. После этого результат выполнения можно использовать, как обычную переменную {{ jlab }}.

* Команда присваивания:

    ```
    varname = %yq <запрос>
    ```

    Пример:

    ```sql
    output = %yq SELECT 1 as column1
    output
    ```

    Результат:

    | | **column1** |
    |---|---|
    | **0** | 1 |

* Оператор `<<`:

    ```
    %%yq
    varname << <запрос>
    ```

    Пример:

    ```sql
    %%yq
    output << SELECT 'Two' as column2, 3 as column3
    output
    ```

    Результат:

    || **column2** | **column3** |
    |---|----|-----|
    | **0** | Two | 3 |

По умолчанию результатом выполнения команд захвата является Pandas DataFrame с колонками, совпадающими с названиями колонок из SQL-запроса и со строками, содержащими результаты запроса. Конвертацию в Pandas DataFrame можно отключить с помощью аргумента `--raw-results`.

Если запрос не предполагает возврат результатов (например, `insert into table select * from another_table`), то возвращаемым значением будет `None`. Если в результате выполнения запроса было возвращено несколько наборов результатов, то они будут представлены в виде списка (`list`) из отдельных результатов.

Во время выполнения запроса пакет `yandex_query_magic` выводит дополнительную информацию. Например: идентификатор запроса, время начала и продолжительность выполнения запроса.

![](../../_assets/query/jupyter-query-info-progress-output.png)

Чтобы скрыть отображение прогресса выполнения для ячейки, можно использовать дополнительную команду `%%capture`.
