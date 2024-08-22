---
title: "Using the SDK for Kotlin functions in {{ sf-full-name }}: Overview"
description: "You can manage Kotlin functions in {{ sf-name }} using the SDK."
---

# Using the SDK for Kotlin functions

The [runtime environment](../../concepts/runtime/index.md) does not have a pre-installed library for accessing the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your Kotlin application. The library source code is available on [GitHub](https://github.com/yandex-cloud/java-sdk).

{% note warning %}

Out of the `java-sdk-serverless` and `java-sdk-functions` modules, only `java-sdk-serverless` is available for Kotlin. Other modules have no restrictions.

{% endnote %}

[SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) allows you to manage resources {{ yandex-cloud }} on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.

## Example {#example}

The following function receives the folder ID (`folderId`) as an input, gets authenticated in the SDK, retrieves a list of all {{ compute-name }} VMs in the specified folder, and restarts those that are stopped. As a result, it returns a message with the number of running instances.

Invoke the function using the [{{ yandex-cloud }} CLI](../../concepts/function-invoke.md) or an HTTP request with the `?integration=raw` parameter.

{% endnote %}

```kotlin
import yandex.cloud.api.compute.v1.InstanceOuterClass
import yandex.cloud.api.compute.v1.InstanceServiceGrpc
import yandex.cloud.api.compute.v1.InstanceServiceOuterClass
import yandex.cloud.sdk.ServiceFactory
import yandex.cloud.sdk.auth.Auth

fun handle(folderId: String): String {
    // Authorization in SDK via a service account
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
    // Getting a list of VMs based on folderId specified in the request
    val instances = instanceService.list(listInstancesRequest).instancesList
    var count = 0
    for (instance in instances) {
        if (instance.status != InstanceOuterClass.Instance.Status.RUNNING) {
            val startInstanceRequest =
                InstanceServiceOuterClass.StartInstanceRequest.newBuilder().setInstanceId(instance.id).build()
            // Starting VMs with VM IDs specified in the request
            val startInstanceResponse = instanceService.start(startInstanceRequest)
            if (!startInstanceResponse.hasError()) {
                count++
            }
        }
    }
    return "Started $count instances"
}
```
