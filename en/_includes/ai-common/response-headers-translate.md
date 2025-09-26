Each server response contains headers that provide even more information about request execution, e.g., `x-server-trace-id`, which is the unique request execution log ID.

To get the `x-server-trace-id` value, your application must log server response headers. 

You can find an example of implementing access to gRPC headers in the [`grpc-go` documentation](https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md).