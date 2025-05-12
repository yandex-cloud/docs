# Using the SDK for Go functions

The runtime environment does not have a pre-installed library for accessing the [{{ yandex-cloud }} API](../../../api-design-guide/). To use the library, add a [dependency](dependencies.md) to your Go application. The library source code is available on [GitHub](https://github.com/yandex-cloud/go-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters.

### For example:

The following function receives a request with two fields (`FolderId` and `Tag`) as an input, gets authorized in the SDK, gets a list of all {{ compute-name }} instances in the specified folder, filters them by the specified tag, and restarts the stopped instances. As a result, it returns a message with the number of running instances.

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
  // Operation that runs the Compute Instance with the specified ID
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
    // Calling the InstanceServiceAccount method automatically requests an IAM token and generates
    // data required for authorization in the SDK using this token
    Credentials: ycsdk.InstanceServiceAccount(),
  })
  if err != nil {
    return nil, err
  }
  // Getting the Compute Instance list by the FolderId specified in the request
  listInstancesResponse, err := sdk.Compute().Instance().List(ctx, &compute.ListInstancesRequest{
    FolderId: request.FolderId,
  })
  if err != nil {
    return nil, err
  }
  instances := listInstancesResponse.GetInstances()
  count := 0
  // Filtering the Compute Instance list using the filter: disabled, tags contain the tag specified in the request
  for _, i := range instances {
    labels := i.Labels
    if _, ok := labels[request.Tag]; ok && i.Status != compute.Instance_RUNNING {
      // Running the Compute Instances that meet the filtering criteria
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

`go.mod` file:

```golang
module example

go 1.14
```