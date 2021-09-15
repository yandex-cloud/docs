To configure the SDK, create configuration files in your home folder and set the following in them:

- The default region in the file `.aws/config`:

   ```
   [default]
               region=ru-central1
   ```

   {% note info %}

   Some apps designed to work with Amazon S3 don't let you set the region, so {{ objstorage-name }} also accepts the value `us-east-1`.

   {% endnote %}

   Use the `s3.yandexcloud.net` address to access {{ objstorage-name }}.

