# Устранение ошибки `Access denied` при сохранении SQL-дампа базы при помощи утилиты mysqldump из кластера {{ mmy-name }}  


## Описание проблемы {#issue-description}

При попытке выгрузить дамп средствами mysqldump возникает ошибка:
```
mysqldump: Couldn't execute 'FLUSH TABLES': Access denied; 
you need (at least one of) the RELOAD or FLUSH_TABLES privilege(s) for this operation (1227)
 ```

## Решение {#issue-resolution}

В некоторых выпусках утилиты mysqldump, начиная с версии 8.0.32, присутствует [подтвержденный разработчиками баг](https://bugs.mysql.com/bug.php?id=109685): опция `--single-transaction` использует команду `FLUSH TABLES WITH READ LOCK`, даже если не указать в параметрах запуска утилиты ключи `--flush-logs` или `--source-data`.

Для исправления этой ошибки обновите утилиту mysqldump до версии 8.0.33 или более новой.