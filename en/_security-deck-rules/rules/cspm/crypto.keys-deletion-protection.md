### Deletion protection is enabled for KMS keys {#keys-deletion-protection}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.keys-deletion-protection ||
|#

#### Description

A key in [Key Management Service](https://yandex.cloud/en/docs/kms/) is the gateway to the data it encrypts: lose the key, and the data encrypted with it is unrecoverable.

For keys that protect business-critical data — encrypted Object Storage buckets, etcd of a Managed Service for Kubernetes cluster, secrets in Lockbox — accidental deletion is one of the most damaging operations possible. Deletion protection makes the deletion call fail until someone explicitly turns the protection off, which gives time to notice and stop a wrong action.

**Risks if the rule is not followed:** Accidental or malicious deletion of a KMS key permanently destroys all data encrypted with it — including Object Storage buckets, Kubernetes cluster state, and Lockbox secrets — with no possibility of recovery.

#### Instructions and solutions

Enable deletion protection on every KMS key that encrypts data you cannot afford to lose:

1. In the [management console](https://console.yandex.cloud/), open the key settings (KMS → key → **Edit**).
2. Enable [deletion protection](https://yandex.cloud/en/docs/kms/operations/key#update).
3. Limit who can disable the flag — the role `kms.editor` is enough to remove protection, so review who has it through the [CIEM module](https://yandex.cloud/en/docs/security-deck/concepts/ciem) of Security Deck.
4. Make sure that key removal goes through a planned change — confirm with the data owner first, then disable protection and delete.
