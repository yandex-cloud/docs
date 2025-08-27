1. Чтобы проверить работу с квотами через API, установите утилиты:
     * [cURL](https://curl.haxx.se) при использовании [REST API](../../quota-manager/api-ref/).
     * [gRPCurl](https://github.com/fullstorydev/grpcurl) при использовании [gRPC API](../../quota-manager/api-ref/grpc/).
  
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/operations/roles/grant.md) `quota-manager.viewer`.
  
1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
  