{#ai-secret1-id}

Requirement ID: `AI-SECRET1`

{#ai-secret1-requirement}

**Requirement**

API keys, external provider tokens, passwords, and other secrets must be stored in a special storage and have an owner, secret and version IDs, purpose, permitted consumers, precise role and scope of access, delivery method, revision date or period, replacement and revocation procedure. Do not store values in source code, build history, image, dataset, system prompt, public configuration variable, log, or check certificate.

{#ai-secret1-implementation}

**Implementation**

For supported environments, we recommend delivering a secret from {{ lockbox-short-name }} to the working service account with the `lockbox.payloadViewer` role for the specific secret. For a {{ kms-short-name }}-encrypted secret, a documented permission for the key is additionally required. The method depends on the environment:

* [{{ sf-name }}](../../../../functions/operations/function/lockbox-secret-transmit.md) gets the link to the secret in the function configuration. The integration is at the Preview stage.
* [{{ serverless-containers-name }}](../../../../lockbox/operations/serverless/containers.md) uses the integration at the Preview stage.
* [{{ managed-k8s-name }}](../../../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md) uses External Secrets Operator.
* In [{{ compute-name }}](../../../../compute/operations/vm-create/create-with-lockbox-secret.md), the application receives the secret via the API by ID, and the value cannot be placed into an unencrypted `user-data`.

For {{ ml-platform-name }}, the task reads the secret via the API with the service agent token according to a documented instruction. For {{ k8s }}, instead of External Secrets Operator, you can use a path with a workload identity and application access via the API. {{ lockbox-short-name }} is not required unconditionally if the policy selects another approved specialized storage; in this case, the exact delivery path is documented.

For each secret, a single delivery branch is selected: value implementation, reading via the API, or {{ k8s }} `Secret` materialization.

{#ai-secret1-check}

**Check**

1. Map each secret and its active version to consumers, delivery method, and permissions.
1. Browse the code, build history, image, deployment parameters, IaC configuration, resource variables, data, and log selection for the value or synthetic marker of the secret.
1. Revoke the test version and make sure access is discontinued with due account for documented environment caching. Then check the replacement without disclosing the value.

{#ai-secret1-artifacts}

**Artifact**

* Mapping a secret to a consumer.
* Revocation and replacement test.
* {{ iam-short-name }} and {{ kms-short-name }} bindings.
* Value retrieval event in {{ at-name }}.
* Rotation record.
