To generate a signing key:

1. Use the secret key to encode the date:

    ```
    DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
    ```

1. Encode the region using the `DateKey` you got in the previous step:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

1. Encode the service using the `RegionKey` you got in the previous step:

    ```
    ServiceKey = sign(RegionKey, "s3")
    ```

1. Get the signing key:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```
