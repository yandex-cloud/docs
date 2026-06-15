```yaml
  /fshtb-function:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <function_ID>
      operationId: fshtb-function
```

Where `function_id` is the `fshtb-function` ID.