# Creating static access keys

Instructions for how to create [static access keys](../../concepts/authorization/access-key.md) for [service accounts](../../concepts/users/service-accounts.md).

If you don't have a service account yet, [create one](../sa/create.md) and [assign it roles](../sa/assign-role-for-sa.md).

To create a static access key:

{% list tabs %}

- Management console

  1. Go to the folder that the service account belongs to.

  1. Go to the **Service accounts** tab.

  1. Choose a service account and click the line with its name.

  1. Click **Create new key** in the top panel.

  1. Click **Create static access key**.

  1. Enter a description of the key so that you can easily find it in the management console.

  1. Save the ID and private key.

      {% note alert %}

      After the dialog is closed, the private key value will be unavailable.

      {% endnote %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the create static access key command:

      ```
      $ yc iam access-key create --help
      ```

  1. Select a service account (for example, `my-robot`):

      ```
      $ yc iam service-account list
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

  1. Create an access key for the `my-robot` service account:

      ```
      $ yc iam access-key create --service-account-name my-robot

      access_key:
        id: aje6t3vsbj8lp9r4vk2u
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2018-11-22T14:37:51Z"
        key_id: 0n8X6WY6S24N7OjXQ0YQ
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
      ```

  1. Save the ID `key_id` and private key `secret`. You will not be able to get the key value again.

- API

  To create an access key, use the [create](../../api-ref/AccessKey/create.md) method for the [AccessKey](../../api-ref/AccessKey/index.md) resource.

{% endlist %}

## Examples {#examples}

### Add a description when creating {#add-description}

Add a description when creating an access key.

{% list tabs %}

- CLI

  ```
  $ yc iam access-key create --service-account-name my-robot \
      --description "this key is for my bucket"
  ```

- API

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
          "serviceAccountId": "aje6o61dvog2h6g9a33s",
          "description": "this key is for my bucket"
      }' \
      https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys
  ```

{% endlist %}

#### What's next {#what-is-next}

- [Configuring tools to work with {{ objstorage-name }}](../../../storage/tools/)
- [{#T}](assign-role-for-sa.md)

