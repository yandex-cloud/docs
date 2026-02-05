{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../../storage/operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../../storage/security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../../storage/security/sts.md) и [подписанных (pre-signed) URL](../../storage/security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../../storage/security/public-access.md) (если он включен).

{% endnote %}