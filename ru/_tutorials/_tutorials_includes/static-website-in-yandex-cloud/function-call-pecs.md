[Вызов](*function_call) функции осуществляется по специальному URL функции `https://{{ sf-url }}/<идентификатор_функции>`. При этом попытка прямого вызова функции со страницы сайта в браузере завершится ошибкой: браузер заблокирует запрос, поскольку у URL функции и у сайта разные источники.

Чтобы вызов функции выполнился успешно, функция должна поддерживать предварительный ([preflight](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing#Preflight_example)) запрос и возвращать ответ с корректными заголовками [CORS](*cors).

Можно реализовать обработку preflight-запросов в функции {{ sf-name }}. Но существует простой способ решения этой проблемы — использовать для вызова функции API-шлюз с расширением спецификации [x-yc-apigateway-cors](*api_gw_cors).

{% cut "Пример спецификации API-шлюза с расширением `x-yc-apigateway-cors`." %}

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

API-шлюз, созданный по спецификации из примера, позволяет вызывать функцию {{ sf-name }} `d4edj6bo1uy0********` по адресу `https://d5dglu90r7y0********.wm******.apigw.yandexcloud.net/register` со страниц сайта, размещенных на домене `https://my.example.com`.

{% note info %}

Поскольку функция `d4edj6bo1uy0********` не является публичной, для ее вызова используется [сервисный аккаунт](*service_account), которому назначена [роль](*functions_invoker) `functions.functionInvoker`.

{% endnote %}

{% endcut %}