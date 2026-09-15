### The organization uses Yandex Lockbox for secure secret storage {#secrets-lockbox}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | crypto.secrets-lockbox ||
|#

#### Description

Critical data and access secrets — authentication tokens, API keys, encryption keys, database passwords — should not be stored as plain text in code, in resource names and descriptions, in VM metadata, or in similar places. Anyone with access to the source code, the cloud console, or VM metadata then has access to those secrets.

[Yandex Lockbox](https://yandex.cloud/en/docs/lockbox/) is a managed secret storage service. It keeps secrets encrypted with a key from [Key Management Service](https://yandex.cloud/en/docs/kms/), gives them out only to authorized accounts, and writes every access to Audit Trails.

**Risks if the rule is not followed:** Credentials stored in plain text in code, configuration, or metadata can be extracted by anyone with read access to those locations — developers, CI/CD pipelines, or an attacker who gains access to the repository or VM. A leaked secret can be used to access cloud resources, databases, or external services, often without leaving a trace in audit logs.

#### Instructions and solutions

Move secrets out of code, configuration, and metadata into Lockbox:

1. [Create a secret in Lockbox](https://yandex.cloud/en/docs/lockbox/operations/secret-create) for each credential or sensitive value used by your workloads.
2. Grant access to the secret only to the service account of the workload that really needs it — use the [`lockbox.payloadViewer`](https://yandex.cloud/en/docs/lockbox/security/) role.
3. Read secrets from the workload directly from Lockbox — for example, from a VM through the [SDK or CLI](https://yandex.cloud/en/docs/lockbox/quickstart), and from Managed Service for Kubernetes via the [External Secrets Operator with Yandex Lockbox support](https://yandex.cloud/en/docs/lockbox/tutorials/kubernetes-lockbox-secrets).
4. Remove the secret from the original location (code, config, metadata) and rotate it — the old value should be considered exposed.

More details: [Lockbox documentation](https://yandex.cloud/en/docs/lockbox/).

{% note alert "**Note**" %}

When using Terraform, fill in the contents of a Lockbox secret with a [script](https://terraform-provider.yandexcloud.net/Resources/lockbox_secret_version) instead of putting it directly in the manifest. Otherwise the secret value also ends up in the `.tfstate` file.

{% endnote %}

Use [DSPM](https://yandex.cloud/en/docs/security-deck/concepts/dspm) to find potentially exposed secrets in your storage.
