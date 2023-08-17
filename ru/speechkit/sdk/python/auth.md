# Аутентификация в Python SDK {{ speechkit-name }}

{{ speechkit-name }} поддерживает аутентификацию по [API-ключу](../../../iam/concepts/authorization/api-key.md) и [IAM-токену](../../../iam/concepts/authorization/iam-token.md). Чтобы пройти ее, используйте один из сниппетов ниже.

## Аутентификация по API-ключу {#api}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        api_key='<API-ключ>'
    )
)
```

Где `api_key` — API-ключ для сервисного аккаунта. Подробнее о том, [как создать ключ](../../../iam/operations/api-key/create.md).

## Аутентификация по IAM-токену {#iam}

```python
from speechkit import configure_credentials, creds

configure_credentials(
    yandex_credentials=creds.YandexCredentials(
        iam_token='<IAM-токен>'
    )
)
```

Где `iam_token` — IAM-токен для сервисного аккаунта. Подробнее о том, [как создать токен](../../../iam/operations/iam-token/create-for-sa.md).
