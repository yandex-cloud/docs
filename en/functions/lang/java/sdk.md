# Using the SDK for Java functions

The runtime environment does not have a pre-installed library for working with the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your Java application. The library source code is available on [GitHub](https://github.com/yandex-cloud/java-sdk). The availability of library modules depends on the language version:

* `java-sdk-functions`: Only for Java 11.
* `java-sdk-serverless`: Java 17 or higher.

Other modules are available for any version of Java.

[SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) lets you manage resources {{ yandex-cloud }} on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.

### Example {#example}

The following function receives the `folderId` as an input, authorizes in the SDK, gets a list of all {{ compute-name }} instances in the specified folder, and restarts stopped instances. As a result, it returns a message with the number of running instances.

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
    // SDK authorization using service account
    var defaultComputeEngine = Auth.computeEngineBuilder().build();
    var factory = ServiceFactory.builder()
            .credentialProvider(defaultComputeEngine)
            .build();
    var instanceService = factory.create(InstanceServiceGrpc.InstanceServiceBlockingStub.class, InstanceServiceGrpc::newBlockingStub);
    var listInstancesRequest = InstanceServiceOuterClass.ListInstancesRequest.newBuilder().setFolderId(folderId).build();
    // Retrieving Compute Instance list based on FolderId in request
    var listInstancesResponse = instanceService.list(listInstancesRequest);
    var instances = listInstancesResponse.getInstancesList();
    var count = 0;
    for (var instance : instances) {
      if (instance.getStatus() != InstanceOuterClass.Instance.Status.RUNNING) {
        var startInstanceRequest = InstanceServiceOuterClass.StartInstanceRequest.newBuilder().setInstanceId(instance.getId()).build();
        // Launching Compute Instance with specifid ID
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
