# Creating authorized keys

To create [authorized keys](../../concepts/authorization/key.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Click **Create new key** in the top panel.
   1. Click **Create authorized key**.
   1. Select the encryption algorithm.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save both the public and private keys. The private key is not saved in {{ yandex-cloud }}, and you won't be able to view the public key in the management console.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Create authorized keys for the `my-robot` service account:

   ```bash
   yc iam key create --service-account-name my-robot -o my-robot-key.json
   ```

   If successful, a private key (`privateKey`) and public key ID (`id`) are written to the `my-robot-key.json` file.

   Key file example:

   ```json
   {
      "id": "lfkoe35hsk58aks301nl",
      "service_account_id": "ajepg0mjt06siua65usm",
      "created_at": "2019-03-20T10:04:56Z",
      "key_algorithm": "RSA_2048",
      "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
      "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   }
   ```

- API

   To create an access key, use the [create](../../api-ref/Key/create.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Create](../../api-ref/grpc/key_service.md#Create) gRPC API call.

   Sample request using cURL for the `create` REST API method:

   ```bash
   curl -X POST \
     -H 'Content-Type: application/json' \
     -H "Authorization: Bearer <iam-token>" \
     -d '{"serviceAccountId": "<service-account-id>"}' \
     https://iam.{{ api-host }}/iam/v1/keys
   ```

   Where:

   * `<iam-token>`: The IAM token of the user who has rights to view service accounts in the folder.
   * `<service-account-id>`: The `ID` of the service account that the keys are created for.

   If successful, the server response will contain the private key (`privateKey`) and public key ID (`id`). Save this data. You will not be able to get the key value again.

   Sample server response:

   ```json
   {
       "key": {
           "createdAt": "2018-10-30T15:55:00+00:00",
           "description": "",
           "id": "lfkoe35hsk58aks301nl",
           "keyAlgorithm": "RSA_2048",
           "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
           "serviceAccountId": "ajepg0mjt06siua65usm"
       },
       "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   }
   ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `service_account_id` = service account [ID](../sa/get-id.md). This parameter is required.
      * `description`: Key description. This is an optional parameter.
      * `key_algorithm`: Key generation algorithm. This is an optional parameter. The default algorithm is `RSA_2048`. For more information about the acceptable parameter values, see the [API documentation](../../api-ref/Key/index.md).
      * `pgp_key`: Additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in base64 encoding or in the `keybase:keybaseusername` format.

      Example of the configuration file structure:

      ```
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<service account ID>"
        description        = "<key description>"
        key_algorithm      = "<key generation algorithm>"
        pgp_key            = "<pgp key>"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_key).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Once you are done, all the resources you need will be created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following CLI command:

      ```
      yc iam key list --service-account-id <service account ID>
      ```

{% endlist %}

#### What's next {#what-is-next}

* [Get an IAM token for the service account](../iam-token/create-for-sa.md).