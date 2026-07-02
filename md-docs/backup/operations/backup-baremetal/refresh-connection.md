[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Пошаговые инструкции](../index.md) > BareMetal в Cloud Backup > Переподключить сервер BareMetal к Cloud Backup

# Переподключить сервер Yandex BareMetal к Cloud Backup


Если вы развернули резервную копию одного сервера на другом, подключение исходного сервера к Cloud Backup становится неактуальным. Чтобы продолжить резервное копирование исходного сервера и избежать конфликтов с новым, обновите подключение исходного сервера к Cloud Backup:

1. Для подключения сервера BareMetal к Cloud Backup нужен [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с минимальными [ролями](../../../iam/concepts/access-control/roles.md) `backup.user` и `baremetal.editor`. [Создайте](backup-baremetal.md#prepare-service-account) его или назначьте необходимые роли имеющемуся сервисному аккаунту.
1. [Получите](../../../iam/operations/index.md#authentication) IAM-токен.
1. Перезапустите подключение к Cloud Backup на неактуальном сервере:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к серверу по SSH.
      1. Установите на сервер утилиты [curl](https://curl.se/), [wget](https://www.gnu.org/software/wget/), [gawk](https://www.gnu.org/software/gawk/), [uuid-dev](https://ru.wikipedia.org/wiki/UUID) и [uuidgen](https://uuidgen.org/):

          {% note info %}

          Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

          {% endnote %}

          ```bash
          sudo apt install curl
          sudo apt install wget
          sudo apt install gawk
          sudo apt install uuid-dev
          sudo apt install uuid-runtime
          ```

      1. Обновите подключение к Cloud Backup:

          ```bash
          wget https://storage.yandexcloud.net/backup-distributions/agent_reinit_bms.sh
          sudo bash agent_reinit_bms.sh -t=<IAM-токен>
          ```

          Где `-t` — IAM-токен, полученный ранее.

          Результат:

          ```text
          ...
          Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
          Updating ids in Cloud Backup
          Finished
          ```

    {% endlist %}

1. Убедитесь, что сервер подключен к Cloud Backup:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Получите список серверов BareMetal, подключенных к Cloud Backup:

      ```bash
      yc backup resource list --type bms
      ```

      Где `--type` — тип ресурсов.

      Результат:

      ```text
      compute_instance_id: epd5sk4auijm********
      created_at: "2024-11-17T10:29:40.436155166Z"
      updated_at: "2024-11-17T10:32:54.580592713Z"
      online: true
      enabled: true
      status: IDLE
      next_backup_time: "2024-11-24T00:00:00Z"
      resource_id: ad216376-a8d7-4c28-9a8d-b4ad********
      is_active: true
      init_status: REGISTRED
      metadata: "null"
      type: BMS
      ```

    {% endlist %}

1. [Привяжите](../policy-vm/attach-and-detach-vm.md) сервер к политике резервного копирования.