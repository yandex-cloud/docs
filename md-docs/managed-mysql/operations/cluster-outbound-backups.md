[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for MySQL®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Восстановление базы данных из резервной копии WAL-G

# Восстановление базы данных MySQL® из резервной копии WAL-G

Если вам передали резервную копию кластера Managed Service for MySQL®, созданную с помощью WAL-G, вы можете восстановить ее на собственном сервере без доступа к кластеру в Yandex Cloud. Для этого потребуются файлы резервной копии в S3-совместимом хранилище и закрытый PGP-ключ для их расшифровки.

## Передаваемые данные {#data}

#|
|| **Ресурс** | **Содержимое** ||
|| `basebackups_005/` | Базовые резервные копии. ||
|| `binlog_005/` | Архив бинарных логов MySQL®. Нужен для восстановления на определенный момент времени (Point-in-Time Recovery, PITR). ||
|#

## Перед началом работы {#before-you-begin}

Подготовьте:

* Отдельный сервер под управлением Ubuntu 22.04 с достаточным местом для распакованных данных и файлов, создаваемых при восстановлении.
* Percona Server for MySQL той же мажорной версии, что и MySQL® в исходном кластере: 5.7, 8.0 или 8.4.
* Совместимую версию Percona XtraBackup и [WAL-G для MySQL](https://github.com/wal-g/wal-g/releases).
* Доступ на чтение к бакету с резервной копией: идентификатор и секретный ключ доступа. Для Object Storage используется [статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).
* Закрытый PGP-ключ резервной копии и, если он защищен паролем, пароль к нему.

Для восстановления на определенный момент времени также нужен архив бинарных логов. Время восстановления должно быть позднее завершения создания выбранной резервной копии.

Чтобы расшифровать ключ шифрования резервной копии:

1. Скачайте из бакета файл `nacl-key-*.7z`, который указан в `clickhouse.key_archive.file` JSON файла конфигурации в папке `__migration__/`.
1. Откройте архив и введите ключ, который ранее получили через форму запроса резервной копии. Если вы не сохранили ключ, то выгрузку резервной копии нужно запросить повторно. Чтобы раскрыть архив, используйте способ, подходящий для вашей операционной системы:

   * Windows: 7-Zip.
   * macOS: Keka.
   * Linux: команда `7z x nacl-key-*.7z`. Пароль вводите, когда 7z его спросит.

1. Используйте ключ, полученный из архива, для расшифровки резервной копии.

## Восстановить базу данных {#restore}

1. Установите Percona Server for MySQL, Percona XtraBackup и WAL-G:

   ```bash
   sudo apt update
   sudo apt install -y ca-certificates curl gnupg2 lsb-release
   curl -fLO https://repo.percona.com/apt/percona-release_latest.generic_all.deb
   sudo apt install -y ./percona-release_latest.generic_all.deb
   ```

   Выполните команды для версии исходного кластера:

   * **5.7**:

     ```bash
     sudo percona-release enable-only ps-57 release --scheme https
     sudo percona-release enable tools release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server-5.7=5.7.44-48-1.jammy \
       percona-server-common-5.7=5.7.44-48-1.jammy \
       percona-server-client-5.7=5.7.44-48-1.jammy \
       percona-xtrabackup-24=2.4.29-1.jammy
     ```

   * **8.0**:

     ```bash
     sudo percona-release setup ps80 --scheme https
     sudo percona-release enable pxb-80 release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server=8.0.43-34-1.jammy \
       percona-server-common=8.0.43-34-1.jammy \
       percona-server-client=8.0.43-34-1.jammy \
       percona-xtrabackup-80=8.0.35-34-1.jammy
     ```

   * **8.4**:

     ```bash
     sudo percona-release setup ps-84-lts --scheme https
     sudo percona-release enable pxb-84-lts release --scheme https
     sudo apt update
     sudo apt install -y \
       percona-server-server=8.4.7-7-1.jammy \
       percona-server-common=8.4.7-7-1.jammy \
       percona-server-client=8.4.7-7-1.jammy \
       percona-xtrabackup-84=8.4.0-5-1.jammy
     ```

   При установке сервер создаст новый каталог данных и может запросить пароль администратора и способ аутентификации. Для дальнейшего восстановления будут использованы пользователи и пароли из резервной копии.

   Скачайте архив `wal-g-mysql-22.04-amd64.tar.gz` со [страницы релизов WAL-G](https://github.com/wal-g/wal-g/releases) и установите исполняемый файл. Например, для версии 3.0.9:

   ```bash
   curl -fLO https://github.com/wal-g/wal-g/releases/download/v3.0.9/wal-g-mysql-22.04-amd64.tar.gz
   tar -xzf wal-g-mysql-22.04-amd64.tar.gz
   sudo install -m 755 wal-g-mysql-22.04-amd64 /usr/local/bin/wal-g-mysql
   wal-g-mysql --version
   sudo usermod -s /bin/bash mysql
   ```

1. Разместите закрытый PGP-ключ и настройте WAL-G:

   ```bash
   sudo install -d -o mysql -g mysql -m 0700 /etc/wal-g
   sudo install -o mysql -g mysql -m 0600 <путь_к_ключу> /etc/wal-g/PGP_KEY
   ```

   Создайте файл `/etc/wal-g/wal-g.yaml`:

   ```yaml
   AWS_ACCESS_KEY_ID: <идентификатор_статического_ключа>
   AWS_SECRET_ACCESS_KEY: <секретный_ключ_доступа>
   AWS_ENDPOINT: <эндпоинт_S3>
   AWS_REGION: <регион_S3>
   AWS_S3_FORCE_PATH_STYLE: true
   WALG_S3_PREFIX: s3://<имя_бакета>/<префикс_резервной_копии>
   WALG_PGP_KEY_PATH: /etc/wal-g/PGP_KEY
   WALG_MYSQL_DATA_DIR: /var/lib/mysql
   WALG_MYSQL_BINLOG_DST: /var/lib/mysql/.oldbinlogs
   WALG_STREAM_RESTORE_COMMAND: >
     xbstream --extract --parallel=8 --directory=/var/lib/mysql
   WALG_MYSQL_BINLOG_REPLAY_COMMAND: >
     mysqlbinlog --no-defaults --stop-datetime="$WALG_MYSQL_BINLOG_END_TS" "$WALG_MYSQL_CURRENT_BINLOG" |
     mysql --no-defaults --binary-mode --protocol=SOCKET --socket=/var/run/mysqld/mysqld.sock -u root
   ```

   В `WALG_S3_PREFIX` укажите путь к каталогу, содержащему `basebackups_005/` и, при наличии, `binlog_005/`. Значения `AWS_ENDPOINT` и `AWS_REGION` возьмите из настроек хранилища. Например, для Object Storage в российском регионе это `https://storage.yandexcloud.net` и `ru-central1`. Если PGP-ключ защищен паролем, добавьте в конфигурацию параметр `WALG_PGP_KEY_PASSPHRASE`.

   Ограничьте доступ к файлу конфигурации, в котором хранится секретный ключ:

   ```bash
   sudo chown mysql:mysql /etc/wal-g/wal-g.yaml
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

1. Проверьте доступ к резервным копиям и выберите копию для восстановления:

   ```bash
   sudo -u mysql wal-g-mysql backup-list --config /etc/wal-g/wal-g.yaml
   ```

   Если команда вывела список, доступ к бакету и путь `WALG_S3_PREFIX` настроены правильно. Выберите резервную копию, созданную до момента, на который хотите восстановить данные. Пример имени копии: `stream_20261009T203209Z`.

1. Проверьте целостность резервной копии:
 
   1. Сохраните скрипт в файл `s3_test_script.sh`.
   
       {% cut "Код скрипта" %}
   
       ```bash
       #!/usr/bin/env bash
       set -u
   
       if [[ $# -lt 1 || $# -gt 2 || ! -f $1 || ! -r $1 ]]; then
         printf 'Usage: %s /path/to/wal-g-config [storage/directory]\n' "$0" >&2
         exit 2
       fi
   
       config=$1
       directory=${2:-}
       directory=${directory#/}
       directory=${directory%/}
       wal_g=${WAL_G_BIN:-wal-g}
       listing=$(mktemp) || exit 2
       trap 'rm -f "$listing"' EXIT
   
       if ! "$wal_g" --config "$config" st ls -r >"$listing"; then
         printf 'ERROR: wal-g st ls -r failed\n' >&2 
         exit 2
       fi
   
       help=$({ "$wal_g" --config "$config" st cat --help || :; } 2>&1)
       if [[ $help == *--decode* ]]; then
         decode_flag=--decode
       elif [[ $help == *--decrypt* ]]; then
         decode_flag=--decrypt
       else
         printf 'ERROR: st cat supports neither --decode nor --decrypt\n' >&2
         exit 2
       fi
       if [[ $help != *--decompress* ]]; then
         printf 'ERROR: st cat does not support --decompress\n' >&2
         exit 2
       fi
   
       red='' reset=''
       if [[ -t 2 ]]; then red=$'\033[31m'; reset=$'\033[0m'; fi
       checked=0 decoded=0 raw=0 unknown=0 failed=0
   
       while IFS= read -r line; do
         path=''
         case $line in
           obj\ *) read -r _ _ _ _ _ _ path <<<"$line" ;;
           [0-9]*) read -r _ _ _ _ _ path <<<"$line" ;;
           dir\ *|type\ *|size\ *|'') continue ;;
           *) printf 'UNPARSED listing line: %s\n' "$line" >&2; ((unknown += 1)); continue ;;
         esac
   
         if [[ -z $path ]]; then
           printf 'UNPARSED listing line: %s\n' "$line" >&2
           ((unknown += 1))
           continue
         fi
         if [[ -n $directory && $path != "$directory/"* ]]; then
           continue
         fi
   
         ((checked += 1))
         case $path in
           *.br|*.lz4|*.lzma|*.zst|*.zstd|*.lzo)
             ((decoded += 1))
             "$wal_g" --config "$config" st cat "$path" "$decode_flag" --decompress >/dev/null ;;
           *.json)
             ((raw += 1))
             "$wal_g" --config "$config" st cat "$path" >/dev/null ;;
           *)
             ((raw += 1, unknown += 1))
             printf 'RAW ONLY (unknown format): %s\n' "$path" >&2
             "$wal_g" --config "$config" st cat "$path" >/dev/null ;;
         esac
   
         if [[ $? -ne 0 ]]; then
           printf '%sFAIL%s %s\n' "$red" "$reset" "$path" >&2
           ((failed += 1))
         fi
       done <"$listing"
   
       printf 'Checked: %d; decoded: %d; raw: %d; failed: %d; unknown: %d\n' \
         "$checked" "$decoded" "$raw" "$failed" "$unknown"
   
       if ((failed > 0)); then exit 1; fi
       if ((checked == 0 || unknown > 0)); then exit 2; fi
       ```
      
       {% endcut %}

   1. Запустите скрипт:

      ```bash
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      При необходимости укажите директорию:

      ```bash
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # проверяет копии
      WAL_G_BIN=wal-g-mysql ./s3_test_script.sh */etc/wal-g/wal-g.yaml* binlog_005 # проверяет архив бинарных логов
      ```

      Пример вывода:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:
      ```

1. Остановите MySQL® и восстановите файлы выбранной резервной копии. Выполняйте команды только на подготовленном сервере: удаление каталога `/var/lib/mysql` уничтожит данные установленного экземпляра MySQL®.

   ```bash
   sudo systemctl stop mysql
   sudo rm -rf /var/lib/mysql
   sudo install -d -o mysql -g mysql -m 0750 /var/lib/mysql
   sudo -u mysql wal-g-mysql backup-fetch <имя_резервной_копии> --config /etc/wal-g/wal-g.yaml
   sudo -u mysql xtrabackup --prepare --target-dir=/var/lib/mysql
   ```

   Перед запуском сервера добавьте в секцию `[mysqld]` файла `/etc/mysql/my.cnf` параметры для отключения проверок аутентификации и сетевых подключений, а также для включения GTID:

   ```ini
   [mysqld]
   skip-grant-tables
   skip-networking
   gtid_mode=ON
   enforce_gtid_consistency=ON
   ```

   Запустите сервер:

   ```bash
   sudo systemctl start mysql
   ```

   Используйте одно и то же имя резервной копии при скачивании и восстановлении на определенный момент времени. Если выбрана последняя копия, вместо имени можно указать `LATEST`.

1. Если требуется PITR, воспроизведите бинарные логи. Создайте каталог для бинарных логов и запустите восстановление. В параметре `--until` укажите время в формате RFC 3339 с часовым поясом:

   ```bash
   sudo install -d -o mysql -g mysql -m 0750 /var/lib/mysql/.oldbinlogs
   sudo -u mysql wal-g-mysql binlog-replay \
     --since <имя_резервной_копии> \
     --until '2026-10-13T10:00:00Z' \
     --config /etc/wal-g/wal-g.yaml
   ```

   Где:

   * `--since` — имя резервной копии, которую вы восстановили на предыдущем шаге. WAL-G начнет воспроизводить бинарные логи после этой копии.
   * `--until` — момент, до которого нужно восстановить данные, в формате RFC 3339 с указанием часового пояса. Он должен быть позднее завершения создания выбранной резервной копии.
   * `--config` — путь к файлу конфигурации WAL-G, созданному на втором шаге.

   Если архива `binlog_005/` нет или восстановление на определенный момент времени не требуется, пропустите этот шаг.

1. Проверьте восстановленные данные: список баз данных, количество строк в основных таблицах и работу приложения. Пользователи и пароли из исходного кластера также восстановлены. Проверьте их доступы и заблокируйте или удалите служебные учетные записи исходного кластера, которые больше не нужны.

   После настройки учетных записей и паролей включите проверки аутентификации и сетевые подключения: удалите параметры `skip-grant-tables` и `skip-networking` из файла `/etc/mysql/my.cnf`.