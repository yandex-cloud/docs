# Encrypting secrets

A _secret_ is confidential information used by a {{ k8s }} cluster when managing pods, such as OAuth keys, passwords, SSH keys, and so on. By default, {{ k8s }} keeps secrets as plaintext. To learn more, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/configuration/secret/).

To protect secrets, {{ managed-k8s-name }} enables you to encrypt them using encryption keys from {{ kms-full-name }}. Key transactions use the [{{ kms-name }} provider mechanism](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) in {{ k8s }}.

{{ managed-k8s-name }} uses the {{ kms-name }} plugin for key encryption and decryption. Secrets are encrypted using standard {{ k8s }} tools.

Specify a {{ kms-name }} encryption key when [creating a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) since it cannot be added later.

Step-by-step instructions for {{ kms-name }} key management are provided in the [relevant section](../../kms/operations/key.md).