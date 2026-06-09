# Обзор сервиса Yandex Lockbox

Yandex Lockbox — это сервис для централизованного хранения секретов, таких как пароли, [SSH-ключи](../../glossary/ssh-keygen.md) и токены. Секрет состоит из набора версий, в которых хранятся данные. Версия содержит одну или больше пар ключ-значение. Ключ — это несекретный идентификатор значения, по которому вы будете его идентифицировать. Значение — это секретные данные.

Yandex Lockbox позволяет пользователям управлять жизненным циклом секрета — централизовано создавать, изменять и удалять секреты, а также пользоваться всеми возможностями сервиса [Yandex Identity and Access Management](../../iam/index.md) для управления доступом.

Все секреты хранятся в зашифрованном виде. По умолчанию они зашифрованы с помощью системного ключа, но также можно использовать сервис [Yandex Key Management Service](../../kms/index.md) для использования собственных ключей.

## Интерфейсы работы с сервисом {#interface}

Для взаимодействия с Yandex Lockbox можно использовать:

* [Консоль управления](https://console.yandex.cloud).
* [Интерфейс командной строки (CLI)](../../cli/index.md).
* API: [REST](../api-ref/index.md) или [gRPC](../api-ref/grpc/index.md).
* SDK: на [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk) или [Node.js](https://github.com/yandex-cloud/nodejs-sdk).