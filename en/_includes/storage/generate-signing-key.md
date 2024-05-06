To generate a signing key, you need static access keys for {{ objstorage-name }}. To learn how to get them, see [Before you start](../../storage/s3/index.md#before-you-begin).

Generate a signing key

1. Use the secret key to encode the date:

   ```
   DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
   ```

1. Encode the region using the `DateKey` obtained in the previous step:

   ```
   RegionKey = sign(DateKey, "{{ region-id }}")
   ```

1. Encode the service using the `RegionKey` obtained in the previous step:

   ```
   ServiceKey = sign(RegionKey, "s3")
   ```

1. Get a signing key:

   ```
   SigningKey = sign(ServiceKey, "aws4_request")
   ```
