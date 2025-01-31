---
title: Обзор {{ yandex-cloud }} SDK
description: Узнайте про SDK, которые применяются для работы с {{ yandex-cloud }}
sourcePath: ru/sdk/sdk/overview.md
---

# Обзор {{ yandex-cloud }} SDK

{{ yandex-cloud }} SDK — это комплект средств разработки для взаимодействия с облачной инфраструктурой.

SDK поддерживают работу с большинством сервисов {{ yandex-cloud }} и доступны для следующих языков программирования и фреймворков:
* [Node.js](https://github.com/yandex-cloud/nodejs-sdk)
* [Go](https://github.com/yandex-cloud/go-sdk)
* [Python](https://github.com/yandex-cloud/python-sdk)
* [Java](https://github.com/yandex-cloud/java-sdk)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk)

Подробнее об интеграции SDK в свой проект см. на странице [{#T}](./quickstart.md).

## Сервисные SDK {#service-sdks}

Для некоторых сервисов доступны специальные SDK:
* [{{ ml-sdk-full-name }}](../../foundation-models/sdk/index.md) — для сервисов [{{ ai-studio-full-name }}](/ai-studio).
* [Python SDK {{ speechkit-name }}](../../speechkit/sdk/python/index.md) — для [{{ speechkit-full-name }}](../../speechkit/).
* [SDK видеоплеера](../../video/sdk/index.md) — для [{{ video-full-name }}](../../video/).
* [YDB SDK](https://ydb.tech/docs/ru/reference/ydb-sdk/) — для [{{ ydb-full-name }}](../../ydb/) и [{{ yq-full-name }}](../../query/).

## AWS SDK {#aws-sdk}

Для сервисов, поддерживающих совместимость с AWS API, доступна интеграция с [AWS SDK](https://aws.amazon.com/developer/tools/):
* [{{ objstorage-full-name }}](../../storage/tools/sdk/index.md)
* [{{ yds-full-name }}](../../data-streams/operations/aws-sdk/prepare.md)
* [{{ cns-full-name }}](../../notifications/tools/sdk-python.md)
* [{{ ydb-full-name }}](../../ydb/docapi/tools/aws-sdk/index.md)

## Работа с {{ yandex-cloud }} SDK в {{ sf-full-name }} {#serverless}

Вы можете использовать {{ yandex-cloud }} SDK в коде [функций](../../functions/concepts/function.md) {{ sf-name }}. Подробнее см. в инструкциях для конкретного языка программирования или фреймворка:
* [Node.js](../../functions/lang/nodejs/sdk.md)
* [Python](../../functions/lang/python/sdk.md)
* [Go](../../functions/lang/golang/sdk.md)
* [Bash](../../functions/lang/bash/sdk.md)
* [Java](../../functions/lang/java/sdk.md)
* [Kotlin](../../functions/lang/kotlin/sdk.md)
* [.NET Core](../../functions/lang/csharp/sdk.md)

## См. также {#see-also}

* [{{ console-full-name }}](../../console/)
* [{{ yandex-cloud }} CLI](../../cli/)
* [{{ TF }} в {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
* [{{ yandex-cloud }} API](../../api-design-guide/)