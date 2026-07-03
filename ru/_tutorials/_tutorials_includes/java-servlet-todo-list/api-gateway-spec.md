```yaml
openapi: 3.0.0
info:
  title: ToDo list
  version: 1.0.0
paths:
  /:
    get:
      x-yc-apigateway-integration:
        type: object-storage
        bucket: <имя_бакета>
        object: index.html
        presigned_redirect: false
        service_account_id: <идентификатор_сервисного_аккаунта>
      operationId: static
  /add:
      post:
        x-yc-apigateway-integration:
          type: cloud-functions
          function_id: <идентификатор_функции_add-task>
        operationId: addTask
  /list:
    get:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <идентификатор_функции_list-tasks>
      operationId: listTasks
  /delete:
    delete:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <идентификатор_функции_delete-task>
      operationId: deleteTask
```