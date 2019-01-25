# Create static access keys

Create [static access keys](../../concepts/users/service-accounts.md#access-keys) for a service account.

---

**[!TAB Management console]**

1. Go to the folder that the service account belongs to.
1. Select the **Service accounts** tab.
1. In the line with the service account name, click ![image](../../../_assets/vertical-ellipsis.svg) and select **Create access key**.
1. Save the ID and private key. After the dialog is closed, the private key value will be unavailable.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

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

**[!TAB API]**

To create a service account, use the [create](../../api-ref/AccessKey/create.md) method for the [ServiceAccount](../../api-ref/AccessKey/index.md) resource.

---

## Examples

### Add a description when creating

Add a description when creating an access key.

---

**[!TAB CLI]**

```
$ yc iam access-key create --service-account-name my-robot \
    --description "this key is for my bucket"
```

**[!TAB API]**

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

---

#### What's next

- [Customize tools to work with [!KEYREF objstorage-name]](../../../storage/instruments/)
- [[!TITLE]](assign-role-for-sa.md)

