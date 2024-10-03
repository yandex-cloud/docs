# Resolving the "OAuth token is invalid or expired" error


## Issue description {#issue-description}

The OAuth token has expired, and you see this error: `OAuth token is invalid or expired`.

## Solution {#issue-resolution}

The OAuth token is valid for one year: it could have been revoked on expiry of this period.

The password or authentication method for the account to which the token belonged has probably changed. A list of reasons why the token could have been invalidated is provided [here](https://yandex.ru/dev/id/doc/dg/oauth/reference/token-invalidate.html).

For working with the YC CLI, we recommend authenticating via a service account with the necessary roles and setting up authorization using an authorized key. We have described the setup process in detail in this [article](https://cloud.yandex.ru/docs/cli/operations/authentication/service-account).

An authorized key has no expiry period, and the user should store it independently. If someone might have learned your secret key, delete it. We write more about this authentication method in the [documentation](https://cloud.yandex.ru/docs/iam/concepts/authorization/key).