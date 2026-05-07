To generate a signing key:

1. Use the secret key to encode the date:

    ```
    DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
    ```

1. Encode the region using `DateKey` you got in the previous step:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

1. Encode the service using `RegionKey` you got in the previous step:

    ```
    ServiceKey = sign(RegionKey, "s3")
    ```

1. Get the signing key:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```

{% note info %}

The signing key is valid for several minutes; after that time, its use may result in error 403: `RequestTimeTooSkewed`. Refresh the signing key regularly to extend its validity period.

The AWS SDK uses local system time to generate the signing key. 

  {% cut "If local system time is incorrect" %}

  You can use a real-time fetching function, e.g., [v4.SignSDKRequestWithCurrentTime](https://pkg.go.dev/github.com/aws/aws-sdk-go/aws/signer/v4#SignSDKRequestWithCurrentTime) in the AWS SDK for Go:

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
