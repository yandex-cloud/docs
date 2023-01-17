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
     region={{ region-id }}
   ```
   {% note info %}

   Some apps designed to work with Amazon S3 don't let you set the region, so {{ objstorage-name }} also accepts the value `us-east-1`.

   {% endnote %}