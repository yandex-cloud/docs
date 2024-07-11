# Посмотреть операции с профилями

Все действия с профилями безопасности, WAF и ARL сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми [профилями](../concepts/profiles.md), на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. В открывшемся списке также отображаются операции для профилей, которые были удалены.

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для профилей безопасности.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)