# Get IAM token

To get an [IAM token](../../concepts/authorization/iam-token.md):

1. Log in to Yandex using [your Yandex Passport account](https://yandex.com/support/passport/auth.html).
1. Get an OAuth token from Yandex OAuth. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), click **Allow** and copy the OAuth token that is issued.
1. Exchange the OAuth token for an IAM token:

   ```
   curl -X POST \
        -H 'Content-Type: application/json' \
        -d '{"yandexPassportOauthToken": "<OAuth-token>"}' \
        https://iam.api.cloud.yandex.net/iam/v1/tokens
   ```

   The received IAM token is valid for 12 hours. After that period expires, get a new IAM token.

