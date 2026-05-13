# Посмотреть операции с ресурсами сервиса Load Testing

{% note warning %}

С 1 июля 2026 года сервис Load Testing прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


Все действия с ресурсами сервиса Load Testing сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором вы хотите посмотреть операции.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Load Testing**.
  1. На панели слева выберите ![image](../../_assets/operations.svg) **Операции**.

  В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

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
      id: ff67zb1214j6********
      description: Create Job
      created_at: "2024-02-01T09:07:33.271288Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T09:07:33.398853Z"
      done: true
      metadata:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      response:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../../api-design-guide/concepts/operation.md#monitoring), или вызовом gRPC API [OperationService/Get](../user/api-ref/grpc/Operation/get.md).

    {% endlist %}

#### См. также {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)