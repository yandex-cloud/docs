---
title: Восстановление Greenplum из резервной копии WAL-G
description: Следуя этой инструкции, вы сможете самостоятельно восстановить базу данных {{ GP }} из резервной копии WAL-G.
noIndex: true
---

Вы сможете восстановить данные кластера {{ mgp-full-name }} на пользовательской инфраструктуре из резервной копии, переданной в S3-бакет через утилиту WAL-G.

## Перед началом работы {before-you-begin}

Для выполнения инструкции вам потребуются:

1. Виртуальная инфраструктура: Развернуты виртуальные машины, каждому из которых присвоено соответствующее FQDN-имя.
1. Операционная система: На узлах установлена ОС из списка совместимых с {{ GP }} (рекомендуется Ubuntu 24.04).
1. Сетевой доступ: На всех узлах кластера настроен вход по SSH без пароля (passwordless) для пользователя `gpadmin`. 
1. WAL-G: Бинарный файл [wal-g](https://github.com/wal-g/wal-g/releases/) установлен на все хосты кластера.
1. Дисковое пространство: Свободное место на диске, достаточное для хранения данных в распакованном виде с учетом:
   * Размера самой базы данных;
   * Размера WAL-сегментов, которые будут восстанавливаться.


## Подготовка окружения на хостах кластера {#prepare-env}

Выполните этот шаг выполняется на всех узлах кластера.

1. Создайте структуру каталогов для данных {{ GP }} и конфигурационных файлов WAL-G.

   ```bash
   # Создаем каталог для данных
   mkdir -p /var/lib/greenplum/data1
   chown gpadmin:gpadmin -R /var/lib/greenplum/

   # Создаем каталог для конфигурационных файлов wal-g
   sudo mkdir -p /etc/wal-g
    ```
1. Настройте файл конфигурации WAL-G. Создайте файл `/etc/wal-g/wal-g.yaml` на каждом хосте:

   ```yaml
   # /etc/wal-g/wal-g.yaml
   WALG_COMPRESSION_METHOD: "brotli"
   PGUSER: "gpadmin"
   PGDATABASE: "postgres"
   PGPASSFILE: "/home/gpadmin/.pgpass"
   S3_DISABLE_100_CONTINUE: "true"

   # Настройки S3
   AWS_ENDPOINT: "<ваше_s3_хранилище>"
   AWS_S3_FORCE_PATH_STYLE: true

   # Шифрование
   WALG_PGP_KEY_PATH: "/etc/wal-g/PGP_KEY"

   # Локальные параметры
   PGHOST: "localhost"
   WALG_GP_LOGS_DIR: "/var/log/wal-g/"

   # Путь к резервным копиям в бакете
   WALE_S3_PREFIX: "s3://<путь_в_бакете_пользователя>"

   # Статический ключ для доступа к S3
   AWS_ACCESS_KEY_ID: "<идентификатор_статического_ключа>"
   AWS_SECRET_ACCESS_KEY: "<значение_секретного_ключа_доступа>"
   ```

1. Скопируйте файл приватного PGP-ключа, полученного от {{ mgp-short-name }}, в указанное место в файле конфигурации `/etc/wal-g/PGP_KEY`. Убедитесь, что права доступа строгие (`chmod 600 /etc/wal-g/PGP_KEY`).

## Настройка конфигурации восстановления {#restore-config}

Этот файл нужен для понимания WAL-G, как распределять сегменты по новым хостам.

Создайте файл конфигурации `/etc/wal-g/wal-g-restore-config.yaml` на мастер-узле (достаточно сделать на одном хосте, где будете запускать команду `backup-fetch`, но удобнее иметь на всех или передавать файл).

Пример структуры (Замените `FQDN.example.com` на реальные адреса ваших новых виртуальных машин):
Пути `data_dir` должны соответствовать тем, что будут указаны в `master_data_directory` или `datadirs` при запуске кластера.

   ```json
   {
       "segments": {
           "-1": {
               "hostname": "MASTER-FQDN.EXAMPLE.COM",
               "port": 5432,
               "data_dir": "/var/lib/greenplum/data1/master/gpseg-1"
           },
           "0": {
               "hostname": "NODE1-FQDN.EXAMPLE.COM",
               "port": 6000,
               "data_dir": "/var/lib/greenplum/data1/primary/gpseg0"
           },
           "1": {
               "hostname": "NODE2-FQDN.EXAMPLE.COM",
               "port": 6001,
               "data_dir": "/var/lib/greenplum/data1/primary/gpseg1"
           }
       }
   }
   ```

Опишите все сегменты кластера.

# Подготовка каталогов данных {#prepare-folder}

Очистите каталоги данных, если в них есть данные или данные от предыдущих попыток.

Выполните на мастер-узле от имени пользователя `gpadmin`.

   ```bash
   # Создаем базовые каталоги
   mkdir -p /var/lib/greenplum/data1
   chown gpadmin:gpadmin -R /var/lib/greenplum/

   # Удаление старые данные (внимание! это необратимо)
   # Убедитесь, что /home/gpadmin/gpconfigs/cluster содержит список хостов для gpssh
   gpssh -f /home/gpadmin/gpconfigs/cluster -v -e <<EOF
   rm -rf /var/lib/greenplum/data1/master/gpseg-1
   rm -rf /var/lib/greenplum/data1/primary/gpseg*
   rm -rf /var/lib/greenplum/data1/mirror/gpseg*
   ```

## Восстановление базы данных {#restore-db}

Запустите восстановление. Выполните на мастер-узле от имени пользователя `gpadmin`:

   ```bash
   wal-g backup-fetch \
        LATEST \
        --config /etc/wal-g/wal-g.yaml \
        --restore-config /etc/wal-g/wal-g-restore-config.yaml \
        && echo "Backup extracted - OK"
   ```

   `LATEST` восстанавливает последнюю доступную копию. Можно указать конкретное имя резервной копии (например, `base_0000000100000001_...`), получив его через `wal-g backup-list`. Процесс может занимать много времени (в зависимости от размера БД и скорости сети). Следите за логами в `/var/log/wal-g/`.

## Запуск кластера {#start-cluster}

После извлечения файлов необходимо привести каталоги данных к работоспособному состоянию для нового хост-имена.

1. Обновите `gp_segment_configuration`

   ```bash
    gpstart -m
    PGOPTIONS='-c gp_session_role=utility' psql
    
    SET allow_system_table_mods=TRUE;
    
    #for mirror:
    DELETE FROM gp_segment_configuration WHERE content=-1 AND role='m';
    
     dbid | content | role | preferred_role | mode | status | port |                      hostname                      |                      address                       |                 datadir
    ------+---------+------+----------------+------+--------+------+----------------------------------------------------+----------------------------------------------------+-----------------------------------------
        1 |      -1 | p    | p              | n    | u      | 5432 | rc1a-kikir00imn9ad658.example.com | rc1a-kikir00imn9ad658.example.com | /var/lib/greenplum/data1/master/gpseg-1
        2 |       0 | m    | m              | s    | u      | 7000 | rc1a-5rv6arelmrk6dg4a.example.com | rc1a-5rv6arelmrk6dg4a.example.com | /var/lib/greenplum/data1/mirror/gpseg0
        3 |       1 | m    | m              | s    | u      | 7001 | rc1a-5rv6arelmrk6dg4a.example.com | rc1a-5rv6arelmrk6dg4a.example.com | /var/lib/greenplum/data1/mirror/gpseg1
        6 |       0 | p    | p              | s    | u      | 6000 | rc1a-njp0qmtv4keaea1g.example.com | rc1a-njp0qmtv4keaea1g.example.com | /var/lib/greenplum/data1/primary/gpseg0
        7 |       1 | p    | p              | s    | u      | 6001 | rc1a-njp0qmtv4keaea1g.example.com | rc1a-njp0qmtv4keaea1g.example.com | /var/lib/greenplum/data1/primary/gpseg1
    
    # master:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com',
        port=6000,
        datadir='/var/lib/greenplum/data1/master/gpseg-1',
        status='u',
        mode='n'
        WHERE content=-1 and role='p';
    
    # for each primary segment:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com', 
        port=6000,
        datadir='/var/lib/greenplum/data1/primary/gpseg0',
        status='u',
        mode='n'
        WHERE content=0 and role='p';
    
    # for each mirror:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com', 
        port=7000,
        datadir='/var/lib/greenplum/data1/mirror/gpseg0',
        status='d',
        mode='n'
        WHERE content=0 and role='m';
      
       
     dbid | content | role | preferred_role | mode | status | port |                      hostname                      |                      address                       |                 datadir
    ------+---------+------+----------------+------+--------+------+----------------------------------------------------+----------------------------------------------------+-----------------------------------------
        1 |      -1 | p    | p              | n    | u      | 5432 | rc1a-kikir00imn9ad658.example.com | rc1a-kikir00imn9ad658.example.com | /var/lib/greenplum/data1/master/gpseg-1
        6 |       0 | p    | p              | n    | u      | 6000 | rc1a-pso773ul1684qlv2.example.com | rc1a-pso773ul1684qlv2.example.com | /var/lib/greenplum/data1/primary/gpseg0
        7 |       1 | p    | p              | n    | u      | 6001 | rc1a-pso773ul1684qlv2.example.com | rc1a-pso773ul1684qlv2.example.com | /var/lib/greenplum/data1/primary/gpseg1
        2 |       0 | m    | m              | n    | d      | 7000 | rc1a-3i4qd1ltdv98gqqh.example.com | rc1a-3i4qd1ltdv98gqqh.example.com | /var/lib/greenplum/data1/primary/gpseg2
        3 |       1 | m    | m              | n    | d      | 7001 | rc1a-3i4qd1ltdv98gqqh.example.com | rc1a-3i4qd1ltdv98gqqh.example.com | /var/lib/greenplum/data1/primary/gpseg3
    
    gpstop -a
    ```

1. Запустите кластер:

   ```bash
   service greenplum start
   ```

   Подключитесь к мастеру:

   ```bash
   psql -u gpadmin -W
   ```

1. Проверьте корректность работы:

   ```sql
   SELECT * FROM mdb_toolkit.can_write();
   ```

   Ожидаемый результат:

   ```sql
    can_write 
    -----------
         t
   ```

## Восстановление зеркал (Mirrors) {#restore-mirror}

Если в вашем кластере предусмотрены зеркала, их нужно восстановить или пересоздать. Убедитесь, что в `gp_segment_configuration`  указаны правильные FQDN и пути к данным зеркал.


Выполните восстановление зеркал:

   ```bash
   gprecoverseg -F
   ```

После завершения `gprecoverseg` проверьте статус командой `gpstate -e`. Все сегменты должны быть в статусе `m` (mirror online) или `p` (primary online, если зеркало не назначено).
