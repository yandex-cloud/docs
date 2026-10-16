---
title: Восстановление MongoDB из резервной копии {{ mmg-full-name }} с помощью WAL-G
description: Следуя этой инструкции, вы сможете самостоятельно восстановить MongoDB из резервной копии WAL-G, полученной из {{ mmg-name }}.
noIndex: true
---

# Восстановление MongoDB из резервной копии WAL-G

Если вы получили резервную копию кластера {{ mmg-name }} в виде каталога WAL-G из S3, вы можете восстановить данные на собственном сервере MongoDB. Для восстановления не требуются {{ yandex-cloud }} и {{ mmg-name }}: достаточно доступа к резервной копии, ключа шифрования и установленных MongoDB и WAL-G.

## Передаваемые данные {#data}

#|
|| **Ресурс** | **Содержимое** ||
|| `basebackups_005/` | Резервные копии: бинарные (`binary_<время>`) или логические (`stream_<время>`, для старых кластеров). Каждая копия самодостаточна и не требует цепочки предыдущих копий. ||
|| `oplog_005/` | Архив журнала операций `oplog`, необходимый для восстановления на заданный момент времени (Point-in-Time-Recovery, PITR). ||
|#

Для шардированного кластера такой набор нужен отдельно для набора реплик серверов конфигурации (`config server replica set`) и каждого шарда с данными.

## Перед началом работы {#before-you-begin}

Для выполнения инструкции вам потребуются:

