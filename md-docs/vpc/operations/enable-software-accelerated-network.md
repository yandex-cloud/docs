# Включить программно ускоренную сеть

Вы можете включить [программно ускоренную сеть](../concepts/software-accelerated-network.md) при создании или изменении [виртуальной машины](../../glossary/vm.md).

{% note warning %}

Функциональность доступна только по согласованию с вашим аккаунт-менеджером.

{% endnote %}

Чтобы включить программно ускоренную сеть на существующей ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. В строке с нужной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Остановить**.
  1. В открывшемся окне нажмите **Остановить**.
  1. Подождите пока ВМ перейдет в статус `Stopped`, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Вычислительные ресурсы** выберите опцию **Программное ускорение сети**.
  1. Нажмите **Сохранить изменения**.
  1. Нажмите **Запустить** в правом верхнем углу.
  1. В открывшемся окне нажмите **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Получите список ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ и остановите ее. Например, чтобы остановить ВМ с именем `first-instance`, выполните команду:

      ```bash
      yc compute instance stop first-instance
      ```

  1. Включите программно ускоренную сеть:

      1. Выполните команду:

          ```bash
          yc compute instance update first-instance \
            --network-settings type=software-accelerated
          ```

          Где `--network-settings` — флаг, который переключает тип сети.

          Результат:

          ```text
          id: fhm0b28lgfp4********
          folder_id: b1gbnv36zqf5********
          created_at: "2023-05-24T09:28:11Z"
          name: first-instance
          zone_id: ru-central1-a
          platform_id: standard-v3
          resources:
            memory: "2147483648"
            cores: "2"
            core_fraction: "100"
          status: STOPPED
          ...
          network_settings:
            type: SOFTWARE_ACCELERATED
          placement_policy: {}
          ```

      1. Запустите ВМ:

          ```bash
          yc compute instance start first-instance
          ```

  Чтобы выключить программно ускоренную сеть, остановите ВМ и выполните команду:

    ```bash
    yc compute instance update first-instance \
      --network-settings type=standard
    ```

{% endlist %}