[Документация Yandex Cloud](../../index.md) > [Обзор платформы](../index.md) > Интерфейсы для работы с сервисами > SDK > Обзор

# Обзор Yandex Cloud SDK

Yandex Cloud SDK — это комплект средств разработки для взаимодействия с облачной инфраструктурой.

SDK поддерживают работу с большинством сервисов Yandex Cloud и доступны для следующих языков программирования и фреймворков:
* [Node.js](https://github.com/yandex-cloud/nodejs-sdk)
* [Go](https://github.com/yandex-cloud/go-sdk)
* [Python](https://github.com/yandex-cloud/python-sdk)
* [Java](https://github.com/yandex-cloud/java-sdk)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk)

Подробнее об интеграции SDK в свой проект смотрите на странице [Как начать работать с Yandex Cloud SDK](quickstart.md).

## Сервисные SDK {#service-sdks}

Для некоторых сервисов доступны специальные SDK:
* [Yandex AI Studio SDK](https://aistudio.yandex.ru/docs/ru/ai-studio/sdk/index) — для сервисов [Yandex AI Studio](https://yandex.cloud/ru/ai-studio).
* [Python SDK SpeechKit](https://pypi.org/project/yandex-speechkit/)
* [SDK видеоплеера](../../video/sdk/index.md) — для [Yandex Cloud Video](../../video/index.md).
* [YDB SDK](https://ydb.tech/docs/ru/reference/ydb-sdk/) — для [Yandex Managed Service for YDB](../../ydb/index.md) и [Yandex Query](../../query/index.md).

## AWS SDK {#aws-sdk}

Для сервисов, поддерживающих совместимость с AWS API, доступна интеграция с [AWS SDK](https://aws.amazon.com/developer/tools/):
* [Yandex Object Storage](../../storage/tools/sdk/index.md)
* [Yandex Data Streams](../../data-streams/operations/aws-sdk/prepare.md)
* [Yandex Cloud Notification Service](../../notifications/tools/sdk-python.md)
* [Yandex Managed Service for YDB](../../ydb/docapi/tools/aws-sdk/index.md)

## Работа с Yandex Cloud SDK в Yandex Cloud Functions {#serverless}

Вы можете использовать Yandex Cloud SDK в коде [функций](../../functions/concepts/function.md) Cloud Functions. Подробнее в инструкциях для конкретного языка программирования или фреймворка:
* [Node.js](../../functions/lang/nodejs/sdk.md)
* [Python](../../functions/lang/python/sdk.md)
* [Go](../../functions/lang/golang/sdk.md)
* [Bash](../../functions/lang/bash/sdk.md)
* [Java](../../functions/lang/java/sdk.md)
* [Kotlin](../../functions/lang/kotlin/sdk.md)
* [.NET Core](../../functions/lang/csharp/sdk.md)

## Полезные ссылки {#see-also}

* [Yandex Cloud Console](../../console/index.md)
* [Yandex Cloud CLI](../../cli/index.md)
* [Terraform в Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Yandex Cloud API](../../api-design-guide/index.md)