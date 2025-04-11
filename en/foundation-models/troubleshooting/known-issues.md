# External errors when working with models

See [Error codes](../troubleshooting/error-codes.md) for the list of critical errors you may get when working with {{ foundation-models-name }} and their troubleshooting tips. Sometimes you may also get external errors related to the libraries in use.

## gRPC shutdown timeout {#grpc-timeout}

Requests to the model may result in the following errors:

```text
[E0000 00:00:1733492154.123700 97069859 init.cc:229] grpc_wait_for_shutdown_with_timeout() timed out.
```

There errors are generated in the terminal when writing logs. The issue is caused by the `grpcio==1.68.1` [library](https://pypi.org/project/grpcio/) version. To resolve the errors, update the library version or roll back to a previous one, for example:

```bash
pip install grpcio==1.67.1
```