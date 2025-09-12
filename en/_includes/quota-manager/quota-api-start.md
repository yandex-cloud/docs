1. To check that you can work with quotas via the API, install these utilities:
     * [cURL](https://curl.haxx.se) if using the [REST API](../../quota-manager/api-ref/)
     * [gRPCurl](https://github.com/fullstorydev/grpcurl) if using the [gRPC API](../../quota-manager/api-ref/grpc/)
  
1. [Create a service account](../../iam/operations/sa/create.md) with the `quota-manager.viewer` [role](../../iam/operations/roles/grant.md).
  
1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md) for the created service account.
  