{% include [include](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Посмотрите описание команды CLI для создания сервисного подключения:

    ```bash
    yc vpc private-endpoint create --help
    ```

1. Создайте сервисное подключение к {{ objstorage-short-name }} в каталоге по умолчанию:

    ```bash
    yc vpc private-endpoint create \
      --name s3-vpc-link \
      --description "Private Endpoint to the Object Storage" \
      --network-name default-net \
      --object-storage 
    ```

    Где:

    * `--network-name` — имя сети в которой будет создано сервисное подключение.
    * `--object-storage` — сервисное подключение к {{ objstorage-short-name }}. Другие типы сервисных подключей пока не доступны.

    При создании сервисного подключения можно использовать дополнительные параметры:

    * `--address-spec` — для указания IP-адреса и/или идентификатора подсети из которой будет взят IP-адрес для создаваемого сервисного подключения.
    * `--private-dns-records-enabled` — для указания нужно ли создавать отдельную DNS-запись для публичного FQDN сервиса. 

1. Проверьте, что сервисное подключение создалось:

    ```bash
    yc vpc private-endpoint list
    ```
    
    Результат выполнения команды:

    ```text
    +----------------------+-------------+--------------------------------+
    |          ID          |    NAME     |          DESCRIPTION           |
    +----------------------+-------------+--------------------------------+
    | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
    |                      |             | Storage                        |
    +----------------------+-------------+--------------------------------+
    ```
