# Authentication in the Python SDK {{ speechkit-name }}

{{ speechkit-name }} supports authentication with an [API key](../../../iam/concepts/authorization/api-key.md) and [IAM token](../../../iam/concepts/authorization/iam-token.md). To get authenticated, use one of the snippets below.

## Authentication with an API key {#api}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        api_key='<API_key>'
    )
)
```

Where `api_key` is the API key for the service account. You can learn how to create a key [here](../../../iam/operations/authentication/manage-api-keys.md#create-api-key).

## Authentication with an IAM token {#iam}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        iam_token='<IAM_token>'
    )
)
```

Where `iam_token` is the IAM token for the service account. You can learn how to create a token [here](../../../iam/operations/iam-token/create-for-sa.md).
