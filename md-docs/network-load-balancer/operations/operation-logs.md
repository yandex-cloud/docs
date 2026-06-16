# Посмотреть операции с ресурсами сервиса Network Load Balancer

Все действия с ресурсами сервиса Network Load Balancer сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/operations.svg) **Операции**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для сетевого балансировщика. Для целевой группы последовательность действий такая же.

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится сетевой балансировщик.
  1. Перейдите в сервис **Network Load Balancer**.
  1. Выберите нужный сетевой балансировщик.
  1. Перейдите на панель ![image](../../_assets/operations.svg) **Операции**.

      В открывшемся списке отображаются операции с сетевым балансировщиком.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для ресурса сервиса Network Load Balancer, выполните команду:

  ```bash
  yc load-balancer <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для сетевого балансировщика:

  ```bash
  yc load-balancer network-load-balancer list-operations enpaud0h342p********
  ```

  Идентификатор сетевого балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |        DESCRIPTION         |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  | enp87akr8sdr******** | 2024-02-01 09:33:45 | ajego134p5h1******** | 2024-02-01 09:33:45 | DONE   | Create NetworkLoadBalancer |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc load-balancer network-load-balancer list-operations enp87akr8sdr******** --format yaml
  ```

  Результат:

  ```text
  - id: enp87akr8sdr********
  description: Create NetworkLoadBalancer
  created_at: "2024-02-01T09:33:45.035Z"
  created_by: ajego134p5h1********
  modified_at: "2024-02-01T09:33:45.642754913Z"
  done: true
  metadata:
    '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerMetadata
    network_load_balancer_id: enpaud0h342p********
  response:
    '@type': type.googleapis.com/google.protobuf.Empty
    value: {}
  ```

- API {#api}

  Чтобы получить список операций, воспользуйтесь методом REST API `listOperations` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListOperations`.

  Например, для сетевого балансировщика воспользуйтесь методом REST API [listOperations](../api-ref/NetworkLoadBalancer/listOperations.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md), или вызовом gRPC API [NetworkLoadBalancerService/ListOperations](../api-ref/grpc/NetworkLoadBalancer/listOperations.md) и передайте идентификатор сетевого балансировщика в параметре `networkLoadBalancerId` запроса.

  Идентификатор сетевого балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

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
      id: enp87akr8sdr********
      description: Create NetworkLoadBalancer
      created_at: "2024-02-01T09:33:45.035Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T09:33:45.642Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerMetadata
        network_load_balancer_id: enpaud0h342p********
      response:
        '@type': type.googleapis.com/yandex.cloud.loadbalancer.v1.NetworkLoadBalancer
        id: enpaud0h342p********
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T09:33:45Z"
        name: nlb-e6f3e-083
        region_id: ru-central1
        status: ACTIVE
        type: EXTERNAL
      ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../api-ref/Operation/get.md) для ресурса [Operation](../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

    {% endlist %}

#### Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)