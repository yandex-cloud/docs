# Доступ в бакет с помощью сервисного подключения из {{ vpc-full-name }}

{% include [vpc-pe-preview](../../../_includes/vpc/pe-preview.md) %}

{% include [intro-access-via-vpc](../../../_includes/storage/intro-access-via-vpc.md) %}

Чтобы организовать доступ в бакет с помощью сервисного подключения из {{ vpc-short-name }}:

1. [Создайте](../../../vpc/operations/private-endpoint-create.md) сервисное подключение (Private Endpoint).

    {% include [private-endpoint-create-roles](../../../_includes/vpc/private-endpoint-create-roles.md) %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [private-endpoint-create-cli](../../../_includes/vpc/private-endpoint-create-cli.md) %}

    {% endlist %}

    Теперь бакеты {{ objstorage-name }} доступны по внутренним IP-адресам {{ vpc-short-name }} без использования доступа в интернет.

1. Сохраните идентификатор подключения из столбца `ID`.

1. Чтобы доступ к бакету осуществлялся _только по внутренним IP-адресам {{ vpc-short-name }}_, [назначьте](../../../vpc/operations/private-endpoint-storage-policy.md) бакету политику доступа для сервисного подключения.

    {% include [private-endpoint-policy-tabs](../../../_includes/storage/private-endpoint-policy-tabs.md) %}

#### См. также {#see-also}

* [Cервисные подключения {{ vpc-short-name }}](../../../vpc/operations/index.md#private-endpoint)
* [Работа с сервисными подключениями {{ vpc-short-name }}](../../../vpc/concepts/private-endpoint.md)
* [Политика доступа (bucket policy)](../../../storage/concepts/policy.md)
* [Подключение к {{ objstorage-name }} из {{ vpc-name }}](../../../storage/tutorials/storage-vpc-access.md)
