# Create an API key

Instructions for how to create [API keys](../../concepts/users/service-accounts.md#access-keys) for a [service account](../../concepts/users/service-accounts.md). If you don't have a service account yet, [create one](../sa/create.md) and [configure access rights](../sa/assign-role-for-sa.md) for it.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the create API key command:

    ```
    $ yc iam api-key create --help
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

1. Create an API key for the `my-robot` service account and write the response to a file:

    ```
    $ yc iam api-key create --service-account-name my-robot > api-key.yaml
    ```

    The response's `secret` property will contain the API key:

    ```
    api_key:
      id: ajeke74kbp5bfq7m6ka2
      service_account_id: ajepg0mjt06siuj65usm
      created_at: "2019-04-09T08:41:27Z"
    secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
    ```

    For information about how to pass the key in a request, read the documentation on the [services](../../concepts/authorization/api-key.md#supported-services) that support this authorization method.

**[!TAB API]**

1. [Find out the service account ID](../sa/get-id.md).

2. Create an API key using the [create](../../api-ref/ApiKey/create.md) method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

    ```bash
    $ export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $IAM_TOKEN" \
        -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
        https://iam.api.cloud.yandex.net/iam/v1/apiKeys
    ```

---

## Examples

### Create with a description

To make it easier to find an API key without knowing its ID, add a description when creating it:

---

**[!TAB CLI]**

```bash
$ yc iam api-key create --service-account-name my-robot \
    --description "this API-key is for my-robot"
```

**[!TAB API]**

```bash
$ export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"description\": \"this API-key is for my-robot\"
    }" \
    https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```

---

#### What's next

- [Find out what services support API keys](../../concepts/authorization/api-key.md#supported-services)

