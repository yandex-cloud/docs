# Resolving the `PROHIBITED_BILLING_ACCOUNT_USAGE_STATUS` error


## Issue description {#issue-description}

When trying to link a cloud, {{ tracker-full-name}}, or {{ ml-platform-full-name }} to your account, you see the `PROHIBITED_BILLING_ACCOUNT_USAGE_STATUS` error.

## Solution {#issue-resolution}

The error occurs because you cannot re-assign an asset from a billing account arranged for paid consumption to an account that is in a trial period.

Upgrade your account to the paid version as per [this guide](../../../getting-started/free-trial/concepts/upgrade-to-paid.md) and try linking the asset in question again.