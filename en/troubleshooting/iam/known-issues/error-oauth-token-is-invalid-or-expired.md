# Fixing the `OAuth token is invalid or expired` error



## Issue description {#issue-description}

The OAuth token has expired, causing the `OAuth token is invalid or expired` error.

## Solution {#issue-resolution}

An OAuth token lives 12 months. Once this time frame is over, the token will not work anymore.

The password or authentication method for the account that owns the token might have changed. For the full list of possible causes of token invalidation, see [this Yandex ID article](https://yandex.com/dev/id/doc/en/tokens/token-invalidate) that explains how revoking tokens works.

To get a valid OAuth token, [run a request]({{ link-cloud-oauth }}) to Yandex OAuth. You will see the token on the page that opens. 

For working with the YC CLI, you may want to use a service account through an authorized key. For more details, check out [this article](../../../cli/operations/authentication/service-account.md) on authenticating on behalf of a service account.
