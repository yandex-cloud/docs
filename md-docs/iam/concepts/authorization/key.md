# Авторизованные ключи

{% note info %}

Создание авторизованных ключей сервисных аккаунтов может быть запрещено [политиками авторизации](../access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

_Авторизованные ключи_ — это ключи с алгоритмом шифрования RSA-2048 или RSA-4096 с неограниченным сроком жизни. Такие ключи используются при [запросе](../../operations/iam-token/create-for-sa.md#via-cli) на получение [IAM-токена](iam-token.md) для сервисного аккаунта. При этом использовать авторизованные ключи непосредственно для аутентификации в [API Yandex Cloud](../../../api-design-guide/index.md) нельзя.

В результате [запроса](../../operations/authentication/manage-authorized-keys.md#create-authorized-key) на получение авторизованного ключа вы получите JSON-файл, содержащий открытую и закрытую части ключа. Сохраните этот файл — повторно получить его будет невозможно.

{% note warning %}

Закрытая часть ключа — это секретная информация, позволяющая выполнять операции в Yandex Cloud. Защитите ее при хранении.

{% endnote %}

Открытую часть ключа можно получить повторно с помощью метода REST API [get](../../api-ref/Key/get.md) для ресурса [Key](../../api-ref/Key/index.md) или вызова gRPC API [KeyService/Get](../../api-ref/grpc/Key/get.md). Закрытая часть авторизованного ключа хранится только на стороне пользователя и повторно запросить ее нельзя. В случае утери закрытой части ключа, создайте новый авторизованный ключ.

Чтобы обеспечивать безопасность и контроль над доступом к ресурсам, отслеживать случаи несанкционированного использования ключей, а также удалять неиспользуемые ключи без риска нарушить работу сервисов Yandex Cloud, вы можете отслеживать даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления](https://console.yandex.cloud), а также в поле `last_used_at` при вызове методов управления ключами доступа через API.

Закрытая часть авторизованного ключа Yandex Cloud начинается со строки `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID…` согласно стандарту [RFC 7468](https://datatracker.ietf.org/doc/html/rfc7468#section-2). Данная строка предназначена для облегчения [обнаружения секретов](../../../security/operations/search-secrets.md) в случае их утечки.

## Примеры использования {#examples}

* [Автоматическое масштабирование группы виртуальных машин для обработки сообщений из очереди Yandex Message Queue](../../../tutorials/infrastructure-management/autoscale-monitoring.md)

#### Полезные ссылки {#see-also}

* [Создать авторизованный ключ](../../operations/authentication/manage-authorized-keys.md#create-authorized-key)
* [Удалить авторизованный ключ](../../operations/authentication/manage-authorized-keys.md#delete-authorized-key)
* [Аутентификация от имени сервисного аккаунта](../../../cli/operations/authentication/service-account.md)
* [Получение IAM-токена для сервисного аккаунта](../../operations/iam-token/create-for-sa.md)