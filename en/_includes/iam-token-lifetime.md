The IAM token [lifetime](../iam/concepts/authorization/iam-token.md#lifetime) does not exceed {{ iam-token-lifetime }}; however, we recommend requesting a token more often, e.g., every hour.

To have the IAM token reissued automatically, the `export IAM_TOKEN=$(yc iam create-token)` script can be used.
