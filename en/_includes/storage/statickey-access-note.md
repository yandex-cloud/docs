{% note info %}

You can [disable using static keys for bucket access](../../storage/operations/buckets/disable-statickey-auth.md). Once disabled, access will be denied to all tools using this access option: the AWS CLI, SDK, and third-party applications. Access via [ephemeral keys](../../storage/security/ephemeral-keys.md), [temporary Security Token Service access keys](../../storage/security/sts.md), and [pre-signed URLs](../../storage/security/overview.md#pre-signed) will also be disabled. Only access with an [IAM token](../../iam/concepts/authorization/iam-token.md) or [anonymous access](../../storage/security/public-access.md) (if enabled) will remain.

{% endnote %}