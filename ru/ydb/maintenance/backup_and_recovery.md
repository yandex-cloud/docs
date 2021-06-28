# Резервное копирование

В этом разделе описаны поддерживаемые способы создания резервных копий баз данных YDB и восстановления из созданных ранее резервных копий. {{ ydb-short-name }} позволяет использовать следущие места назначения для создания резервных копий:
* csv-файлы на файловой системе;
* AWS S3-совместимые хранилища.

{% note warning "Влияние резервного копирования на производительность" %}

Операция резервного копирования может отрицательно сказываться на показателях взаимодействия с базой. Может вырасти время выполнения запросов. До того, как выполнять резервное копирование под нагрузкой на продакшн базах протестируйте, пожалуйста, процесс в тестовом контуре.

{% endnote %}

## Предварительные требования



1. Установите [консольный клиент YDB](../quickstart/yql-api/ydb-cli.md#how-to-install).
1. В свойствах базы на вкладке "Обзор" найдите и скопируйте значения полей **Эндпоинт** и **База данных**.
1. Сохраните значения полей **Эндпоинт** и **База данных** в переменных окружения `$YDB_ENDPOINT` и `$YDB_DB_PATH`.

В примерах ниже предполагается, что эндпоинт и полный путь базы данных сохранены в переменных окружения `$YDB_ENDPOINT` и `$YDB_DB_PATH` соответственно.


## Ограничения {#limitations}

В текущей реализации в YDB допустимо создание резервной копии не более чем 1000 таблиц одновременно.

## Резервное копирование на файловую систему {#filesystem_backup}

Сохранение структуры директории `backup` в базе `$YDB_DB_PATH` в директорию `my_backup_of_basic_example` на файловой системе.
```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH tools dump -p $YDB_DB_PATH/backup -o my_backup_of_basic_example/
```

Для каждой директории в базе будет создана директория на файловой системе. Для каждой таблицы так же будет создана директория на файловой системе, в которую будет помещён файл с описанием структуры. Данные таблиц будут сохранены в одном или нескольких файлах в формате `csv`, по одной строке в файле для строки таблицы.


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



В этом разделе в качестве системы назначения используется [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage).

### Предварительные требования {#s3_prerequisites}



Для сохранения резервной копии базы данных YDB в [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage) вам понадобится [предварительно созданный](https://cloud.yandex.ru/docs/storage/concepts/bucket) бакет;

### Создание ключей доступа {#s3_create_access_keys}

Для аутентификации и авторизации в S3-совместимых хранилищах используются ключи доступа.



[Консольный клиент YDB](../quickstart/yql-api/ydb-cli.md) предоставляет три варианта передачи ключей доступа:

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




### Восстановление из S3-совместимых хранилищ {#s3_restore}

Предварительно нужно подключить бакет, содержащий файлы с резервной копией базы YDB в s3-совместимом хранилище, чтобы она была доступна через операции с файловой системой.

После успешного подключения следует загрузить данные из копии в YDB по инструкции, описанной в разделе [Восстановление из резервной копии на файловой системе](backup_and_recovery.md#filesystem_restore).

### Завершение операции резервного копирования {#s3_forget}

Для минимизации влияния процесса резервного копирования на показатели пользовательской нагрузки отправка данных осуществляется с копий таблиц. Перед отправкой данных из YDB процесс резервного копирования создаёт консистентные копии всех отправляемых таблиц в YDB. Так как это copy-on-write копии, то в момент их создания размер базы практически не меняется. После завершения отправки данных созданные копии остаются в базе.

Чтобы удалить созданные копии таблиц из базы и завершённую операцию из списка операций, нужно выполнить команду

```
{{ ydb-cli }} -e $YDB_ENDPOINT -d $YDB_DB_PATH operation forget 'ydb://export/6?id=283824558378666&kind=s3'
```

