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
        bucket: <bucket_name>
        object: index.html
        presigned_redirect: false
        service_account_id: <service_account_ID>
      operationId: static
  /add:
      post:
        x-yc-apigateway-integration:
          type: cloud-functions
          function_id: <add-task_function_ID>
        operationId: addTask
  /list:
    get:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <list-tasks_function_ID>
      operationId: listTasks
  /delete:
    delete:
      x-yc-apigateway-integration:
        type: cloud-functions
        function_id: <delete-task_function_ID>
      operationId: deleteTask
```