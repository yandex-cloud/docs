# Using the SDK for a function in Go

The runtime does not have a pre-installed library for accessing the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, add a [dependency](dependencies.md) to your Go application. The library source code is available on [GitHub](https://github.com/yandex-cloud/go-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources using the [service account](../../operations/function-sa.md) specified in the function parameters.

### Example

The following function receives a request with two fields (`FolderId` and `Tag`), gets authorized in the SDK, retrieves a list of all {{ compute-name }} VMs in the specified folder, filters them by the specified tag, and restarts those that are stopped. As a result, it returns a message with the number of running VMs.

{% note warning %}

To invoke the function, use the [{{ yandex-cloud }} CLI](../../concepts/function-invoke.md) or an HTTP request with the `?integration=raw` parameter.

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
  // Operation that starts the compute instance with the specified ID
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
  // Authorization in the SDK using a service account
  sdk, err := ycsdk.Build(ctx, ycsdk.Config{
    // Calling the InstanceServiceAccount method automatically requests an IAM token and uses it to generate
    // data required for authorization in the SDK.
    Credentials: ycsdk.InstanceServiceAccount(),
  })
  if err != nil {
    return nil, err
  }
  // Getting the compute instance list by FolderId specified in the request
  listInstancesResponse, err := sdk.Compute().Instance().List(ctx, &compute.ListInstancesRequest{
    FolderId: request.FolderId,
  })
  if err != nil {
    return nil, err
  }
  instances := listInstancesResponse.GetInstances()
  count := 0
  // Filtering the compute instance list: stopped instances containing the tag specified in the request.
  for _, i := range instances {
    labels := i.Labels
    if _, ok := labels[request.Tag]; ok && i.Status != compute.Instance_RUNNING {
      // Running the compute instances that meet the filter criteria
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

`go.mod`:

```golang
module example

go 1.14
```