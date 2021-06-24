# Резервное копирование

В этом разделе описаны поддерживаемые способы создания резервных копий баз данных YDB и восстановления из созданных ранее резервных копий. {{ ydb-short-name }} позволяет использовать следущие места назначения для создания резервных копий:
* csv-файлы на файловой системе;
{% if audience == "internal" %}
* YT;
{% endif %}
* AWS S3-совместимые хранилища.

{% note warning "Влияние резервного копирования на производительность" %}

Операция резервного копирования может отрицательно сказываться на показателях взаимодействия с базой. Может вырасти время выполнения запросов. До того, как выполнять резервное копирование под нагрузкой на продакшн базах протестируйте, пожалуйста, процесс в тестовом контуре.

{% endnote %}

## Предварительные требования


{% if audience == "external" %}

1. Установите [консольный клиент YDB](../quickstart/yql-api/ydb-cli.md#how-to-install).
1. В свойствах базы на вкладке "Обзор" найдите и скопируйте значения полей **Эндпоинт** и **База данных**.
1. Сохраните значения полей **Эндпоинт** и **База данных** в переменных окружения `$YDB_ENDPOINT` и `$YDB_DB_PATH`.

{% endif %}
{% if audience != "external" %}

Для любого описанного ниже рецепта создания резервной копии понадобится:
* [консольный клиент YDB](../getting_started/ydb_cli.md);
* endpoint базы данных (информация об endpoint доступна на странице [Info](https://ydb.yandex-team.ru/db/ydb-ru/tutorial/home/testdb/info) вашей БД);
* пользователь, авторизованный для чтения и записи данных из таблиц, для которых будет создана резервная копия;
* [токен для аутентификации](../getting_started/start_auth.md) пользователя, от имени которого будет выполняться операция.

{% endif %}

В примерах ниже предполагается, что эндпоинт и полный путь базы данных сохранены в переменных окружения `$YDB_ENDPOINT` и `$YDB_DB_PATH` соответственно.

{% if audience != "external" %}

{% note info "Аутентификация" %}

Для аутентификации в YDB cli используется токен из переменной окружения __YDB_TOKEN__ или из файла `~/.ydb/token`.

{% endnote %}

{% endif %}

## Ограничения {#limitations}

В текущей реализации в YDB допустимо создание резервной копии не более чем 1000 таблиц одновременно.

## Резервное копирование на файловую систему {#filesystem_backup}

Сохранение структуры директории `backup` в базе `$YDB_DB_PATH` в директорию `my_backup_of_basic_example` на файловой системе.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/backup -o my_backup_of_basic_example/
```

Для каждой директории в базе будет создана директория на файловой системе. Для каждой таблицы так же будет создана директория на файловой системе, в которую будет помещён файл с описанием структуры. Данные таблиц будут сохранены в одном или нескольких файлах в формате `csv`, по одной строке в файле для строки таблицы.

{% if audience != "external" %}

Строковые данные перед сохранением преобразуются в urlencoded представление с помощью функции [CGIEscape](https://a.yandex-team.ru/arc/trunk/arcadia/util/string/quote.h?rev=5058568#L6-25).

{% endif %}

### Пример листинга содержимого директории с резервной копией

```
tree my_backup_of_basic_example/
my_backup_of_basic_example/
├── episodes
│   ├── data_00.csv
│   └── scheme.pb
├── seasons
│   ├── data_00.csv
│   └── scheme.pb
└── series
    ├── data_00.csv
    └── scheme.pb

3 directories, 6 files
```

Структура каждой таблицы сохранена в файле с именем `scheme.pb`, например в `episodes/scheme.pb` сохранена схема таблицы `episodes`. Данные каждой таблицы сохранены в одном или нескольких файлах с именами вида `data_хх.csv`, где хх – порядковый номер файла. Имя первого файла – `data_00.csv`. Ограничение на размер одного файла – 100 Мб.

### Сохранение схемы таблиц

Команда `{{ ydb-cli }} tools dump`, запущенная с опцией `--scheme-only`, сохранит только схемы таблиц. Команда, приведённая ниже, сохранит все директории и файлы со структурой таблиц из директории `examples` в базе `$YDB_DB_PATH` в папку `my_backup_of_basic_example`. Файлы с данными таблиц созданы не будут.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/examples -o my_backup_of_basic_example/ --scheme-only
```

## Восстановление из резервной копии на файловой системе {#filesystem_restore}

Команда, приведённая ниже, создаст директории и таблицы из резервной копии, сохранённой в директории `my_backup_of_basic_example` и загрузит в них данные.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools restore  -p $YDB_DB_PATH/backup/restored -i my_backup_of_basic_example/
```

### Проверка резервной копии

Команда `{{ ydb-cli }} tools restore`, запущенная с опцией `--dry-run`, позволяет проверить, что все таблицы в базе содержатся в резервной копии и что структуры таблиц одинаковы.

Команда, приведённая ниже, проверит, что все таблицы, сохранённые в `my_backup_of_basic_example`, существуют в базе  `$YDB_DB_PATH` и их структура (состав и порядок столбцов, типы данных столбцов, состав первичного ключа) одинаковы.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools restore  -p $YDB_DB_PATH/restored_basic_example -i my_backup_of_basic_example/ --dry-run
```

## Резервное копирование в S3-совместимые хранилища {#s3_backup}

YDB позволяет сохранять резервные копии баз данных в хранилища, поддерживающие [Amazon Simple Storage Service (AWS S3) API](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html).

{% if audience != "external" %}

В этом разделе в качестве системы назначения используется [MDS](https://wiki.yandex-team.ru/mds/) – система хранения данных, доступная в Яндексе и предоставляющая возможность доступа по интерфейсу, совместимому с Amazon S3. Более подробно MDS S3 API [описан в документации](https://wiki.yandex-team.ru/mds/s3-api/).

{% endif %}

{% if audience == "external" %}

В этом разделе в качестве системы назначения используется [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage).

{% endif %}

### Предварительные требования {#s3_prerequisites}

{% if audience != "external" %}

Для сохранения резервной копии базы данных YDB в MDS вам понадобится:

* [квота](https://wiki.yandex-team.ru/mds/s3-api/authorization/#registracijaservisa-klienta) в MDS;
* [предварительно созданный](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/#primery) бакет в MDS;
* [пользователь](https://wiki.yandex-team.ru/mds/s3-api/authorization/#vydachapravrobotuilisotrudniku), обладающий правом на запись в бакет.

{% endif %}

{% if audience == "external" %}

Для сохранения резервной копии базы данных YDB в [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage) вам понадобится [предварительно созданный](https://cloud.yandex.ru/docs/storage/concepts/bucket) бакет;

{% endif %}

### Создание ключей доступа {#s3_create_access_keys}

Для аутентификации и авторизации в S3-совместимых хранилищах используются ключи доступа.

{% if audience != "external" %}

В [документации к MDS S3 API описана](https://wiki.yandex-team.ru/mds/s3-api/authorization/#sozdanieaccesskey) процедура создания и получения ключей доступа.

[Консольный клиент YDB](../getting_started/ydb_cli.md) предоставляет три варианта передачи ключей доступа:

{% endif %}

{% if audience == "external" %}

[Консольный клиент YDB](../quickstart/yql-api/ydb-cli.md) предоставляет три варианта передачи ключей доступа:

{% endif %}

* через опции командной строки `--access-key` и `--secret-key`;
* через переменные окружения `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`;
* через файл `~/.aws/credentials`, создаваемый и используемый [aws cli](https://aws.amazon.com/ru/cli/).

Настройки применяются в порядке, описанном выше. Например, если одновременно использовать все три варианта передачи значения access_key или secret_key, то будут использованы значения, переданные через опции командной строки.


### Запуск операции экспорта в S3 {#s3_export}

Команды в примерах ниже составлены из расчёта, что данные ключей доступа сохранены в файл `~/.aws/credentials`.

Запуск операции операции экспорта данных из таблиц `$YDB_DB_PATH/backup/episodes`, `$YDB_DB_PATH/backup/seasons`, `$YDB_DB_PATH/backup/series` в YDB в базе `$YDB_DB_PATH` в файлы с префиксом `20200601/` в бакете `testdbbackups` в {{ objstorage-name }}.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH export s3 --s3-endpoint {{ s3-storage-host }}  --bucket testdbbackups\
--item source=$YDB_DB_PATH/backup/episodes,destination=20200601/episodes\
--item source=$YDB_DB_PATH/backup/seasons,destination=20200601/seasons\
--item source=$YDB_DB_PATH/backup/series,destination=20200601/series
```

В результате выполнения команды консольный клиент выведет информацию о статусе запущенной операции.

{% if audience != "external" %}

```
┌───────────────────────────────────────────┬───────┬─────────┬───────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress  | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | false | SUCCESS | Preparing | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                      |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                   |
|     destination_prefix: 20200601/episodes                                                                   |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                    |
|     destination_prefix: 20200601/seasons                                                                    |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                     |
|     destination_prefix: 20200601/series                                                                     |
| Description:                                                                                                |
| Number of retries: 10                                                                                       |
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```
{% endif %}

{% if audience == "external" %}

```
┌───────────────────────────────────────────┬───────┬─────────┬───────────┬─────────────────────────┬────────────────────┐
| id                                        | ready | status  | progress  | endpoint                | bucket             |
├───────────────────────────────────────────┼───────┼─────────┼───────────┼─────────────────────────┼────────────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | false | SUCCESS | Preparing | storage.yandexcloud.net | testdbbackups      |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                 |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                                |
|     destination_prefix: 20200601/episodes                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                 |
|     destination_prefix: 20200601/seasons                                                                               |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                  |
|     destination_prefix: 20200601/series                                                                                |
| description:                                                                                                           |
| Number of retries: 10                                                                                                  |
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```
{% endif %}


После успешного завершения операции экспорта в бакете `testdbbackups` будут сохранены файлы в формате `csv` с данными и схемой таблиц c префиксами, перечисленными ниже.
```
20200601/episodes
20200601/seasons
20200601/series
```

Формат идентичен формату файлов, создаваемых в результате [резервного копирования на файловую систему](backup_and_recovery.md#filesystem_backup).

В результате выполнения с помощью aws cli приведённой ниже команды на экран будет выведен список префиксов, созданных в результате бекапа в бакете `testdbbackup`.

```
aws --endpoint-url=https://{{ s3-storage-host }} s3 ls testdbbackups/20200601/
                           PRE episodes/
                           PRE seasons/
                           PRE series/
```

{% note info "Работа с директориями" %}

Чтобы сделать резервную копию всех таблиц в директории YDB, следует указать путь до директории в качестве источника.

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH export s3 \
--s3-endpoint {{ s3-storage-host }} \
--bucket testdbbackups \
--item source=$YDB_DB_PATH/backup,destination=20200601/
```

{% endnote %}

{% if audience != "external" %}

вывести на экран текущее состояние запущенной ранее операции экспорта можно приведённой ниже командой.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation get 'ydb://export/6?id=846776181822113&kind=s3'
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | false | SUCCESS | TransferData  | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                          |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                       |
|     destination_prefix: 20200601/episodes                                                                       |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                        |
|     destination_prefix: 20200601/seasons                                                                        |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                         |
|     destination_prefix: 20200601/series                                                                         |
| description:                                                                                                    |
| Number of retries: 10                                                                                           |
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

В случае успешного завершения операции экспорта в столбце progress будет отображено значение `Done`, в столбце status – `Success`, в столбце ready – `true`.
```
┌───────────────────────────────────────────┬───────┬─────────┬──────────┬───────────────────┬───────────────┐
| id                                        | ready | status  | progress | endpoint          | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼──────────┼───────────────────┼───────────────┤
| ydb://export/6?id=846776181822113&kind=s3 | true  | SUCCESS | Done     | s3.mds.yandex.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                     |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                                  |
|     destination_prefix: 20200601/episodes                                                                  |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                                   |
|     destination_prefix: 20200601/seasons                                                                   |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                                    |
|     destination_prefix: 20200601/series                                                                    |
| description:                                                                                               |
| Number of retries: 10                                                                                      |
└────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}

{% if audience == "external" %}

вывести на экран текущее состояние запущенной ранее операции экспорта можно приведённой ниже командой.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation get 'ydb://export/6?id=562950168911361&kind=s3'
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬─────────────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint                | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼─────────────────────────┼───────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | false | SUCCESS | TransferData  | storage.yandexcloud.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                               |
|     destination_prefix: 20200601/episodes                                                                             |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                |
|     destination_prefix: 20200601/seasons                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                 |
|     destination_prefix: 20200601/series                                                                               |
| description:                                                                                                          |
| Number of retries: 10                                                                                                 |
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```
В случае успешного завершения операции экспорта в столбце progress будет отображено значение `Done`, в столбце status – `Success`, в столбце ready – `true`.
```
┌───────────────────────────────────────────┬───────┬─────────┬───────────────┬─────────────────────────┬───────────────┐
| id                                        | ready | status  | progress      | endpoint                | bucket        |
├───────────────────────────────────────────┼───────┼─────────┼───────────────┼─────────────────────────┼───────────────┤
| ydb://export/6?id=562950168911361&kind=s3 | true  | SUCCESS | Done          | storage.yandexcloud.net | testdbbackups |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                                                |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/episodes                               |
|     destination_prefix: 20200601/episodes                                                                             |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/seasons                                |
|     destination_prefix: 20200601/seasons                                                                              |
|   - source_path: /ru-central1/b1g8skpblkos03malf3s/etn03umjgudn9q4l0vkk/backup/series                                 |
|     destination_prefix: 20200601/series                                                                               |
| description:                                                                                                          |
| Number of retries: 10                                                                                                 |
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

{% endif %}




### Восстановление из S3-совместимых хранилищ {#s3_restore}

Предварительно нужно подключить бакет, содержащий файлы с резервной копией базы YDB в s3-совместимом хранилище, чтобы она была доступна через операции с файловой системой.
{% if audience != "external" %}

Для подключения бакета можно воспользоваться одним из [клиентов](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/), например s3fs.
{% endif %}

После успешного подключения следует загрузить данные из копии в YDB по инструкции, описанной в разделе [Восстановление из резервной копии на файловой системе](backup_and_recovery.md#filesystem_restore).

### Завершение операции резервного копирования {#s3_forget}

Для минимизации влияния процесса резервного копирования на показатели пользовательской нагрузки отправка данных осуществляется с копий таблиц. Перед отправкой данных из YDB процесс резервного копирования создаёт консистентные копии всех отправляемых таблиц в YDB. Так как это copy-on-write копии, то в момент их создания размер базы практически не меняется. После завершения отправки данных созданные копии остаются в базе.

Чтобы удалить созданные копии таблиц из базы и завершённую операцию из списка операций, нужно выполнить команду

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation forget 'ydb://export/6?id=283824558378666&kind=s3'
```

{% if audience != "external" %}

## Резервное копирование в YT {#yt_backup}

### Предварительные требования {#yt_preprequisites}

Для сохранения резервной копии базы YDB в YT вам понадобится существующая папка на одном из кластеров YT.

{% note info "Аутентификация" %}

Для аутентификации в YT ydb cli использует токен из переменной окружения __YT_TOKEN__ или из файла `~/.yt/token`.

{% endnote %}


### Создание резервной копии в YT {#yt_export}

Ниже перечислены действия, необходимые для создания консистентной копии таблиц в директории `backup` в базе данных `/ru/tutorial/home/testdb`
в виде таблиц в  [YT](https://yt.yandex-team.ru/docs/).

Запуск операции экспорта данных из таблиц `/ru/tutorial/home/testdb/backup/episodes`, `/ru/tutorial/home/testdb/backup/seasons`, `/ru/tutorial/home/testdb/backup/series` в YDB в базе `/ru/tutorial/home/testdb` на кластере `ydb-ru` в соответствующие таблицы в YT на кластере [hahn](https://hahn.yt.yandex.net/).
```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb export yt --proxy hahn\
--item source=/ru/tutorial/home/testdb/backup/episodes,destination=//home/kikimr/backup_docs/episodes\
--item source=/ru/tutorial/home/testdb/backup/seasons,destination=//home/kikimr/backup_docs/seasons\
--item source=/ru/tutorial/home/testdb/backup/series,destination=//home/kikimr/backup_docs/series
```

В результате выполнения команды ydb cli выведет информацию о статусе запущенной операции.

```
┌───────────────────────────────────┬───────┬─────────┬───────────┬───────────────────────┐
| id                                | ready | status  | progress  | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼───────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | false | SUCCESS | Preparing | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                  |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                               |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                   |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                    |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                 |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                     |
| description:                                                                            |
| Number of retries: 5                                                                    |
└─────────────────────────────────────────────────────────────────────────────────────────┘
```


{% note info "Работа с директориями" %}

Чтобы сделать резервную копию всех таблиц в директории YDB, нужно указать путь до директории в качестве источника

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb export yt --proxy hahn --item source=/ru/tutorial/home/testdb/backup,destination=//home/kikimr/backup_docs/
```

{% endnote %}

Вывести на экран текущее состояние запущенной ранее операции экспорта можно командой, приведённой ниже.
```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation get ydb://export/6?id=845646488977644
┌───────────────────────────────────┬───────┬─────────┬──────────────┬───────────────────────┐
| id                                | ready | status  | progress     | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼──────────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | false | SUCCESS | TransferData | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                     |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                                  |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                      |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                                   |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                       |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                    |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                        |
| description:                                                                               |
| Number of retries: 5                                                                       |
└────────────────────────────────────────────────────────────────────────────────────────────┘
```
В случае успешного завершения операции экспорта в столбце progress будет отображено значение Done, в столбце status – Success, в столбце ready – true.
```
┌───────────────────────────────────┬───────┬─────────┬──────────┬───────────────────────┐
| id                                | ready | status  | progress | yt proxy              |
├───────────────────────────────────┼───────┼─────────┼──────────┼───────────────────────┤
| ydb://export/6?id=845646488977644 | true  | SUCCESS | Done     | hahn.yt.yandex.net:80 |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┤
| Items:                                                                                 |
|   - source_path: /ru/tutorial/home/testdb/backup/episodes                              |
|     destination_path: <append=true>//home/kikimr/backup_docs/episodes                  |
|   - source_path: /ru/tutorial/home/testdb/backup/seasons                               |
|     destination_path: <append=true>//home/kikimr/backup_docs/seasons                   |
|   - source_path: /ru/tutorial/home/testdb/backup/series                                |
|     destination_path: <append=true>//home/kikimr/backup_docs/series                    |
| description:                                                                           |
| Number of retries: 5                                                                   |
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### Завершение операции резервного копирования в YT {#yt_forget}

Для минимизации влияния процесса резервного копирования на показатели пользовательской нагрузки отправка данных осуществляется с копий таблиц. Перед отправкой данных из YDB процесс резервного копирования создаёт консистентные копии всех отправляемых таблиц в YDB. Так как это copy-on-write копии, то в момент создания копии размер базы практически не меняется. После завершения отправки данных созданные копии остаются в базе.

Чтобы удалить созданные копии таблиц из базы и завершённую операцию из списка операций, нужно выполнить команду

`ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation forget ydb://export/6?id=845646488977644`

### Распространённые ошибки {#common_errors}

#### Использование неподходящего токена для доступа к YT

Аутентификация и авторизация доступа к кластеру YT для операции резервного копирования осуществляется с помощью OAuth-токена из переменной окружения __YT_TOKEN__ или из файла `~/.yt/token`.

Если используется недействительный токен или токен пользователя, у которого нет прав доступа к таблицам в YT, или токен не указан, операция экспорта из YDB в YT запустится и какое-то время YDB будет пытаться отправить данные в YT. После достижения указанного максимального количества попыток отправить данные, операция будет отменена.

В результате выполнения команды для отображения состояния операции будет отображено сообщение об ошибке.

```
ya ydb -e ydb-ru.yandex.net:2135 -d /ru/tutorial/home/testdb operation get ydb://export/6?id=845646488977644

Status: CANCELLED
Issues:
<main>: Error: shard: 8142613, error: bad http reply status from proxy-broker
```

### Восстановление из копии в YT {#yt_restore}

Для восстановления данных из резервной копии, сохранённой в YT, следует воспользоваться [рецептом](../best_practices/import_from_yt.md) загрузки данных из YT в YDB.

{% endif %}
