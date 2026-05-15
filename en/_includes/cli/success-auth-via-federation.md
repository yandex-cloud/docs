
On successful authentication, an [IAM token](../../iam/concepts/authorization/iam-token.md) will be saved in the profile. This IAM token will be used to authenticate each operation until the end of the token's [lifetime](../../iam/concepts/authorization/iam-token.md) (not more than 12 hours). After that, the CLI will once again prompt you to authenticate in the browser.

To extend the period during which you do not have to authenticate in the browser, use [refresh tokens](../../iam/concepts/authorization/refresh-token.md), which allow you to reissue IAM tokens without entering the browser. Do it by enabling refresh tokens [at the organization level](../../iam/concepts/authorization/refresh-token.md#token-enabling) and [initializing DPoP protection](../../iam/concepts/authorization/refresh-token.md#enabling-dpop) in the CLI.

