Для аутентификации в [AWS S3 API](../../storage/s3/api-ref/) вы можете использовать:


* [IAM-токен](../../iam/concepts/authorization/iam-token.md);
* [статический ключ доступа](../../iam/concepts/authorization/access-key.md);
* [временные ключи {{ sts-name }}](../../iam/concepts/authorization/sts.md);
* [эфемерные ключи доступа](../../iam/concepts/authorization/ephemeral-keys.md).


{% note warning %}

Рекомендованным способом аутентификации в AWS S3 API является аутентификация с помощью IAM-токена: этот способ более безопасен и, в отличие от аутентификации с помощью статического ключа, не требует создания [подписи запроса](../../storage/s3/signing-requests.md).

{% endnote %}