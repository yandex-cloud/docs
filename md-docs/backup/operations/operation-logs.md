[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть операции с ресурсами сервиса

# Посмотреть операции с ресурсами сервиса Cloud Backup

Все действия с ресурсами сервиса Cloud Backup сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми ресурсами сервиса, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **Операции**. В открывшемся списке также отображаются операции для ресурсов, которые были удалены.

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
      id: cdg4g6c4jlak********
      description: apply policy
      created_at: "2024-05-14T15:24:23.800129Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-05-14T15:24:23.800129Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.backup.v1.ApplyPolicyMetadata
      response:
        '@type': type.googleapis.com/google.protobuf.Empty
        value: {}
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../backup/api-ref/grpc/Operation/get.md).

    {% endlist %}

#### Полезные ссылки {#see-also}

* [Работа с операциями](../../api-design-guide/concepts/about-async.md)