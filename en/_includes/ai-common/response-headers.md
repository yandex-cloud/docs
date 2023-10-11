Each server response contains headers that provide even more information about the request execution:

* `x-request-id`: Unique response ID
* `x-server-trace-id`: Unique request execution log ID

To be able to retrieve the `x-request-id` and `x-server-trace-id` values, your application must log server response headers.

You can check an implementation example for access to gRPC headers in the [`grpc-go` library documentation](https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md).