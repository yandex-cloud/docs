---
title: Using the SDK for Java functions in {{ sf-full-name }}. Overview
description: You can manage Java functions in {{ sf-name }} using the SDK.
---

# Using the SDK for Java functions

The [runtime environment](../../concepts/runtime/index.md) does not have a pre-installed library for accessing the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your Java application. The library source code is available on [GitHub](https://github.com/yandex-cloud/java-sdk). The availability of library modules depends on the language version:

* `java-sdk-functions`: Only for Java 11.
* `java-sdk-serverless`: For Java 17 or higher.

Other modules are available for any version of Java.

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.

## Example {#example}

The following function gets the folder ID (`folderId`) as an input, gets authorized in the SDK, retrieves a list of all {{ compute-name }} VMs in the specified folder, and restarts those that are stopped. As a result, it returns a message with the number of running instances.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../concepts/function-invoke.md) or an HTTP request with the `?integration=raw` parameter.

{% endnote %}

```java
import yandex.cloud.api.compute.v1.InstanceOuterClass;
import yandex.cloud.api.compute.v1.InstanceServiceGrpc;
import yandex.cloud.api.compute.v1.InstanceServiceOuterClass;
import yandex.cloud.sdk.ServiceFactory;
import yandex.cloud.sdk.auth.Auth;

import java.util.function.Function;

public class Handler implements Function<String, String> {
  @Override
  public String apply(String folderId) {
    // Getting authorized in the SDK via the service account
    var defaultComputeEngine = Auth.computeEngineBuilder().build();
    var factory = ServiceFactory.builder()
            .credentialProvider(defaultComputeEngine)
            .build();
    var instanceService = factory.create(InstanceServiceGrpc.InstanceServiceBlockingStub.class, InstanceServiceGrpc::newBlockingStub);
    var listInstancesRequest = InstanceServiceOuterClass.ListInstancesRequest.newBuilder().setFolderId(folderId).build();
    // Getting a list of VMs based on `folderId` specified in the request
    var listInstancesResponse = instanceService.list(listInstancesRequest);
    var instances = listInstancesResponse.getInstancesList();
    var count = 0;
    for (var instance : instances) {
      if (instance.getStatus() != InstanceOuterClass.Instance.Status.RUNNING) {
        var startInstanceRequest = InstanceServiceOuterClass.StartInstanceRequest.newBuilder().setInstanceId(instance.getId()).build();
        // Starting a VM with IDs specified in the request
        var startInstanceResponse = instanceService.start(startInstanceRequest);
        if (!startInstanceResponse.hasError()) {
          count++;
        }
      }
    }
    return String.format("Started %d instances", count);
  }
}
```