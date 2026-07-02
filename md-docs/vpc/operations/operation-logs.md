[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть операции с ресурсами сервиса

# Посмотреть операции с ресурсами сервиса Virtual Private Cloud

Все действия с ресурсами сервиса Virtual Private Cloud сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/operations.svg) **Операции**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для облачной сети. Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится облачная сеть.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Выберите нужную сеть.
  1. Перейдите на панель ![image](../../_assets/operations.svg) **Операции**.

     В открывшемся списке отображаются операции с облачной сетью.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для ресурса сервиса Virtual Private Cloud, выполните команду:

  ```bash
  yc vpc <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для облачной сети:

  ```bash
  yc vpc network list-operations enpgl5o8te3k********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | enp75021agjg******** | 2024-02-01 10:16:51 | ajego134p5h1******** | 2024-02-01 10:16:53 | DONE   | Create network |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc vpc network list-operations enpgl5o8te3k******** --format yaml
  ```

  Результат:

  ```text
  - id: enp75021agjg********
    description: Create network
    created_at: "2024-02-01T10:16:51.955935138Z"
    created_by: ajego134p5h1********
    modified_at: "2024-02-01T10:16:53.389542083Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
      network_id: enpgl5o8te3k********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для облачной сети воспользуйтесь методом REST API [listOperations](../api-ref/Network/listOperations.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/ListOperations](../api-ref/grpc/Network/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: enp75021agjg********
      description: Create network
      created_at: "2024-02-01T10:16:51.955Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T10:16:53.389Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.CreateNetworkMetadata
        network_id: enpgl5o8te3k********
      response:
        '@type': type.googleapis.com/yandex.cloud.vpc.v1.Network
        id: enpgl5o8te3kke6q3psa
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T10:16:51Z"
        name: test-network
        default_security_group_id: enp0catll8gm********
        ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../api-ref/Operation/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

    {% endlist %}

#### Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)