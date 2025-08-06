#### Как перенести данные в кластер? {#to-cluster}

Воспользуйтесь инструкцией в разделе [{#T}](../../managed-mysql/tutorials/data-migration.md).

#### Как перенести кластер в другой каталог или облако? {#to-folder-cloud}

Чтобы перенести кластер:
* В другой каталог — [восстановите кластер из резервной копии](../../managed-mysql/operations/cluster-backups.md#restore). При задании параметров нового кластера укажите нужный каталог.
* В другое облако — воспользуйтесь инструкцией в разделе [{#T}](../../managed-mysql/tutorials/data-migration.md).

#### Ошибка при внешней репликации {#external-replication-error}

Текст ошибки:

```text
Last\_IO\_Error: 
Got fatal error 1236 from source when reading data from binary log: 
'Could not find first log file name in binary log index file'
```

Ошибка может возникать в ходе внешней репликации с использованием [особого FQDN хоста-мастера](../../managed-mysql/operations/connect.md#fqdn-master), если в кластере-источнике сменился хост-мастер.

**Решение:**

1. Запустите репликацию повторно.
1. Однократно выполните команду:

   ```sql
   STOP SLAVE;
   CHANGE MASTER TO MASTER_AUTO_POSITION = 1;
   START SLAVE;
   ```

При смене мастера в кластере-источнике репликация будет перенастроена на новый хост-мастер. Подробнее о настройке см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/change-master-to.html).
