1. Launch the interactive profile setup:

   ```bash
   aws configure
   ```

1. Specify the service account key ID you obtained earlier:

   ```bash
   AWS Access Key ID [****************ver_]: <service_account_key_ID>
   ```

1. Specify the service account secret key you obtained earlier:

   ```bash
   AWS Secret Access Key [****************w5lb]: <service_account_secret_key>
   ```

1. Specify the `{{ region-id }}` default region name:

   ```bash
   Default region name [{{ region-id }}]: {{ region-id }}
   ```

1. Specify `json` as the default format for output data:

   ```bash
   Default output format [None]: json
   ```

1. To view the current profile settings, run this command:

   ```bash
   aws configure list
   ```

   Result:

   ```text
         Name                    Value             Type    Location
         ----                    -----             ----    --------
      profile                <not set>             None    None
   access_key     ****************aBc1 shared-credentials-file
   secret_key     ****************DeF2 shared-credentials-file
       region              {{ region-id }}      config-file    ~/.aws/config
   ```