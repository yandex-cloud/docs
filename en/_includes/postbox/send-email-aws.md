1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
1. Set up the AWS CLI:
    1. Launch the interactive profile setup:
        ```
        aws configure
        ```
    1. Specify the previously obtained key ID of the `postbox-user` service account:
        ```
        AWS Access Key ID [****************ver_]: <service_account_key_ID>
        ```
    1. Specify the previously obtained secret key of the `postbox-user` service account:
        ```
        AWS Secret Access Key [****************w5lb]: <service_account_secret_key>
        ```
    1. Specify the {{ region-id }} default region name:
        ```
        Default region name [{{ region-id }}]: {{ region-id }}
        ```
    1. Specify `JSON` as the default format for output data:
        ```
        Default output format [None]: json
        ```

1. Prepare two JSON files:

    * `destination.json`: File with a list of destination addresses:

        ```json
        {
          "ToAddresses": ["test@example.com"]
        }
        ```

    * `message.json`: File with the subject and content of the email:

       ```json
       {
         "Simple": {
           "Subject": {
             "Data": "Test message",
             "Charset": "UTF-8"
           },
           "Body": {
             "Text": {
               "Data": "Test message. Hello!",
               "Charset": "UTF-8"
             }
           }
         }
       }
       ```

1. Send an email using the AWS CLI:

    ```bash
    aws sesv2 send-email \
      --from-email-address mail@example.com \
      --destination file://destination.json \
      --content file://message.json \
      --endpoint-url {{ postbox-endpoint }}
    ```

1. Check the mailbox specified in `destination.json` for the email.