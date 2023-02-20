# История изменений в {{ mms-full-name }}

В разделе представлена история изменений сервиса {{ mms-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## III квартал 2022 {#q3-2022}

* Предоставление сервиса {{ mms-full-name }} прекращается: с 15 августа ограничена возможность создания новых кластеров, а 31 августа 2022 года в 23:59 UTC+3 будут остановлены существующие. Подробнее см. в [анонсе {{ yandex-cloud }}](https://cloud.yandex.ru/blog/posts/2022/07/microsoft-suspension). 
* Опубликовано [руководство по миграции данных из {{ mms-name }} в сторонний кластер {{ MS }}](tutorials/outbound-migration.md). 

## II квартал 2022 {#q2-2022}

* Добавлена возможность создания отказоустойчивой конфигурации кластера из двух хостов (раньше нужно было минимум три хоста).
* Добавлена возможность изменять настройку публичного доступа для хоста. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* В {{ TF }} добавлена настройка `sqlcollation`. {{ tag-tf }}
* Доработан механизм создания резервных копий: резервное копирование базы больше не влияет на резервное копирование логов WAL-G.
* Добавлена возможность ручной смены мастера в CLI с помощью команды `{{ yc-mdb-ms }} cluster start-failover`. {{ tag-cli }}
* Добавлена возможность [экспорта](operations/cluster-backups.md#objstorage-export) и [импорта](operations/cluster-backups.md#objstorage-import) резервной копии базы данных в {{ objstorage-full-name }}. {{ tag-cli }} {{ tag-con }}

## I квартал 2022 {#q1-2022}

* Добавлена процедура-обертка [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) для чтения лога ошибок. Вызов процедуры доступен пользователям с ролью `db_owner` хотя бы в одной базе данных. {{ tag-sql }}
