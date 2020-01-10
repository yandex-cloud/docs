# Creating authorized keys

To create [authorized keys](../../concepts/authorization/key.md):

{% list tabs %}

- Management console
  1. Go to the folder that the service account belongs to.
  1. Go to the **Service accounts** tab.
  1. Choose a service account and click the line with its name.
  1. Click **Create new key** in the top panel.
  1. Click **Create authorized key**.
  1. Enter a description of the key so that you can easily find it in the management console.
  1. Save both the public and private keys. The private key is not saved in Yandex.Cloud, and you won't be able to view the public key in the management console.

- CLI

  Create authorized keys for the `my-robot` service account:

  ```
  $  yc iam key create --service-account-name my-robot -o my-robot-key.json
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

  To create an access key, use the [create](../../api-ref/Key/create.md) method for the [Key](../../api-ref/Key/index.md) resource.

  Sample request using cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{"serviceAccountId": "<SERVICE-ACCOUNT-ID>"}' \
      https://iam.api.cloud.yandex.net/iam/v1/keys
  ```

  where:
  * `<IAM-TOKEN>` is the IAM token of the user who has rights to view service accounts in the folder.
  * `<SERVICE-ACCOUNT-ID>` is the `ID` of the service account that the keys are created for.

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

{% endlist %}

#### What's next {#what-is-next}

* [Get an IAM token for the service account](../iam-token/create-for-sa.md)

