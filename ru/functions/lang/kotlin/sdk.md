---
title: Использование SDK для функции на Kotlin в {{ sf-full-name }}. Обзор
description: Вы можете управлять функцией {{ sf-name }} на Kotlin с помощью SDK.
---

# Использование SDK для функции на Kotlin

[Среда выполнения](../../concepts/runtime/index.md) не содержит предустановленной библиотеки для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для ее использования требуется добавить [зависимость](dependencies.md) в приложение на Kotlin. Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/java-sdk).

{% note warning %}

Из модулей `java-sdk-serverless` и `java-sdk-functions` для Kotlin доступен только модуль `java-sdk-serverless`. На остальные модули ограничений нет.

{% endnote %}

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции.

## Пример {#example}

Следующая функция получает на вход идентификатор каталога (`folderId`), авторизуется в SDK, получает список всех виртуальных машин {{ compute-name }} в заданном каталоге и запускает остановленные машины. В качестве результата возвращает сообщение-отчет с количеством запущенных машин.

Вызывайте функцию с помощью [CLI {{ yandex-cloud }}](../../concepts/function-invoke.md) или HTTP-запроса с параметром `?integration=raw`.

{% endnote %}

```kotlin
import yandex.cloud.api.compute.v1.InstanceOuterClass
import yandex.cloud.api.compute.v1.InstanceServiceGrpc
import yandex.cloud.api.compute.v1.InstanceServiceOuterClass
import yandex.cloud.sdk.ServiceFactory
import yandex.cloud.sdk.auth.Auth

fun handle(folderId: String): String {
    // Авторизация в SDK через сервисный аккаунт
    val defaultComputeEngine = Auth.computeEngineBuilder().build()
    val factory = ServiceFactory.builder()
        .credentialProvider(defaultComputeEngine)
        .build()
    val instanceService = factory.create(
        InstanceServiceGrpc.InstanceServiceBlockingStub::class.java,
        InstanceServiceGrpc::newBlockingStub
    )
    val listInstancesRequest =
        InstanceServiceOuterClass.ListInstancesRequest.newBuilder().setFolderId(folderId).build()
    // Получение списка ВМ по заданному в запросе folderId
    val instances = instanceService.list(listInstancesRequest).instancesList
    var count = 0
    for (instance in instances) {
        if (instance.status != InstanceOuterClass.Instance.Status.RUNNING) {
            val startInstanceRequest =
                InstanceServiceOuterClass.StartInstanceRequest.newBuilder().setInstanceId(instance.id).build()
            // Запуск ВМ с указанными в запросе идентификаторами ВМ
            val startInstanceResponse = instanceService.start(startInstanceRequest)
            if (!startInstanceResponse.hasError()) {
                count++
            }
        }
    }
    return "Started $count instances"
}
```