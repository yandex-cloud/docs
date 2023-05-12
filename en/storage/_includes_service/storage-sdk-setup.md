1. Go to the `~/.aws/` directory (for macOS and Linux) or `C:\Users\<username>\.aws\` (for Windows).
1. Create a file named `credentials` with authentication data for {{ objstorage-name }} and copy the following information to it:

   ```
   [default]
     aws_access_key_id = <static_key_ID>
     aws_secret_access_key = <secret_key>
   ```

1. Create a file named `config` with the default region parameters and copy the following information to it:

   ```
   [default]
     region={{ region-id }}
   ```

   {% note info %}

   Some apps designed to work with Amazon S3 don't let you set the region, so {{ objstorage-name }} also accepts the value `us-east-1`.

   {% endnote %}