# Creating API keys

These are instructions for how to create an [API key](../../concepts/authorization/api-key.md) for a [service account](../../concepts/users/service-accounts.md). The _API key_ is a secret key used for simplified authorization in the {{ yandex-cloud }} API.

If you don't have a service account yet, [create one](../sa/create.md) and [assign it roles](../sa/assign-role-for-sa.md).

To create an API key:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Click **Create new key** in the top panel.
   1. Click **Create API key**.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save the ID and private key.

      {% note alert %}

      After the dialog is closed, the private key value will be unavailable.

      {% endnote %}

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the create API key command:

      ```bash
      yc iam api-key create --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

   1. Create an API key for the `my-robot` service account and write the response to a file:

      ```bash
      yc iam api-key create --service-account-name my-robot > api-key.yaml
      ```

      The response's `secret` property will contain the API key:

      ```
      api_key:
        id: ajeke74kbp5bfq7m6ka2
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
      ```

      For information about how to pass the key in a request, read the documentation of the [services](../../concepts/authorization/api-key.md#supported-services) that support this authorization method.

- API

   1. [Find out the service account ID](../sa/get-id.md).
   1. Create an API key using the [create](../../api-ref/ApiKey/create.md) method for the [ApiKey](../../api-ref/ApiKey/index.md) resource.

      ```bash
      export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $IAM_TOKEN" \
        -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
        https://iam.api.cloud.yandex.net/iam/v1/apiKeys
      ```

{% endlist %}

## Examples {#examples}

### Add a description when creating {#add-description}

To make it easier to find an API key without knowing its ID, add a description when creating it:

{% list tabs %}

- CLI

   ```bash
   yc iam api-key create --service-account-name my-robot \
     --description "this API-key is for my-robot"
   ```

- API

   ```bash
   export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
   export IAM_TOKEN=CggaATEVAgA...
   curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $IAM_TOKEN" \
     -d "{
         \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
         \"description\": \"this API-key is for my-robot\"
     }" \
     https://iam.api.cloud.yandex.net/iam/v1/apiKeys
   ```

{% endlist %}

#### What's next {#what-is-next}

* [Find out what services support API keys](../../concepts/authorization/api-key.md#supported-services).
