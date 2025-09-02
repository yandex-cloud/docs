To generate a signing key:

1. Use the secret key to encode the date:

    ```
    DateKey = sign("AWS4" + SecretKey, "yyyymmdd")
    ```
   Where `SecretKey` is the secret part of your static access key, and `yyyymmdd` is the date in `YYYYMMDD` format, e.g., `20240920` for September 20, 2024.

1. Encode the region using `DateKey` you got in the previous step:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

1. Encode the service using `RegionKey` you got in the previous step:

    ```
    ServiceKey = sign(RegionKey, "ses")
    ```

1. Get the signing key:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```
