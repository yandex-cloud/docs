[Документация Yandex Cloud](../../index.md) > [Yandex Lockbox](../index.md) > Концепции > Обзор

# Обзор сервиса Yandex Lockbox

Yandex Lockbox — это сервис для централизованного хранения секретов, таких как пароли, [SSH-ключи](../../glossary/ssh-keygen.md) и токены. Секрет состоит из набора версий, в которых хранятся данные. Версия содержит одну или больше пар ключ-значение. Ключ — это несекретный идентификатор значения, по которому вы будете его идентифицировать. Значение — это секретные данные.

Yandex Lockbox позволяет централизованно создавать, изменять и удалять секреты, а также управлять доступом к ним с помощью [Yandex Identity and Access Management](../../iam/index.md).

Все секреты хранятся в зашифрованном виде. По умолчанию используется системный ключ. Вы также можете шифровать секреты собственным ключом [Yandex Key Management Service](../../kms/index.md).

## Мониторинг и аудит {#monitoring-and-audit}

В [Monium](../../monium/index.md) доступны [метрики Yandex Lockbox](../metrics.md): количество активных версий секретов и операции получения их содержимого.

Чтобы отслеживать изменения секретов и доступ к их содержимому, [создайте трейл](../../audit-trails/operations/create-trail.md) в Yandex Audit Trails. Для регистрации обращений к содержимому включите сбор событий уровня сервисов (Data Plane). Поддерживаемые события перечислены в [справочнике аудитных логов](../at-ref.md).

## Интерфейсы работы с сервисом {#interface}

Для взаимодействия с Yandex Lockbox можно использовать:

* [Консоль управления](https://console.yandex.cloud).
* [Интерфейс командной строки (CLI)](../../cli/index.md).
* API: [REST](../api-ref/index.md) или [gRPC](../api-ref/grpc/index.md).
* SDK: на [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk) или [Node.js](https://github.com/yandex-cloud/nodejs-sdk).