# Authentication in the Python SDK {{ speechkit-name }}

{{ speechkit-name }} supports authentication with an [API key](../../../iam/concepts/authorization/api-key.md) and [IAM token](../../../iam/concepts/authorization/iam-token.md). To get authenticated, use one of the snippets below.

## Authentication with an API key {#api}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        api_key='<API key>'
    )
)
```

Where `api_key` is the service account's API key. You can learn how to create a key [here](../../../iam/operations/api-key/create.md).

## Authentication with an IAM token {#iam}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        iam_token='<IAM token>'
    )
)
```

Where `iam_token` is the service account's IAM token. You can learn how to create a token [here](../../../iam/operations/iam-token/create-for-sa.md).
