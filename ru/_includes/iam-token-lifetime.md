[Время жизни](../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}, но рекомендуется запрашивать его чаще, например каждый час.

Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.
