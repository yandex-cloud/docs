---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Подключение внешних словарей

Вы можете подключать к кластеру [внешние словари](../concepts/dictionaries.md#external-dicts) и отключать их. Подробнее о словарях читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/).

{{ mch-name }} поддерживает несколько типов источников словарей:
   - HTTP(s); 
   - {{ PG }};
   - {{ MY }};
   - {{ CH }};
   - {{ MG }}.

Словарями можно управлять либо через SQL, либо через интерфейсы облака. SQL — рекомендуемый способ.

## Подключить словарь {#add-dictionary}

{% list tabs %}

- SQL

  {% note alert %}

  Если словарь добавлен через SQL, для него недоступно управление через консоль, CLI и API.

  {% endnote %}
    
  1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
  1. Выполните [DDL-запрос](https://clickhouse.tech/docs/ru/sql-reference/statements/create/dictionary/):

     ```sql
     CREATE DICTIONARY <имя словаря>(
     <столбцы данных>
     )
     PRIMARY KEY <имя столбца с ключами>
     SOURCE(<источник>(<конфигурация источника>))
     LIFETIME(<интервал обновления>)
     LAYOUT(<способ размещения в памяти>());
     ```

- Консоль управления

  {% note alert %}

  Если словарь добавлен через консоль, для него недоступно управление через SQL.

  {% endnote %}
  
  1. Выберите кластер:
  
     1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
     1. Нажмите на имя нужного кластера, затем выберите вкладку **Словари**.
     1. Нажмите на кнопку **Добавить словарь**.

  1. Настройте параметры источника словаря:
    
     Параметры подключения будут отличаться для разных типов источников.
     
     * **URL** — URL HTTP(s)-источника;
     * **Формат файла** — [Формат](https://clickhouse.yandex/docs/ru/interfaces/formats/#formats) файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/interfaces/formats/#formats).
     * **Реплики** — список реплик {{ MY }}, которые будут использоваться как источник словаря.
     Для реплик можно настроить собственные параметры подключения (порт, имя пользователя и пароль) или задать общие.
     * **Хост** — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
     * **Приоритет** — приоритет реплики {{ MY }}.  При попытке соединения {{ CH }} обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
     * **Порт** — порт для подключения к источнику.
     * **Пользователь** — имя пользователя базы данных источника.
     * **Пароль** — пароль для доступа к базе данных источника.
     * **База данных** — имя базы данных источника.
     * **Условие выбора** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора ```id=10``` эквивалентно SQL-команде ```WHERE id=10```. 
     Параметр доступен для {{ MY }} и {{ CH }}.
     * **Таблица** — имя таблицы источника.
     * **Коллекция** — имя коллекции для {{ MG }}-источника.
     * **Проверка статуса словаря** — Необязательный параметр. SQL-запрос для проверки изменений словаря.
     {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
     Подробнее читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/).
     * **SSL mode** — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}.
     Подробнее читайте в [документации {{ PG }}](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

     Подробнее об источниках словарей и параметрах их подключения читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_sources/).
     
  1. Настройте структуру и способы размещения словаря в памяти:
  
     **{{ mch-name }}** поддерживает несколько способов размещения словарей в памяти:
     ```flat```, ```hashed```, ```cache```, ```range_hashed```, ```complex_key_hashed```, ```complex_key_cache```.
     Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/). 

     Параметры будут отличаться для разных способов размещения в памяти:
     
     * **Размер кэша** — количество ячеек кэша для способов `cache`, `complex_key_cache`.
     Подробнее о кэше читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#cache).
     * **Числовой ключ** — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64.
     Используется для способов `flat`, `hashed`, `cache`, `range_hashed`.
     Подробнее о ключах читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#chislovoi-kliuch).
     * **Составной ключ** — столбцы, образующие составной ключ словаря. Укажите идентификаторы столбцов и их типы данных.
     Используется для способов `complex_key_hashed`, `complex_key_cache`.
     Подробнее о составных ключах читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#sostavnoi-kliuch).
     * **Столбец начала диапазона** и **Столбец конца диапазона** — столбцы, обозначающие начало и конец диапазона для способа `range_hashed`.
     Укажите идентификаторы столбцов и их типы данных.
     Подробнее о диапазонах читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#range-hashed).
     * **Столбцы данных** — список столбцов с данными словаря:
        * **Имя** — имя столбца.
        * **Тип** — тип данных столбца.
        * **Значение по умолчанию** — значение по умолчанию для пустого элемента.
        При загрузке словаря все пустые элементы будут заменены на это значение.
        Нельзя указать значение NULL. Необязательный параметр.
        * **Выражение** — [выражение](https://clickhouse.yandex/docs/ru/query_language/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца. Необязательный параметр.
        * **Иерархический** — признак поддержки иерархии.
        * **Инъективность** — признак инъективности отображения id -> attribute.
 
     Подробнее о параметрах столбцов читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#ext_dict_structure-attributes).
  
  1. Задайте периодичность обновления словаря:
  
     {{ CH }} загружает словари в оперативную память и периодически их обновляет.
     Вы можете задать фиксированный интервал обновления в секундах или указать диапазон,
     внутри которого {{ CH }} случайно выберет время для обновления.
     Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.
     
     Подробнее об обновлении словарей читайте в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/). 
  
  
- CLI

  {% note alert %}

  Если словарь добавлен через CLI, для него недоступно управление через SQL.

  {% endnote %}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы подключить внешний словарь к кластеру {{ CH }}:
  
  1. Посмотрите описание команды CLI для добавления словарей:
    
     ```
     $ {{ yc-mdb-ch }} cluster add-external-dictionary --help
     ```
     
  1. Выполните команду добавления словаря. Пример команды для {{ PG }} словаря: 
   
     ```
     $ {{ yc-mdb-ch }} cluster add-external-dictionary \
        --name <имя кластера {{ CH }}> \
        --dict-name <имя словаря> \
        --structure-id <имя ключевого столбца> \
        --structure-attribute name=<имя столбца данных>,type=<тип данных>,null-value=<значение для пустого элемента>,expression=<выражение>,hierarchical=<true|false>,injective=<true|false> \
        --fixed-lifetime <период обновления в секундах> \
        --layout-type <flat|hashed|cache|range_hashed|complex_key_hashed|complex_key_cache> \
        --postgresql-source db=<имя БД источника>,table=<имя таблицы источника>,port=<порт для подключения>,user=<имя пользователя БД источника>,password=<пароль БД источника>,ssl-mode=<disable|allow|prefer|require|verify-ca|verify-full> \
        --postgresql-source-hosts <хосты БД источника> \
     ```
    
- API

  {% note alert %}

  Если словарь добавлен через API, для него недоступно управление через SQL.

  {% endnote %}

  Подключить словарь можно с помощью метода [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md).

{% endlist %}

## Просмотреть список словарей {#get-dicts-list}

{% list tabs %}

- SQL
  
  1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
  1. Выполните [запрос](https://clickhouse.tech/docs/ru/sql-reference/statements/show/#show-dictionaries) `SHOW DICTIONARIES`.

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Словари**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы подключить внешний словарь к кластеру {{ CH }}:
  
  1. Посмотрите описание команды CLI для получения детальной информации о кластере:
  
     ```
     {{ yc-mdb-ch }} cluster get --help
     ```
  
  1. Выполните команду:
  
     ```
     {{ yc-mdb-ch }} cluster get <имя кластера>
     ```
  
  Подключенные словари отображаются в блоке ```dictionaries:``` результата выполнения команды.

- API

  Просмотреть список словарей можно вместе с остальными параметрами кластера с помощью метода [get](../api-ref/Cluster/get.md).

{% endlist %}

## Удалить словарь {#delete-dictionary}

{% list tabs %}

- SQL
  
  1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
  1. Выполните [запрос](https://clickhouse.tech/docs/ru/sql-reference/statements/drop/#drop-dictionary) `DROP DICTIONARY <имя БД>.<имя словаря>`.

- Консоль управления
  
  1. Перейдите на страницу каталога и нажмите плитку **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Словари**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить внешний словарь:
  
  1. Посмотрите описание команды CLI для удаления словаря:
  
     ```
     {{ yc-mdb-ch }} cluster remove-external-dictionary --help
     ```
  
  1. Удалите словарь с помощью команды:
  
     ```
     {{ yc-mdb-ch }} cluster remove-external-dictionary \
     --name <имя кластера> \
     --dict-name <имя словаря> \
     ```

- API

  Удалить словарь можно с помощью метода [deleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md).

{% endlist %}
