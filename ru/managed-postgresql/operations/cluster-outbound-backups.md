---
title: Восстановление PostgreSQL из резервной копии WAL-G
description: Следуя этой инструкции, вы сможете самостоятельно восстановить базу данных PostgreSQL из резервной копии WAL-G.
noIndex: true
---

# Восстановление {{ PG }} из резервной копии WAL-G

При передаче резервной копии кластера {{ PG }} вместе с ней передается каталог WAL-G из S3 (базовые резервные копии и архив WAL). Для восстановления не требуются {{ yandex-cloud }} и {{ mpg-short-name }}. Достаточно иметь доступ к хранилищу с копиями, ключу шифрования, а также установленные {{ PG }} и WAL-G.

## Передаваемые данные {#data}


| Ресурс             | Содержимое                                                                                                                                                                                            |
|:-------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `basebackups_005/` | Базовые резервные копии: полные (`base_<WAL>`) и инкрементальные (`base_<WAL>_D_<WAL>`). Инкрементальная резервная копия восстанавливается только вместе со всей цепочкой до ближайшего полной копии. |
| `wal_005/`         | Архив WAL. Без него резервная копия не будет консистентной; она же нужна для восстановления на момент времени (PITR).         |

## Перед началом работы {before-you-begin}

Для выполнения инструкции вам потребуются:

