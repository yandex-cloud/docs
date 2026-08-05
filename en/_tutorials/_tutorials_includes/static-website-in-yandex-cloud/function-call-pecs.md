The function is [invoked](*function_call) using a dedicated function URL: `https://{{ sf-url }}/<function_ID>`. However, attempting to call the function directly from a website page in a browser will fail with an error: the browser will block the request because the function URL and the website have different origins.

For the function call to succeed, the function must support [preflight](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing#Preflight_example) requests and return a response with the correct [CORS](*cors) headers.

You can implement preflight request handling in {{ sf-name }}. However, a simpler solution is to use an API gateway with the [x-yc-apigateway-cors](*api_gw_cors) specification extension to invoke the function.

{% cut "Example of an API gateway specification with the `x-yc-apigateway-cors` extension." %}

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Mailer API
servers:
- url: https://d5dglu90r7y0********.wm******.apigw.yandexcloud.net
paths:
  /register:
    x-yc-apigateway-cors:
      origin:
        - https://my.example.com
      methods:
        - POST
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: d4edj6bo1uy0********
        service_account_id: ajekjkm28y0********
```

An API gateway created using the specification from the example above allows you to call the `d4edj6bo1uy0********` function at `https://d5dglu90r7y0********.wm******.apigw.yandexcloud.net/register` from website pages hosted in the `https://my.example.com` domain.

{% note info %}

The `d4edj6bo1uy0********` function is not public. To call this function, you need a [service account](*service_account) with the `functions.functionInvoker` [role](*functions_invoker).

{% endnote %}

{% endcut %}