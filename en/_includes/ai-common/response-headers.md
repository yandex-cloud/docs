Each server response contains headers that provide even more information about the request execution:

* `x-request-id`: Unique response ID
* `x-server-trace-id`: Unique request execution log ID

To get the `x-request-id` and `x-server-trace-id` values, your application must log server response headers.

You can find an example of implementing access to gRPC headers in the [`grpc-go` documentation](https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md).