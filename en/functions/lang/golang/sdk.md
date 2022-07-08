# Using the SDK for Go functions

The runtime environment doesn't have a pre-installed library for working with the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your Go application. The library source code is available on [GitHub](https://github.com/yandex-cloud/go-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.

### Example:

The following function receives a request with two fields (`FolderId` and `Tag`) as an input, authorizes in the SDK, gets a list of all {{ compute-name }} instances in the specified folder, filters them by the specified tag, and restarts the stopped instances. As a result, it returns a message with the number of running instances.

{% note warning %}

To invoke the function, use the [YC CLI](../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

```golang
package main

import (
  "context"
  "fmt"
  "github.com/yandex-cloud/go-genproto/yandex/cloud/compute/v1"
  "github.com/yandex-cloud/go-genproto/yandex/cloud/operation"
  "github.com/yandex-cloud/go-sdk"
)

func startComputeInstance(ctx context.Context, sdk *ycsdk.SDK, id string) (*operation.Operation, error) {
  // Launching Compute Instance with the specified ID
  return sdk.Compute().Instance().Start(ctx, &compute.StartInstanceRequest{
    InstanceId: id,
  })
}

type Request struct {
  FolderId string `json:"folderId"`
  Tag      string `json:"tag"`
}

type Response struct {
  StatusCode int         `json:"statusCode"`
  Body       interface{} `json:"body"`
}

func StartComputeInstances(ctx context.Context, request *Request) (*Response, error) {
  // SDK authorization using service account
  sdk, err := ycsdk.Build(ctx, ycsdk.Config{
    // Invoking InstanceServiceAccount automatically requests IAM token and uses
    // it to generate SDK authorization credentials
    Credentials: ycsdk.InstanceServiceAccount(),
  })
  if err != nil {
    return nil, err
  }
  // Retrieving Compute Instance list based on FolderId in request
  listInstancesResponse, err := sdk.Compute().Instance().List(ctx, &compute.ListInstancesRequest{
    FolderId: request.FolderId,
  })
  if err != nil {
    return nil, err
  }
  instances := listInstancesResponse.GetInstances()
  count := 0
  // Applying filter to Compute Instance list, filter: deactivated, tags include tag specified in request
  for _, i := range instances {
    labels := i.Labels
    if _, ok := labels[request.Tag]; ok && i.Status != compute.Instance_RUNNING {
      // Launching Compute Instances matching filter criteria
      _, err := startComputeInstance(ctx, sdk, i.GetId())
      if err != nil {
        return nil, err
      }
      count++
    }
  }
  return &Response{
    StatusCode: 200,
    Body:       fmt.Sprintf("Started %d instances", count),
  }, nil
}
```

The `go.mod` file:

```golang
module example

go 1.14
```
