# Резервное копирование в {{ objstorage-full-name }} с помощью AWS S3 Sync

В этом практическом руководстве вы настроите резервное копирование файлов из локальной системы в облачное хранилище [{{ objstorage-full-name }}](../../storage/) с помощью [AWS S3 Sync](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html).

AWS S3 Sync — стандартная команда [AWS CLI](../../storage/tools/aws-cli.md) для синхронизации содержимого между локальным каталогом и [бакетом](../../storage/concepts/bucket.md). Это простой и надежный способ резервного копирования файлов в облачное объектное хранилище с поддержкой протокола S3.

Особенности использования AWS S3 Sync:

* Не требуется дополнительное программное обеспечение, кроме AWS CLI.
* Поддерживается на Linux, Windows и macOS.
* Простая настройка, работа напрямую с S3 API.
* Легкая автоматизация с помощью планировщика задач или скриптов.

Чтобы настроить резервное копирование с помощью AWS S3 Sync:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Установите AWS CLI](#install-aws).
1. [Синхронизируйте локальный каталог с бакетом](#sync).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/storage-backup/paid-resources.md) %}


## Создайте бакет {#create-bucket}

{% include [versioning-warning](../_tutorials_includes/storage-backup/versioning-warning.md) %}

{% include [create-bucket](../_tutorials_includes/storage-backup/create-bucket.md) %}


## Создайте сервисный аккаунт {#create-sa}

{% include [create-sa](../_tutorials_includes/storage-backup/create-sa.md) %}


## Создайте статический ключ доступа {#create-static-key}

{% include [create-static-key](../_tutorials_includes/storage-backup/create-static-key.md) %}


## Установите AWS CLI {#install-aws}

{% include [aws-cli-install](../../_includes/aws-cli-install.md) %}


## Синхронизируйте локальный каталог с бакетом {#sync}

Чтобы завершить настройку резервного копирования, настройте [ручную](#manual-sync) или [автоматическую](#auto-sync) синхронизацию локального каталога с бакетом.


### Ручная синхронизация {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  {% include [aws-manual-sync](../_tutorials_includes/storage-backup/aws-manual-sync.md) %}

- Windows {#windows}

  {% include [aws-manual-sync](../_tutorials_includes/storage-backup/aws-manual-sync.md) %}

  {% note tip %}

  Чтобы каждый раз не запускать команду, можно создать BAT-файл:

  1. Откройте **Блокнот** (**Notepad**) и добавьте следующее содержимое:

      ```text
      @echo off
      aws s3 sync "<путь_к_локальному_каталогу>" s3://<имя_бакета> ^
        --endpoint-url=https://{{ s3-storage-host }} ^
        --delete
      ```

      Где `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.

  1. Сохраните файл, например, как `sync_to_s3.bat`.
  1. Чтобы синхронизировать каталоги, запустите BAT-файл.

  {% endnote %}

{% endlist %}


### Автоматическая синхронизация {#auto-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для автоматической синхронизации локального каталога с бакетом:

  1. Убедитесь, что у пользователя, от имени которого будет ставиться задание в `cron`, есть доступ к локальному каталогу.
  1. Откройте файл планировщика текущего пользователя, выполнив команду:

      ```bash
      crontab -e
      ```

  1. Добавьте в файл строку для автоматической синхронизации, например, каждые 10 минут:

      ```text
      */10 * * * * aws s3 sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета> --delete --log-file=<путь_к_файлу_логов>
      ```

      Где:

      * `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.
      * `--log-file` — опциональный параметр для записи логов. Указывайте полный путь.

      {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  Задание будет запускаться с заданной периодичностью и выполнять синхронизацию каталогов.

- Windows {#windows}

  {% include [auto-sync-windows](../_tutorials_includes/storage-backup/auto-sync-windows.md) %}

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-backup/clear-out.md) %}