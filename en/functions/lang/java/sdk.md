# Using the SDK

The runtime doesn't have a pre-installed library that lets you access the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your application. See the library's source code on [GitHub](https://github.com/yandex-cloud/java-sdk).

[Software development kits (SDK)](https://en.wikipedia.org/wiki/Software_development_kit) let you interact with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the function.

### Example:

The following function receives the `folderId` as an input, authorizes in the SDK, gets a list of all {{ compute-name }} instances in the specified folder, and restarts stopped instances. As a result, it returns a message with the number of running instances.

{% note warning %}

Invoke the function using the [YC CLI](../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

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
    // Authorization in the SDK using a service account
    var defaultComputeEngine = Auth.computeEngineBuilder().build();
    var factory = ServiceFactory.builder()
            .credentialProvider(defaultComputeEngine)
            .build();
    var instanceService = factory.create(InstanceServiceGrpc.InstanceServiceBlockingStub.class, InstanceServiceGrpc::newBlockingStub);
    var listInstancesRequest = InstanceServiceOuterClass.ListInstancesRequest.newBuilder().setFolderId(folderId).build();
    // Getting the Compute Instance list by the FolderId specified in the request
    var listInstancesResponse = instanceService.list(listInstancesRequest);
    var instances = listInstancesResponse.getInstancesList();
    var count = 0;
    for (var instance : instances) {
      if (instance.getStatus() != InstanceOuterClass.Instance.Status.RUNNING) {
        var startInstanceRequest = InstanceServiceOuterClass.StartInstanceRequest.newBuilder().setInstanceId(instance.getId()).build();
        // Operation that runs the Compute Instance with the specified ID
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

