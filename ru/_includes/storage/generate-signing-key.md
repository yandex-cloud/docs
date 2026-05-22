Чтобы сгенерировать подписывающий ключ:

1. Закодируйте дату с помощью секретного ключа:

    ```
    DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
    ```

1. Закодируйте регион с помощью полученного на предыдущем шаге ключа `DateKey`:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

1. Закодируйте сервис с помощью полученного на предыдущем шаге ключа `RegionKey`:

    ```
    ServiceKey = sign(RegionKey, "s3")
    ```

1. Получите подписывающий ключ:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```

{% note info %}

Подписывающий ключ действителен в течение нескольких минут, после этого его использование может привести к ошибке 403 — `RequestTimeTooSkewed`. Регулярно обновляйте подписывающий ключ, чтобы продлить его срок действия.

Для генерации подписывающего ключа AWS SDK использует локальное системное время. 

  {% cut "Если локальное системное время некорректно" %}

  Вы можете использовать функцию получения реального времени, например [v4.SignSDKRequestWithCurrentTime](https://pkg.go.dev/github.com/aws/aws-sdk-go/aws/signer/v4#SignSDKRequestWithCurrentTime) в AWS SDK для Go:

  ```Go
  client := s3.New(sess)
  client.Handlers.Sign.Swap(v4.SignRequestHandler.Name, request.NamedHandler{
      Name: v4.SignRequestHandler.Name,
      Fn: func(r *request.Request) {
          v4.SignSDKRequestWithCurrentTime(r, currentTimeFn)
      },
  })
  ```

  {% endcut %}

{% endnote %}
