```yaml
openapi: 3.0.0
info:
  title: for-serverless-hello-telegram-bot
  version: 1.0.0
paths:
  /sayhello.png:
    get:
      x-yc-apigateway-integration:
        type: object-storage
        bucket: ${BUCKET_NAME}
        object: ${OBJECT_NAME}
        presigned_redirect: false
        service_account: ${SA_ID}
      operationId: static
```