[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for MySQL®](../index.md) > Вопросы и ответы > Миграция/перенос

# Миграция/перенос

* [Как перенести данные в кластер?](#to-cluster)

* [Как перенести кластер в другой каталог или облако?](#to-folder-cloud)

* [Ошибка при внешней репликации](#external-replication-error)

* [Как устранить ошибку `Access denied` (1227) при создании дампа с помощью `mysqldump`?](#mysqldump-access-denied)

#### Как перенести данные в кластер? {#to-cluster}

Воспользуйтесь инструкцией в разделе [Миграция базы данных из стороннего кластера MySQL®](../tutorials/data-migration/index.md).

#### Как перенести кластер в другой каталог или облако? {#to-folder-cloud}

Чтобы перенести кластер:
* В другой каталог — [восстановите кластер из резервной копии](../operations/cluster-backups.md#restore). При задании параметров нового кластера укажите нужный каталог.
* В другое облако — воспользуйтесь инструкцией в разделе [Миграция базы данных из стороннего кластера MySQL®](../tutorials/data-migration/index.md).

#### Ошибка при внешней репликации {#external-replication-error}

Текст ошибки:

```text
Last\_IO\_Error: 
Got fatal error 1236 from source when reading data from binary log: 
'Could not find first log file name in binary log index file'
```

Ошибка может возникать в ходе внешней репликации с использованием [особого FQDN хоста-мастера](../operations/connect/fqdn.md#fqdn-master), если в кластере-источнике сменился хост-мастер.

**Решение:**

1. Запустите репликацию повторно.
1. Однократно выполните команду:

   ```sql
   STOP SLAVE;
   CHANGE MASTER TO MASTER_AUTO_POSITION = 1;
   START SLAVE;
   ```

При смене мастера в кластере-источнике репликация будет перенастроена на новый хост-мастер. Подробнее о настройке смотрите в [документации MySQL®](https://dev.mysql.com/doc/refman/8.0/en/change-master-to.html).

#### Как устранить ошибку `Access denied` (1227) при создании дампа с помощью `mysqldump`? {#mysqldump-access-denied}

При создании дампа с параметром `--single-transaction` возникает ошибка:

```text
mysqldump: Couldn't execute 'FLUSH TABLES': Access denied;
you need (at least one of) the RELOAD or FLUSH_TABLES privilege(s) for this operation (1227)
```

В кластерах Managed Service for MySQL® параметр `gtid_mode` имеет значение `ON`, а `--set-gtid-purged` по умолчанию — `AUTO`. При таком сочетании параметров `mysqldump` выполняет `FLUSH TABLES WITH READ LOCK`, чтобы записать в дамп текущий GTID вместе с согласованным снимком данных. Для выполнения этой команды утилита запрашивает привилегии `RELOAD` или `FLUSH_TABLES`, которые недоступны пользователям.

Чтобы устранить ошибку:

1. Проверьте версию утилиты:

   ```bash
   mysqldump --version
   ```

1. Если установлена одна из проблемных версий, обновите `mysqldump`:
   * с версии 5.7.41 — до [5.7.42](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-42.html) или более новой;
   * с версии 8.0.32 — до [8.0.33](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-33.html) или более новой.

В версиях 5.7.41 и 8.0.32 из-за [ошибки](https://bugs.mysql.com/bug.php?id=109685) параметр `--set-gtid-purged=OFF` работает некорректно, поэтому сперва следует обновить `mysqldump`.

Если после обновления `mysqldump` ошибка сохраняется, добавьте к команде параметр [`--set-gtid-purged=OFF`](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html#option_mysqldump_set-gtid-purged). Пример команды приведен в разделе [Создание дампа](../tutorials/data-migration/logical-dump-migration.md#dump).