* MongoDB той же мажорной версии, что и исходный кластер. Используйте [Percona Server for MongoDB](https://docs.percona.com/percona-server-for-mongodb/8.0/install/index.html), так как {{ mmg-name }} использует сборку на базе Percona.
* Бинарный файл WAL-G для MongoDB (`wal-g-mongo`) со [страницы релизов](https://github.com/wal-g/wal-g/releases), соответствующий ОС и архитектуре сервера.
* Ключ шифрования.
* Если копия находится в S3 — статический ключ доступа с правами на чтение бакета: идентификатор и секретный ключ. Если копия уже скачана на диск, доступ к S3 не нужен.
* Свободное место на диске под полный размер распакованных данных с запасом. Метаданные копии можно посмотреть командой `backup-show` на этапе [выбора копии](#select-backup).

Основная инструкция описывает восстановление бинарной копии нешардированного кластера в набор реплик с одним хостом. Для [шардированного кластера](#sharded-cluster) и [логической копии](#logical-backup) используйте отдельные разделы.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Восстановление базы данных {#restore}

### Установите MongoDB и WAL-G {#install}

1. Установите Percona Server for MongoDB. Например, для версии `8.0` на Debian или Ubuntu:

   ```bash
   wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
   sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
   sudo percona-release enable psmdb-80 release
   sudo apt update && sudo apt install -y percona-server-mongodb
   sudo systemctl stop mongod
   ```

   Для другой версии выберите соответствующий репозиторий Percona, например `psmdb-70` для MongoDB `7.0`.

1. Скачайте архив WAL-G для MongoDB со [страницы релизов](https://github.com/wal-g/wal-g/releases). Распакуйте и установите бинарный файл:

   ```bash
   tar -xzf <архив_WAL-G>
   sudo install -m 755 <бинарный_файл_WAL-G> /usr/local/bin/wal-g-mongo
   wal-g-mongo --version
   ```

   Где `<архив_WAL-G>` имеет формат `wal-g-mongo-*.tar.gz`, а `<бинарный_файл_WAL-G>` — `wal-g-mongo-*-amd64`.

### Настройте WAL-G {#configure-wal-g}

1. Создайте каталоги для конфигурации и логов, затем скопируйте ключ шифрования:

   ```bash
   sudo mkdir -p /etc/wal-g /var/log/wal-g
   sudo cp GPG_KEY /etc/wal-g/GPG_KEY
   sudo chmod 600 /etc/wal-g/GPG_KEY
   ```

1. Создайте файл `/etc/wal-g/wal-g.yaml` с параметрами в зависимости от того, где находится резервная копия:

   {% list tabs %}

   - Копия в S3

     ```yaml
     AWS_ACCESS_KEY_ID: <идентификатор_статического_ключа>
     AWS_SECRET_ACCESS_KEY: <секретный_ключ>
     AWS_ENDPOINT: https://storage.yandexcloud.net
     AWS_REGION: ru-central1
     AWS_S3_FORCE_PATH_STYLE: true
     WALG_S3_PREFIX: s3://<имя_бакета>/<префикс_копии>
     WALG_PGP_KEY_PATH: /etc/wal-g/GPG_KEY
     ```

     В `WALG_S3_PREFIX` укажите каталог, внутри которого находятся `basebackups_005/` и `oplog_005/`. Для стороннего S3-хранилища замените эндпоинт и регион на его значения.

   - Копия на диске

     ```yaml
     WALG_FILE_PREFIX: /data/backup/<каталог_копии>
     WALG_PGP_KEY_PATH: /etc/wal-g/GPG_KEY
     ```

     В `WALG_FILE_PREFIX` укажите локальный каталог, внутри которого находятся `basebackups_005/` и `oplog_005/`.

   {% endlist %}

   Если PGP-ключ защищен паролем, добавьте параметр `WALG_PGP_KEY_PASSPHRASE` с этим паролем.

   Для восстановления на заданный момент времени (Point-in-Time Recovery, PITR) на шаге [Восстановите бинарную копию](#restore-binary) добавьте в файл `/etc/wal-g/wal-g.yaml` настройку обработки ошибок повторного применения операций:

   ```yaml
   OPLOG_REPLAY_IGNORE_ERROR_CODES: '{"u": [11000, 11001, 12582, 16460], "i": [11000, 11001, 12582, 16460]}'
   ```

   Метод сжатия указывать не нужно: он требуется только при создании копии.

1. Ограничьте доступ к конфигурации:

   ```bash
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

### Выберите резервную копию {#select-backup}

1. Проверьте доступ к хранилищу:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-list
   ```

   Если команда вернула список копий, доступ к хранилищу и путь в конфигурации настроены правильно. Имена бинарных копий начинаются с `binary_`, например `binary_20260407T222057Z`. Если имена начинаются с `stream_`, перейдите к [восстановлению логической копии](#logical-backup).

1. Выберите копию, созданную до момента времени, на который нужно восстановить состояние кластера, и получите ее метаданные:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-show <имя_копии>
   ```

   Проверьте версию исходного кластера в `MongoMeta.Version` и размер данных. Для PITR также используется `MongoMeta.BackupLastTS` — момент, на который копия согласована.

1. Проверьте целостность резервной копии:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Запустите скрипт:

      ```bash
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      При необходимости укажите директорию:

      ```bash
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # проверяет копии
      WAL_G_BIN=wal-g-mongo ./s3_test_script.sh */etc/wal-g/wal-g.yaml* oplog_005 # проверяет архив журнала операций
      ```

      Пример вывода:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:

### Подготовьте конфигурацию MongoDB {#configure-mongodb}

1. Отредактируйте `/etc/mongod.conf`:

   ```yaml
   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy

   net:
     port: 27017
     bindIp: 127.0.0.1

   replication:
     replSetName: rs01
   ```

   Настройки хранилища должны соответствовать исходному кластеру. В примере используется `directoryPerDB: true` и сжатие `snappy`; если в исходном кластере задан другой `blockCompressor`, укажите его значение.

   До настройки аутентификации оставьте доступ только через локальный интерфейс. Имя хоста, которое вы укажете в `--mongo-rs-members`, должно разрешаться на этом сервере в доступный для `mongod` адрес.

1. Создайте минимальную конфигурацию `/etc/wal-g/mongod-minimal.conf`, с которой WAL-G будет запускать временный процесс `mongod`:

   ```yaml
   systemLog:
     destination: file
     path: /var/log/wal-g/mongod-restore.log
     logAppend: true

   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy
   ```

   Значения `dbPath`, `directoryPerDB` и `blockCompressor` должны совпадать в обоих файлах.

### Восстановите бинарную копию {#restore-binary}

{% note warning %}

WAL-G удаляет прежнее содержимое каталога `dbPath`. Если данные нужны, сохраните их отдельно до запуска восстановления. Во время восстановления MongoDB должна быть остановлена.

{% endnote %}

1. Остановите MongoDB:

   ```bash
   sudo systemctl stop mongod
   ```

1. Выполните восстановление. Вместо имени копии можно указать `LATEST`, чтобы выбрать последнюю копию. Укажите мажорную версию исходного кластера, например `8.0`.

   {% list tabs %}

   - На момент создания копии

     ```bash
     sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
       <имя_копии_или_LATEST> /etc/mongod.conf <мажорная_версия> \
       --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
       --mongo-rs-name rs01 \
       --mongo-rs-members "$(hostname -f):27017" \
       2>&1 | sudo tee /var/log/wal-g/restore.log
     ```

   - На заданный момент времени

     ```bash
     sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
       <имя_копии_или_LATEST> /etc/mongod.conf <мажорная_версия> \
       --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
       --mongo-rs-name rs01 \
       --mongo-rs-members "$(hostname -f):27017" \
       --pitr-since LATEST_ON_REPLICA \
       --pitr-until <целевой_момент> \
       2>&1 | sudo tee /var/log/wal-g/restore.log
     ```

     Где `<целевой_момент>` — момент времени, на который нужно восстановить состояние кластера, в формате `<секунды_Unix>.<инкремент>`, например `1760086800.1`.

     Для PITR нужен непрерывный архив `oplog_005/` от выбранной копии до момента времени, на который нужно восстановить состояние кластера. Имена файлов архива имеют вид `oplog_<начало>_<конец>.*`.

     `LATEST_ON_REPLICA` выбирает начальную точку по последней записи `local.oplog.rs` восстановленной копии. Вместо него можно передать `MongoMeta.BackupLastTS` из `backup-show`: `<T>.<I>`, где `T` — секунды Unix, `I` — инкремент.

     Чтобы получить число секунд Unix для `10 октября 2026 года, 12:00:00` по московскому времени, выполните на Linux:

     ```bash
     date -d '2026-10-10 12:00:00+03' +%s
     ```

     Команда вернет `1791622800`. Добавьте к результату `.1`, чтобы получить `1791622800.1`. Конечная граница не включается: операция, соответствующая значению `--pitr-until`, не применяется.

     Для восстановления до конца доступного архива укажите `--pitr-until LATEST`.

   {% endlist %}

   WAL-G проверит совместимость версии и отсутствие запущенного `mongod`, скачает, расшифрует и распакует данные. Затем запустит временный `mongod`, изменит конфигурацию набора реплик и при необходимости применит `oplog`. После завершения WAL-G остановит временный процесс.

   Параллельность скачивания регулируется параметром `WALG_DOWNLOAD_CONCURRENCY` в конфигурации WAL-G.

### Запустите MongoDB {#start-mongodb}

1. Определите пользователя и группу сервиса:

   ```bash
   systemctl show mongod --property=User --property=Group
   ```

   У Percona сервис обычно работает от пользователя `mongod`, у пакетов MongoDB для Debian или Ubuntu — от `mongodb`. Если `Group` не задана, используйте основную группу пользователя сервиса, которую можно узнать командой `id -gn <пользователь>`.

1. Исправьте владельца восстановленных файлов и запустите сервис:

   ```bash
   sudo chown -R <пользователь>:<группа> /var/lib/mongodb
   sudo systemctl start mongod
   mongosh --port 27017 --eval 'rs.status().members.map(m => [m.name, m.stateStr])'
   ```

   Дождитесь состояния `PRIMARY`. Если хост не переходит в него, проверьте конфигурацию и логи:

   ```bash
   mongosh --port 27017 --eval 'rs.conf()'
   sudo journalctl -u mongod --no-pager -n 200
   ```

   Имя хоста из `--mongo-rs-members` должно разрешаться локально и совпадать с адресом в `rs.conf()`.

   Не выполняйте `rs.initiate()` автоматически: WAL-G уже восстанавливает конфигурацию набора реплик. Команда допустима, только если вы убедились, что конфигурация набора реплик отсутствует.

### Настройте пользователей и доступ {#configure-access}

Пользователи и хеши паролей восстанавливаются вместе с данными, поэтому пароли пользователей приложения сохраняются. Пароли служебных пользователей исходного кластера не передаются: создайте собственного администратора.

1. Пока авторизация отключена, создайте администратора:

   ```javascript
   db.getSiblingDB("admin").createUser({user: "root", pwd: passwordPrompt(), roles: ["root"]})
   ```

1. Просмотрите список пользователей:

   ```javascript
   db.getSiblingDB("admin").system.users.find({}, {user: 1, db: 1, roles: 1})
   ```

   Удалите ненужных служебных пользователей исходного кластера:

   ```javascript
   db.getSiblingDB("admin").dropUser("<имя>")
   ```

   Служебная база `mdb_internal` на новом сервере не нужна.

1. Выйдите из `mongosh` и создайте ключ для внутренней аутентификации набора реплик. Он нужен и для набора с одним хостом:

   ```bash
   sudo openssl rand -base64 756 | sudo tee /etc/mongod-keyfile > /dev/null
   sudo chown <пользователь>:<группа> /etc/mongod-keyfile
   sudo chmod 400 /etc/mongod-keyfile
   ```

1. Добавьте в `/etc/mongod.conf`:

   ```yaml
   security:
     authorization: enabled
     keyFile: /etc/mongod-keyfile
   ```

1. Перезапустите MongoDB и настройте `net.bindIp`, TLS и файрвол для подключения приложений из вашей сети. Проверьте список баз командой `show dbs`, число документов в нужных коллекциях с помощью `db.<коллекция>.countDocuments()` и работу приложения.

## Восстановление шардированного кластера {#sharded-cluster}

Для восстановления исходного шардированного кластера необходимы копии всех шардов и серверов конфигурации. Серверы конфигурации хранят сведения о шардах, чанках, шардированных коллекциях, основных шардах баз и зонах.

Если копии серверов конфигурации нет, можно восстановить отдельные шарды как независимые наборы реплик по [основной инструкции](#restore). В этом случае WAL-G удалит старый `shardIdentity`; исходная структура шардированного кластера не восстанавливается.

Ниже показан пример с отдельными серверами: один для набора реплик `mongocfg`, по одному для шардов `shard01` и `shard02`, а также сервер для маршрутизатора `mongos`. Замените имена и адреса на свои. Сохраните исходные идентификаторы шардов.

### Подготовьте серверы {#prepare-sharded-cluster}

1. [Установите MongoDB и WAL-G](#install) и [настройте доступ к копиям](#configure-wal-g) на каждом сервере, где будут восстанавливаться данные.
1. В конфигурации WAL-G каждого сервера укажите `WALG_S3_PREFIX` или `WALG_FILE_PREFIX` для соответствующего компонента. Внутри каталога должны находиться его `basebackups_005/` и `oplog_005/`.
1. Выберите копии и момент времени, на который нужно восстановить состояние кластера. Архив `oplog` каждого компонента должен непрерывно покрывать интервал от его копии до этого момента. Для всех компонентов используйте одинаковое значение `--pitr-until` и параметр `--pitr-since LATEST_ON_REPLICA`. Не используйте `LATEST` в параметре `--pitr-until`: конец архива у компонентов может различаться.
1. Настройте разрешение имен и сетевую связность между серверами. Пока авторизация отключена, изолируйте сеть восстановления от посторонних подключений. Параметры `net` в примерах нужно адаптировать для своей сети.

   Примеры ниже относятся к самостоятельному восстановлению через WAL-G и требуют архивов `oplog` всех компонентов. Они не меняют [ограничения PITR в {{ mmg-name }}](../concepts/backup.md#pitr-details).

### Восстановите сервер конфигурации {#restore-config-server}

1. Создайте `/etc/mongocfg.conf`:

   ```yaml
   storage:
     dbPath: /var/lib/mongodb
     directoryPerDB: true
     engine: wiredTiger
     wiredTiger:
       collectionConfig:
         blockCompressor: snappy

   net:
     port: 27019
     bindIp: 127.0.0.1

   replication:
     replSetName: mongocfg

   sharding:
     clusterRole: configsvr
   ```

1. Создайте [минимальную конфигурацию](#configure-mongodb) `/etc/wal-g/mongod-minimal.conf`. Настройки хранилища в ней должны совпадать с `/etc/mongocfg.conf` и исходным кластером.
1. Убедитесь, что `mongod` остановлен, и выполните восстановление:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
     <имя_копии_или_LATEST> /etc/mongocfg.conf <мажорная_версия> \
     --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
     --mongo-rs-name mongocfg \
     --mongo-rs-members "$(hostname -f):27019" \
     --mongo-shard-conn-str "shard01/shard01-1.example.net:27017" \
     --mongo-shard-conn-str "shard02/shard02-1.example.net:27017" \
     --pitr-since LATEST_ON_REPLICA \
     --pitr-until <целевой_момент> \
     2>&1 | sudo tee /var/log/wal-g/restore.log
   ```

   Где `<целевой_момент>` — момент времени, на который нужно восстановить состояние кластера, в формате `<секунды_Unix>.<инкремент>`, например `1760086800.1`. Для сервера конфигурации и всех шардов укажите одинаковое значение.

   Укажите `--mongo-shard-conn-str` для каждого шарда в формате `<исходный_идентификатор_шарда>/<новые_хосты_через_запятую>`. WAL-G очистит `config.mongos`, `config.lockpings` и `config.shards`, затем заполнит `config.shards` указанными идентификаторами и адресами. Остальные метаданные маршрутизации берутся из резервной копии.

1. [Исправьте владельца](#start-mongodb) файлов в `dbPath` на пользователя и группу, от которых будете запускать `mongod`.

### Восстановите шарды {#restore-shards}

На сервере каждого шарда:

1. Подготовьте [основную и минимальную конфигурации](#configure-mongodb). В `/etc/mongod.conf` добавьте:

   ```yaml
   replication:
     replSetName: <идентификатор_шарда>

   sharding:
     clusterRole: shardsvr
   ```

1. Убедитесь, что `mongod` остановлен, и восстановите копию соответствующего шарда:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml binary-backup-fetch \
     <имя_копии_шарда> /etc/mongod.conf <мажорная_версия> \
     --minimal-mongod-config-path /etc/wal-g/mongod-minimal.conf \
     --mongo-rs-name <идентификатор_шарда> \
     --mongo-rs-members "<имя_хоста_шарда>:27017" \
     --mongo-sh-name <идентификатор_шарда> \
     --mongo-cfg-conn-str "mongocfg/cfg1.example.net:27019" \
     --pitr-since LATEST_ON_REPLICA \
     --pitr-until <целевой_момент> \
     2>&1 | sudo tee /var/log/wal-g/restore.log
   ```

   Где `<целевой_момент>` — момент времени, на который нужно восстановить состояние кластера, в формате `<секунды_Unix>.<инкремент>`, например `1760086800.1`. Для сервера конфигурации и всех шардов укажите одинаковое значение.

   Значения идентификатора шарда и адреса хоста должны совпадать с указанными в `--mongo-shard-conn-str` при восстановлении сервера конфигурации.

1. [Исправьте владельца](#start-mongodb) файлов в `dbPath`.

### Запустите кластер и проверьте данные {#start-sharded-cluster}

1. На сервере конфигурации запустите `mongod` с подготовленным файлом:

   ```bash
   sudo mongod --config /etc/mongocfg.conf
   ```

   Команда запускает процесс в текущем терминале. В другом терминале проверьте состояние набора реплик:

   ```bash
   mongosh --host "$(hostname -f)" --port 27019 \
       --eval 'rs.status().members.map(m => [m.name, m.stateStr])'
   ```

1. [Запустите MongoDB](#start-mongodb) на каждом шарде. Дождитесь состояния `PRIMARY` на сервере конфигурации и каждом шарде. Не выполняйте `rs.initiate()`: WAL-G уже записал конфигурацию наборов реплик.
1. На сервере маршрутизатора создайте `/etc/mongos.conf`:

   ```yaml
   sharding:
     configDB: mongocfg/cfg1.example.net:27019

   net:
     port: 27017
     bindIp: 127.0.0.1
   ```

   `mongos` не хранит собственные данные, поэтому восстанавливать его из копии не нужно. Запустите маршрутизатор:

   ```bash
   sudo mongos --config /etc/mongos.conf
   ```

1. В другом терминале на сервере маршрутизатора подключитесь к нему командой `mongosh --host "$(hostname -f)" --port 27017` и проверьте метаданные:

   ```javascript
   db.adminCommand({listShards: 1})
   sh.status()
   db.getSiblingDB("config").shards.find()
   db.getSiblingDB("config").databases.find()
   db.getSiblingDB("config").collections.find()
   db.getSiblingDB("config").chunks.countDocuments()
   db.getSiblingDB("config").tags.find()
   ```

   На каждом шарде подключитесь непосредственно к его `mongod` и проверьте `shardIdentity`:

   ```javascript
   db.getSiblingDB("admin").system.version.findOne({_id: "shardIdentity"})
   ```

   Значения `shardName` и `configsvrConnectionString` должны соответствовать новой конфигурации.

1. [Настройте пользователей и доступ](#configure-access), учитывая особенности шардированного кластера:

   * Создавайте и администрируйте пользователей кластера через `mongos`.
   * Сгенерируйте `keyfile` один раз и безопасно скопируйте один и тот же файл на сервер конфигурации, все шарды и маршрутизатор. На каждом сервере задайте владельца и права доступа к файлу.
   * Добавьте `security.keyFile` в `/etc/mongocfg.conf`, `/etc/mongod.conf` на шардах и `/etc/mongos.conf`. Для `mongod` также задайте `security.authorization: enabled`; для `mongos` этот параметр не используется.
   * Перезапустите все компоненты с их конфигурациями, проверьте аутентификацию через `mongos`, затем настройте TLS, файрвол и доступ приложений.

   Проверьте список баз, число документов в ключевых коллекциях и работу приложения через `mongos`.

## Восстановление логической копии (stream_*) {#logical-backup}

Копии с префиксом `stream_` представляют собой логический дамп, созданный командой `mongodump --archive`. Он восстанавливается в уже запущенную пустую MongoDB.

1. [Установите MongoDB и WAL-G](#install), [настройте WAL-G](#configure-wal-g) и установите [MongoDB Database Tools](https://www.mongodb.com/docs/database-tools/installation/) с утилитой `mongorestore`.
1. Подготовьте пустой экземпляр MongoDB и запустите его. До настройки доступа используйте только локальный интерфейс.
1. Получите метаданные выбранной копии командой `backup-show` и добавьте в `/etc/wal-g/wal-g.yaml`:

   ```yaml
   MONGODB_URI: 'mongodb://localhost:27017/?connect=direct'
   WALG_STREAM_RESTORE_COMMAND: 'mongorestore --archive --oplogReplay --uri="mongodb://localhost:27017"'
   ```

1. Восстановите копию:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml backup-fetch <имя_копии>
   ```

1. Для PITR примените архив `oplog` от `MongoMeta.Before.LastMajTS` выбранной копии до момента времени, на который нужно восстановить состояние кластера:

   ```bash
   sudo wal-g-mongo --config /etc/wal-g/wal-g.yaml oplog-replay \
     <начальный_момент> <целевой_момент>
   ```

   Где:

   * `<начальный_момент>` — момент времени, с которого нужно применять операции из архива `oplog`, в формате `<секунды_Unix>.<инкремент>`. Используйте поля `TS` и `Inc` из `MongoMeta.Before.LastMajTS` выбранной копии.
   * `<целевой_момент>` — момент времени, на который нужно восстановить состояние кластера, в формате `<секунды_Unix>.<инкремент>`, например `1760086800.1`.

   Начальная граница включается, конечная — нет. Момент времени, на который нужно восстановить состояние кластера, должен быть позже окончания создания выбранной копии. Архив `oplog` должен непрерывно покрывать весь интервал восстановления.

1. [Настройте пользователей и доступ](#configure-access) и проверьте восстановленные данные. Если вы восстанавливаете данные в отдельный экземпляр MongoDB без набора реплик, включите `security.authorization: enabled` без `security.keyFile`: внутренний ключ нужен для аутентификации участников набора реплик.

Время восстановления зависит от объема данных, числа документов и индексов. Если `mongorestore` завершается из-за нехватки памяти, добавьте в `WALG_STREAM_RESTORE_COMMAND` параметры `--numParallelCollections=1 --batchSize=100`.
