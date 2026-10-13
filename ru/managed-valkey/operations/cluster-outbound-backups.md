---
title: Восстановление {{ mrd-short-name }} из резервной копии WAL-G
description: Следуя этой инструкции, вы сможете самостоятельно восстановить базу данных кластера {{ mrd-short-name }} из резервной копии WAL-G.
noIndex: true
---

# Восстановление {{ mrd-short-name }} из резервной копии WAL-G

Вы сможете восстановить данные кластера {{ mrd-short-name }} на пользовательской инфраструктуре из резервной копии, переданной в S3-бакет через WAL-G.

## Перед началом работы {before-you-begin}

Для выполнения инструкции вам потребуются:

1. {{ VLK }} и `valkey-cli`: Лучше использовать ту же полную версию, что и у исходного сервера; более старая версия не подходит. Версию можно посмотреть в метаданных резервной копии. Если использовались модули, например JSON, Search или Bloom, понадобятся их совместимые версии.
1. WAL-G: Бинарный файл wal-g-pg для {{ RD }}/{{ VLK }} (скачать можно со [страницы релизов](https://github.com/wal-g/wal-g/releases) WAL-G). Название бинарника и настроек `WALG_REDIS_*` сохраняется и для {{ VLK }}. Примеры ниже используют интерфейс WAL-G v3.0.9.
1. Ключ шифрования: Экспортированный из бакета ключ, используемый для защиты резервных копий.
1. Доступ к бакету: Статический ключ (идентификатор статического ключа доступа и значение секретного ключа доступа) с правами на чтение бакета.
1. Дисковое пространство: Свободное место на диске, достаточное для хранения данных в распакованном виде с учетом:
   * Размера самой базы данных;
   * Размера WAL-сегментов, которые будут восстанавливаться.

Команды ниже выполняются в bash от `root`. В примерах служба называется `valkey-server`, пользователь и группа — `valkey:valkey`, конфигурационный файл — `/etc/valkey/valkey.conf`, каталог данных — `/var/lib/valkey`. Если в вашей установке они отличаются, подставьте свои значения.

## Передаваемые данные {#data}

| Ресурс             | Содержимое                                                                                                    |
|--------------------|---------------------------------------------------------------------------------------------------------------|
| `basebackups_005/` | Резервные копии WAL-G: метаданные и все объекты данных. Нужна полная копия с сохранением структуры каталогов. |

У шардированного кластера резервные копии передаются отдельно для каждого шарда. Нужны копии всех шардов из одного набора резервных копий и соответствие каталогов исходным идентификаторам шардов.

## Восстановление базы данных {#restore}

1. Установите WAL-G. Скачайте `wal-g-redis` для своей ОС и архитектуры. Например, для Ubuntu 24.04 x86-64:

   ```bash
   curl -fL \
     https://github.com/wal-g/wal-g/releases/latest/download/wal-g-redis-24.04-amd64 \
     -o /tmp/wal-g-redis
   install -m 0755 /tmp/wal-g-redis /usr/local/bin/wal-g-redis
   wal-g-redis --version
   wal-g-redis backup-fetch --help
   ```

   В `backup-fetch` должны быть параметры `-t rdb|aof` и `--redis-version`. Версия WAL-G не связана с версией {{ VLK }}.

1. Добавьте ключ и настройте WAL-G:

   ```bash
   install -d -m 0700 /etc/wal-g-restore
   install -m 0600 /path/to/received-private-key.pgp /etc/wal-g-restore/private.pgp
   ```

   Создайте `/etc/wal-g-restore/wal-g.yaml`:

   ```yaml
   AWS_ACCESS_KEY_ID:       "<ID статического ключа>"
   AWS_SECRET_ACCESS_KEY:   "<секрет статического ключа>"
   AWS_ENDPOINT:           "https://storage.yandexcloud.net"  # или endpoint вашего S3
   AWS_REGION:             "ru-central1"
   AWS_S3_FORCE_PATH_STYLE: "true"
   WALG_S3_PREFIX:          "s3://<bucket>/<каталог, где лежит basebackups_005/>"

   WALG_PGP_KEY_PATH: "/etc/wal-g-restore/private.pgp"
   # WALG_PGP_KEY_PASSPHRASE: "<пароль>"  # только если ключ защищен паролем

   WALG_COMPRESSION_METHOD: "brotli"
   WALG_REDIS_DATA_PATH: "/var/lib/valkey"
   WALG_REDIS_APPENDONLY_PATH: "appendonlydir"
   WALG_REDIS_SERVER_PROCESS_NAME: "valkey-server"
   WALG_STREAM_RESTORE_COMMAND: "cat > /var/lib/valkey/dump.rdb"
   ```

   ```bash
   chmod 0600 /etc/wal-g-restore/wal-g.yaml
   export WALG_CONFIG=/etc/wal-g-restore/wal-g.yaml
   ```

`WALG_S3_PREFIX` указывает на родительский каталог `basebackups_005/`, а не на сам каталог или отдельный файл. Например, для объектов в `s3://customer-backups/valkey-export/shard-1/basebackups_005/` укажите `s3://customer-backups/valkey-export/shard-1`. Имя бакета и внешний префикс могут отличаться от исходных, структура объектов внутри должна сохраниться.

Для другого S3-хранилища замените endpoint, регион и при необходимости `AWS_S3_FORCE_PATH_STYLE`.

`brotli` — сжатие по умолчанию в сервисе MDB. Если резервная копия сжата другим алгоритмом, укажите его: эта настройка нужна для поиска карты слотов командой `backup-info --tag Slots`.

Импортировать ключ в GPG не нужно — WAL-G читает его из файла. Пароль исходного {{ VLK }} для скачивания резервной копии тоже не нужен.

1. Проверьте доступ и выберите резервную копию:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-list
   ```

   Выберите точное имя из списка и посмотрите метаданные:

   ```bash
   export BACKUP_NAME="aof_20261004T223158Z"
   wal-g-redis --config "$WALG_CONFIG" backup-info "$BACKUP_NAME"
   ```

   Пример сокращенного вывода:

   ```json
   [
     {
       "BackupName": "aof_20261004T223158Z",
       "StartLocalTime": "2026-10-04T22:31:58.891678Z",
       "FinishLocalTime": "2026-10-04T22:34:28.238213Z",
       "UserData": {
         "backup_id": "mdbmletglr2cuu7m51t5",
         "shard_name": "shard1"
       },
       "DataSize": 1257101930,
       "BackupSize": 209362565,
       "BackupType": "aof",
       "Version": "9.1.2",
       "UsedMemory": 6437938008,
       "UsedMemoryRss": 6463381504,
       "MaxDBNumber": 0
     }
   ]
   ```

   Из вывода понадобятся:

   * `BackupName` — имя для восстановления. Используйте его, а не `UserData.backup_id`.
   * `BackupType` — `rdb` или `aof`.
   * `Version` — версия исходного {{ VLK }}. Если поля нет, уточните версию у стороны, передавшей резервную копию.
   * `DataSize`, `BackupSize` — объем данных и копии в байтах. `UsedMemory` и `UsedMemoryRss` показывают потребление памяти исходным сервером, но не гарантируют такой же расход при восстановлении.
   * `MaxDBNumber` — максимальный номер непустой логической БД. Число БД в конфигурационном файле должно быть больше этого номера.

   `StartLocalTime` и `FinishLocalTime` — время создания копии, `UserData` — дополнительные сведения о копии и исходном шарде. Отдельное поле можно прочитать через `backup-info --tag`, например:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-info --tag Version "$BACKUP_NAME"
   ```

1. Подготовьте {{ VLK }}:

   Установите нужную версию из [публичных источников](https://valkey.io/topics/installation/). Если в исходном кластере использовались модули, установите их и подключите через `loadmodule` до загрузки данных.

   Проверьте версию бинарного файла, который запускает служба, и остановите сервер:

   ```bash
   valkey-server --version
   systemctl stop valkey-server
   systemctl is-active valkey-server
   ```

   Ожидаемый результат — `inactive` и ненулевой код возврата. Другие процессы {{ VLK }} тоже не должны использовать каталог восстановления. `backup-fetch` очищает каталог AOF, а также файлы `*.rdb` и `*.aof` в каталоге данных. Используйте отдельный каталог или заранее сохраните его прежнее содержимое, если оно еще нужно.

   ```bash
   install -d -o valkey -g valkey -m 0750 /var/lib/valkey
   ```

   В `/etc/valkey/valkey.conf` задайте:

   ```conf
   bind 127.0.0.1
   port 6379
   protected-mode yes
   requirepass "<новый пароль {{ VLK }}>"

   dir /var/lib/valkey
   dbfilename dump.rdb
   appenddirname appendonlydir
   appendfilename "appendonly.aof"
   aof-use-rdb-preamble yes
   appendfsync everysec

   # Для AOF-копии на шаге 5 замените на yes.
   appendonly no

   # Увеличьте, если MaxDBNumber >= 16.
   databases 16
   cluster-enabled no
   ```

   Параметры `systemd` и журналирования оставьте подходящими для вашей установки. `dir` должен совпадать с `WALG_REDIS_DATA_PATH`, `appenddirname` — с `WALG_REDIS_APPENDONLY_PATH`, а путь к RDB — с путем в `WALG_STREAM_RESTORE_COMMAND`.

   Пользователи, роли и настройки доступа не восстанавливаются из копии данных. Задайте новый пароль и введите его для локальных команд:

   ```bash
   read -r -s -p "Пароль нового экземпляра {{ VLK }}: " REDISCLI_AUTH
   export REDISCLI_AUTH
   ```

   `valkey-cli` использует переменную `REDISCLI_AUTH`, несмотря на ее название. В новой сессии введите пароль заново. Если настроены отдельные ACL-пользователи, добавляйте к командам `--user <имя>`.

1. Восстановите резервную копию. Выберите вариант по полю `BackupType`. {{ VLK }} должен быть остановлен; запускайте его только после успешного завершения `backup-fetch`.

  * Вариант А — RDB

      ```bash
      wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" -t rdb
      test -s /var/lib/valkey/dump.rdb
      chown -R valkey:valkey /var/lib/valkey
      ```

      При первом запуске в конфигурационном файле должно быть **`appendonly no`**, чтобы {{ VLK }} загрузил восстановленный `dump.rdb`, а не AOF.

      ```bash
      systemctl start valkey-server
      valkey-cli PING
      valkey-cli INFO persistence
      ```

      Дождитесь `PONG` и `loading:0`. Если загрузка не завершилась, посмотрите журнал:

      ```bash
      journalctl -u valkey-server -n 100 --no-pager
      ```

      Если дальше нужен AOF, включите его на уже загруженном сервере:

      ```bash
      valkey-cli CONFIG SET appendonly yes
      valkey-cli INFO persistence
      ```

      Дождитесь завершения создания AOF. В `INFO persistence` должны быть:

      ```text
      aof_enabled:1
      aof_rewrite_in_progress:0
      aof_rewrite_scheduled:0
      aof_last_bgrewrite_status:ok
      aof_last_write_status:ok
      ```

      После этого сохраните настройку:

      ```bash
      valkey-cli CONFIG REWRITE
      ```

      Если команда не может записать конфигурационный файл, вручную замените в нем `appendonly no` на `appendonly yes`. Не перезапускайте сервер с включенным AOF до успешного создания его файлов.

      Для работы только с RDB оставьте `appendonly no` и настройте расписание снимков.

  * Вариант Б — AOF

      Передайте полную версию **установленного {{ VLK }}** из `valkey-server --version`. Например:

      ```bash
      export TARGET_VERSION="9.1.2"
      wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" \
         -t aof --redis-version "$TARGET_VERSION"
      ```

      WAL-G восстановит многофайловый AOF в `/var/lib/valkey/appendonlydir`: manifest и перечисленные в нем файлы. Объединять части или переименовывать их не нужно.

      ```bash
      ls -lah /var/lib/valkey/appendonlydir
      chown -R valkey:valkey /var/lib/valkey
     ```

     В `/etc/valkey/valkey.conf` включите AOF:

     ```conf
     appendonly yes
     ```

   Запустите сервер:

   ```bash
   systemctl start valkey-server
   valkey-cli PING
   valkey-cli INFO persistence
   journalctl -u valkey-server -n 100 --no-pager
   ```

   Дождитесь `PONG`, `loading:0` и `aof_enabled:1`. В журнале не должно быть ошибок чтения manifest, загрузки или усечения AOF.

1. Проверьте данные и настройте доступ

   ```bash
   valkey-cli INFO keyspace
   ```

   Проверьте список логических БД и несколько известных ключей: типы, значения, работу приложения. Для БД, отличной от DB 0, используйте `valkey-cli -n <номер>`. В журнале не должно быть ошибок чтения данных, отсутствующих модулей или нехватки памяти.

   Ключи, у которых к моменту восстановления истек TTL, могут отсутствовать: восстановление не начинает срок их жизни заново. Поэтому число ключей может отличаться от числа на момент создания резервной копии.

   Перед подключением приложения настройте пользователей и ACL, `bind`, TLS и файрвол под свою сеть. Используйте новые учетные данные.

## Восстановление шардированного кластера {#sharded-cluster}

Каждый исходный шард восстанавливается на отдельный новый мастер со **своими исходными слотами**. Сначала нужно собрать пустой кластер с нужным распределением слотов, затем остановить его, восстановить данные и запустить снова.

1. Выберите копии и получите карту слотов

   Для каждого шарда подготовьте WAL-G по шагам 1–3: свой `WALG_S3_PREFIX` и точное имя резервной копии. Выберите копии из одного набора резервных копий. Независимый выбор `LATEST` для каждого шарда может дать разные наборы.

   Запишите соответствие исходных шардов новым серверам. Например:

   | Исходный ID шарда | S3-префикс | `BackupName` | Новый сервер |
   | --- | --- | --- | --- |
   | `<source-shard-id-1>` | `s3://.../shard-1` | `<backup-name-1>` | `10.0.0.11` |
   | `<source-shard-id-2>` | `s3://.../shard-2` | `<backup-name-2>` | `10.0.0.12` |
   | `<source-shard-id-3>` | `s3://.../shard-3` | `<backup-name-3>` | `10.0.0.13` |

   Прочитайте `BackupType` и `Version` каждой резервной копии и отдельно извлеките карту слотов:

   ```bash
   wal-g-redis --config "$WALG_CONFIG" backup-info --tag Slots "$BACKUP_NAME"
   ```

   Пример:

   ```json
   {
     "source-shard-id-1": [["0", "5460"]],
     "source-shard-id-2": [["5461", "10922"]],
     "source-shard-id-3": [["10923", "16383"]]
   }
   ```

   Ключи — исходные идентификаторы шардов, а не Node ID новых серверов и не обязательно `UserData.shard_name`. Сопоставьте их с каталогами по сведениям, переданным вместе с копией. Обычный `backup-info` карту слотов не выводит.

   У шарда может быть несколько несмежных интервалов; обе границы включаются. Одиночный слот — пара одинаковых чисел. Если значение равно `null`, у шарда нет назначенных слотов и команду их назначения нужно пропустить.

   Карты выбранных резервных копий должны согласовываться, а все диапазоны вместе — покрывать `0–16383` без пропусков и пересечений.

   Если карта не читается, проверьте префикс, имя копии, полноту копии и `WALG_COMPRESSION_METHOD`. Если карты нет или потеряно соответствие каталогов исходным ID, запросите эти сведения у стороны, передавшей копию.

   {% note warning %}

   Не заменяйте исходную карту равномерным разбиением и не назначайте слоты через автоматическое `valkey-cli --cluster create`: полученное распределение может не соответствовать данным в 

   {% endnote %}

1. Подготовьте пустые узлы

   На каждом сервере установите {{ VLK }} нужной версии и модули, подготовьте конфигурационный файл и каталог данных. Каталоги должны быть новыми, без старых данных и чужого `nodes.conf`.

   В конфигурационном файле замените параметры сети и кластерного режима. Пример для первого сервера:

   ```conf
   bind 127.0.0.1 10.0.0.11
   cluster-enabled yes
   cluster-config-file /var/lib/valkey/nodes.conf
   cluster-node-timeout 15000
   cluster-require-full-coverage yes
   cluster-announce-ip 10.0.0.11
   cluster-announce-port 6379
   cluster-announce-bus-port 16379
 
   # Пока создается пустой кластер — для обоих типов копий.
   appendonly no
   databases 1
   ```

   На остальных серверах подставьте их собственные IP. Разрешите узлам соединяться друг с другом по портам `6379` и `16379`. Задайте `requirepass` и `REDISCLI_AUTH`, как на шаге 4. До окончания восстановления приложение не должно писать в кластер.

   В {{ VLK }} 9.0+ число БД в кластерном режиме задает `cluster-databases`: для обычного кластера с DB 0 добавьте `cluster-databases 1`, а если `MaxDBNumber` больше нуля — задайте число больше этого номера. В {{ VLK }} 7.2/8.x этого параметра нет.

   Запустите пустые серверы:

   ```bash
   systemctl start valkey-server
   valkey-cli CLUSTER NODES
   ```

   На каждом узле пока должна быть только собственная запись без слотов.

1. Назначьте слоты и объедините узлы:

   До объединения задайте каждому узлу уникальный положительный config epoch и назначьте диапазоны из карты `Slots`.

   Для карты из примера на первом сервере:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 1
   valkey-cli CLUSTER ADDSLOTSRANGE 0 5460
   ```

   На втором сервере:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 2
   valkey-cli CLUSTER ADDSLOTSRANGE 5461 10922
   ```

   На третьем:

   ```bash
   valkey-cli CLUSTER SET-CONFIG-EPOCH 3
   valkey-cli CLUSTER ADDSLOTSRANGE 10923 16383
   ```

   Используйте фактические диапазоны своей копии. Несколько интервалов можно передать одной командой, например `CLUSTER ADDSLOTSRANGE 0 100 500 700`.

   С первого сервера познакомьте узлы друг с другом:

   ```bash
   valkey-cli CLUSTER MEET 10.0.0.12 6379
   valkey-cli CLUSTER MEET 10.0.0.13 6379
   ```

   Дождитесь обмена топологией. На каждом сервере проверьте и сохраните ее:

   ```bash
   valkey-cli CLUSTER NODES
   valkey-cli CLUSTER INFO
   valkey-cli CLUSTER SAVECONFIG
   ```

   Должны появиться все узлы с исходными диапазонами, `cluster_state:ok`, `cluster_slots_assigned:16384` и `cluster_slots_ok:16384`.

   Остановите службу на всех серверах:

   ```bash
   systemctl stop valkey-server
   systemctl is-active valkey-server
   ```

   Сохраните созданные `/var/lib/valkey/nodes.conf`: они содержат новую топологию. Не удаляйте их при восстановлении и не заменяйте файлами исходного кластера.

1. Восстановите данные шардов:

   На каждом остановленном узле укажите его `WALG_CONFIG` и `BACKUP_NAME`. Для AOF также задайте `TARGET_VERSION` — полную версию установленного {{ VLK }}.

   Выполните одну команду по типу резервной копии:

   ```bash
   # RDB:
   wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" -t rdb

   # Или AOF:
   wal-g-redis --config "$WALG_CONFIG" backup-fetch "$BACKUP_NAME" \
     -t aof --redis-version "$TARGET_VERSION"
   ```

   После успешного завершения проверьте восстановленные файлы, как на шаге 5, и исправьте владельца:

   ```bash
   chown -R valkey:valkey /var/lib/valkey
   ```

   В конфигурационном файле установите `appendonly no` для RDB или `appendonly yes` для AOF. Кластерные параметры и `nodes.conf` должны сохраниться.

   Когда восстановлены файлы всех шардов, запустите службы:

   ```bash
   systemctl start valkey-server
   ```

   После RDB-восстановления при необходимости включите AOF в порядке, описанном на шаге 5: сначала загрузка RDB, затем создание AOF и сохранение настройки. Пока запускаются остальные узлы и идет обмен топологией, возможно временное `cluster_state:fail`.

1. Проверьте кластер:

   На каждом сервере выполните:

   ```bash
   valkey-cli PING
   valkey-cli INFO persistence
   valkey-cli INFO keyspace
   valkey-cli CLUSTER INFO
   valkey-cli CLUSTER NODES
   journalctl -u valkey-server -n 100 --no-pager
   ```

   Проверьте, что:

   * Все узлы загрузили данные (`loading:0`), в журналах нет ошибок чтения данных или модулей.
   * Состояние на всех узлах — `cluster_state:ok`, `cluster_slots_assigned:16384`, `cluster_slots_ok:16384`, `cluster_slots_fail:0` и `cluster_slots_pfail:0`.
   * Каждый шард попал на нужный сервер, его диапазоны совпадают с `Slots`. Нет незавершенных migrating/importing-слотов и узлов с флагами `fail`/`fail?`.
   * Известные ключи читаются через клиент с поддержкой кластера. Для CLI используйте `valkey-cli -c`.

После проверки настройте доступ и подключайте приложение. Клиенту нужны новые учетные данные и сетевой доступ к адресам, объявляемым всеми узлами.

## Если восстановление не получилось {#troubleshooting} 

| Симптом | Что проверить                                                                                  |
| --- |------------------------------------------------------------------------------------------------|
| `backup-list` пуст | Префикс должен указывать на родителя `basebackups_005/`. Проверьте endpoint, бакет и права S3. |
| S3 возвращает `AccessDenied` | Ключи, права перечисления и чтения, регион и параметры адресации S3.                           |
| Ошибка расшифровки | Приватный PGP-ключ и его парольную фразу, если она задана.                                     |
| `backup-info --tag Slots` не находит объект | Полноту копии, наличие карты в исходной резервной копии и `WALG_COMPRESSION_METHOD`.           |
| WAL-G сообщает о несовместимой версии при восстановлении AOF | В `--redis-version` должна быть версия установленного {{ VLK }}, не старее исходного.          |
| После восстановления RDB база пустая или загружены другие данные | Каталог данных, `dbfilename` и первый запуск с `appendonly no`.                                |
| В ошибке RDB/AOF упоминается неизвестный тип модуля или команда | Установлены ли совместимые модули исходного кластера и подключены ли они через `loadmodule`.   |
| {{ VLK }} не может открыть файлы | Владельца, права и совпадение путей в конфигурационных файлах WAL-G и {{ VLK }}.               |
| `CLUSTERDOWN` после запуска всех узлов | Сеть, объявляемые адреса, карту слотов, `nodes.conf` и загрузку каждого шарда.                 |
| Ключей меньше ожидаемого | Выбор резервной копии, наличие всех шардов и БД, истекшие TTL и журнал загрузки.               |

После ошибки скачивания или загрузки исправьте причину и повторите восстановление при остановленном сервере. Частично созданные файлы не означают, что восстановление из копии произошло.