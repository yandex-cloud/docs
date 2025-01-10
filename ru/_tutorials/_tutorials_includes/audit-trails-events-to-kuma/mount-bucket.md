1. Подключитесь к серверу по [SSH](../../../compute/operations/vm-connect/ssh.md).
1. Создайте нового пользователя `kuma`:

    ```bash
    sudo useradd kuma
    ```

1. Создайте домашнюю директорию пользователя `kuma`:

    ```bash
    sudo mkdir /home/kuma
    ```

1. Создайте файл со статическим ключом доступа и выдайте пользователю `kuma` права на него:

    ```bash
    sudo bash -c 'echo <идентификатор_ключа_доступа>:<секретный_ключ_доступа> > /home/kuma/.passwd-s3fs'
    sudo chmod 600 /home/kuma/.passwd-s3fs
    sudo chown -R kuma:kuma /home/kuma
    ```

    Где `<идентификатор_ключа_доступа>` и `<секретный_ключ_доступа>` — сохраненные ранее значения статического ключа доступа сервисного аккаунта `kuma-bucket-sa`.

1. Установите пакет [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

    ```bash
    sudo apt install s3fs
    ````

1. Создайте директорию, которая будет служить точкой монтирования для бакета, и выдайте пользователю `kuma` права на эту директорию:

    ```bash
    sudo mkdir /var/log/yandex-cloud/
    sudo chown kuma:kuma /var/log/yandex-cloud/
    ```

1. Смонтируйте созданный ранее бакет, указав его имя:

    ```bash
    sudo s3fs <имя_бакета> /var/log/yandex-cloud \
      -o passwd_file=/home/kuma/.passwd-s3fs \
      -o url=https://{{ s3-storage-host }} \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    Вы можете настроить автоматическое монтирование бакета при запуске операционной системы, для этого откройте файл `/etc/fstab` (команда `sudo nano /etc/fstab`) и добавьте в него строку:

    ```text
    s3fs#<имя_бакета> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/kuma/.passwd-s3fs 0 0
    ```

    Где:

    * `<имя_бакета>` — имя созданного ранее бакета, например: `my-audit-logs-for-kuma`.
    * `<kuma_uid>` — идентификатор пользователя `kuma` в операционной системе ВМ.
    * `<kuma_gid>` — идентификатор группы пользователей `kuma` в операционной системе ВМ.

        Чтобы узнать значения `<kuma_uid>` и `<kuma_gid>`, в терминале выполните команду `id kuma`.

1. Убедитесь, что бакет смонтирован:

    ```bash
    sudo ls /var/log/yandex-cloud/
    ```

    Если все настроено верно, команда вернет текущее содержимое бакета с аудитными событиями.

Настройка передачи событий {{ yandex-cloud }} завершена. События будут располагаться в следующих директориях в [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON)-файлах:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```