1. {{ PG }}: Версия {{ PG }} должна совпадать с мажорной версией исходного кластера.
1. WAL-G: Бинарный файл wal-g-pg для PostgreSQL (скачать можно со [страницы релизов](https://github.com/wal-g/wal-g/releases) WAL-G).
1. Ключ шифрования: Экспортированный из бакета ключ, используемый для защиты резервных копий.
1. Доступ к бакету: Статический ключ (идентификатор статического ключа доступа и значение секретного ключа доступа) с правами на чтение бакета.
1. Дисковое пространство: Свободное место на диске, достаточное для хранения данных в распакованном виде с учетом:

   * Размера самой базы данных;
   * Размера WAL-сегментов, которые будут восстанавливаться.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Восстановление базы данных {#restore}

1. Установите {{ PG }} и WAL-G:

   ```bash
   # PostgreSQL из репозитория PGDG
   sudo apt install -y postgresql-common
   sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
   sudo apt install -y postgresql-<версия>
   sudo systemctl stop postgresql

   # WAL-G: скачайте архив wal-g-pg-<ОС>-amd64 со страницы релизов
   tar -xzf wal-g-pg-*.tar.gz
   sudo install -m 755 wal-g-pg-*-amd64 /usr/local/bin/wal-g
   wal-g --version
   ```

1. Передайте статический ключ и настройте WAL-G:

   ```bash
   sudo mkdir -p /etc/wal-g
   sudo cp GPG_KEY /etc/wal-g/GPG_KEY
   sudo chown -R postgres:postgres /etc/wal-g
   sudo chmod 600 /etc/wal-g/GPG_KEY
   ```

   Создайте конфиг `/etc/wal-g/wal-g.yaml`:

   ```yaml
   AWS_ACCESS_KEY_ID:        <идентификатор_статического_ключа>
   AWS_SECRET_ACCESS_KEY:    <значение_секретного_ключа_доступа>
   AWS_ENDPOINT:             https://storage.yandexcloud.net   # или эндпоинт вашего S3
   AWS_REGION:               ru-central1
   AWS_S3_FORCE_PATH_STYLE:  true
   WALG_S3_PREFIX:           s3://<bucket>/<префикс, где лежат basebackups_005/ и wal_005/>
   WALG_PGP_KEY_PATH:        /etc/wal-g/GPG_KEY
   # WALG_PGP_KEY_PASSPHRASE: <пароль>   # только если ключ защищён паролем
   PGDATA:                   /var/lib/postgresql/<версия>/main
   PGHOST:                   /var/run/postgresql
   ```

   ```bash
   sudo chmod 600 /etc/wal-g/wal-g.yaml
   ```

   Метод сжатия указывать не нужно: он требуется только для записи бэкапа.

1. Проверьте доступ и выберите резервную копию бэкап

   ```bash
   sudo -u postgres wal-g backup-list --detail --pretty --config /etc/wal-g/wal-g.yaml
   ```

   Если команда вернула список, значит доступ к бакету и путь в конфиге верные. Пример вывода:

   ```
   name                                                     last_modified        wal_segment_backup_start
   base_000000010000139E00000073                            2020-07-29T23:50:20Z 000000010000139E00000073
   base_00000001000013A9000000B1_D_000000010000139E00000073 2020-07-30T23:46:00Z 00000001000013A9000000B1
   ```

   Выберите резервную копию, сделанную **до** момента, на который требуется восстановление. Для инкрементальной копии WAL-G сам скачает всю цепочку до полной.

1. Скачайте резервную копию

   ```bash
   # каталог данных должен быть пустым
   sudo rm -rf /var/lib/postgresql/<версия>/main
   sudo -u postgres wal-g backup-fetch /var/lib/postgresql/<версия>/main <имя бэкапа или LATEST> \
     --config /etc/wal-g/wal-g.yaml
   sudo chmod 700 /var/lib/postgresql/<версия>/main
   ```

   Скорость скачивания определяется параметром `WALG_DOWNLOAD_CONCURRENCY`. По умолчанию он равен 10, однако если общее число файлов меньше 10, параметр принимает значение, равное количеству файлов.

1. Проверьте целостность резервной копии:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Запустите скрипт:

      ```bash
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml*
      ```
   
      При необходимости укажите директорию:

      ```bash
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml* basebackups_005 # проверяет копии
      ./s3_test_script.sh */etc/wal-g/wal-g.yaml* wal_005 # проверяет WAL
      ```

      Пример вывода:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:
      ```

1. Очистите настройки исходного кластера в каталоге данных:

   * `postgresql.auto.conf` — {{ PG }} читает его автоматически. Удалите или закомментируйте строки, которые ссылаются на чужие пути, хосты и библиотеки: `shared_preload_libraries`, `archive_command`, `primary_conninfo` и т. п.
   * `conf.d/` — конфиги исходного кластера. Используйте свой `postgresql.conf` из `/etc/postgresql/<версия>/main/`, а этот каталог оставьте для справки: из него можно перенести нужные параметры (`shared_buffers`, `max_connections` и т. п.).

   Если в исходной БД были расширения, которых нет в сборках {{ mpg-name }}, уберите их из `shared_preload_libraries`. Объекты этих расширений в базах останутся, но работать не будут.

1. Настройте восстановление из резервной копии. Создайте файл `/etc/postgresql/<версия>/main/conf.d/recovery.conf` (каталог `conf.d` подключается в стандартном `postgresql.conf` Debian или Ubuntu).

   ```ini
   restore_command = '/usr/local/bin/wal-g wal-fetch "%f" "%p" --config /etc/wal-g/wal-g.yaml'
   recovery_target_action = 'promote'
   archive_mode = off

   # Выберите один вариант:
   recovery_target = 'immediate'                         # на момент окончания бэкапа (быстрее всего)
   # recovery_target_time = '2026-10-10 12:00:00+03'     # на конкретный момент времени (PITR)
   # (без recovery_target* — проиграть весь доступный архив WAL)
   ```

   ```bash
   sudo -u postgres touch /var/lib/postgresql/<версия>/main/recovery.signal
   ```

   Если `wal-fetch` завершается с кодом `74`, файла WAL нет в архиве. В конце архива это нормально.

1. Запустите восстановление:

   ```bash
   sudo systemctl start postgresql
   sudo tail -f /var/log/postgresql/postgresql-<версия>-main.log
   ```

   Восстановление завершено, когда:

   * в логе есть `consistent recovery state reached` и `archive recovery complete`;
   * файл `recovery.signal` удален;
   * `SELECT pg_is_in_recovery();` возвращает `false`.

   После этого удалите `conf.d/recovery.conf`, чтобы параметры восстановления не применялись при следующих перезапусках.

1. Настройте безопасность после восстановления:

   * Роли: Заблокируйте вход для служебных ролей, перенесенных из старого кластера: `ALTER ROLE <role> NOLOGIN` или удалите их, если они не нужны.
   * Аутентификация: Отредактируйте `/etc/postgresql/<версия>/main/pg_hba.conf`. Замените старые правила доступа на актуальные для новой сети и пользователей. Перезапустите сервис.

После завершения восстановления проверьте данные: список баз (`\l`), количество строк в ключевых таблицах, работу приложения.
