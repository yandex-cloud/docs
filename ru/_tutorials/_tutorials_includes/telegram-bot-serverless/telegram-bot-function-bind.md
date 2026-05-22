```yaml
  /fshtb-function:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <идентификатор_функции>
      operationId: fshtb-function
```

Где `function_id` — идентификатор функции `fshtb-function`.