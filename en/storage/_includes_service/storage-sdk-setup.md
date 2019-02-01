To configure the SDK, create configuration files in your home folder and set the following in them:

- The static key in the file `.aws/credentials`:

   ```
   [default]
               aws_access_key_id = <id>
               aws_secret_access_key = <secretKey>
   ```

- The default region in the file `.aws/config`:

   ```
   [default]
               region=us-east-1
   ```

   > [!NOTE]
   > 
   > To work with Yandex Object Storage, always specify the `us-east-1` region. A different value of the region may lead to an authorization error.

To access [!KEYREF objstorage-name], use the address `[!KEYREF s3-storage-host]`.

