{#profile-sf-applicability}

**Scope and status**

The profile is applied if {{ sf-name }} is the runtime.

{#profile-sf-flow}

**Flow and trust boundaries**

`HTTPS/trigger/{{ api-gw-name }} → service's public API → active revision → target resources`. The trigger, Gateway, and direct calling subject are considered separately.

{#profile-sf-authentication}

**Workload identity and authentication**

For a non-public function, the calling environment obtains an IAM token for its workload identity and has the `functions.functionInvoker` role. The public branch exists only if this role is bound to the `system:allUsers` system group, in which case the request does not contain an authorization header. The binding and the absence of credentials are verified as per the [public function guide](../../../../functions/operations/function/function-public.md).

The version’s service account gets access to target resources, while its short-lived IAM token is available through the handler context or GCE metadata service as per the [official guide](../../../../functions/operations/function-sa.md). Service accounts of the trigger and {{ api-gw-name }} are checked separately and must also have permissions to call a non-public function.

{#profile-sf-roles}

**Roles and scope**

`functions.functionInvoker` allows the call; `functions.editor` manages functions, versions, and related objects; `functions.admin` manages access in addition to the above.

The subject which binds a service account to a version, trigger, or {{ api-gw-name }} gets the `iam.serviceAccounts.user` role for that account; this role is used during deployment and does not define the function’s permissions during execution. The exact operation and scope are cross-checked against the [{{ sf-name }} access model](../../../../functions/security/index.md).

{#profile-sf-network}

**Network**

The function is called via the service’s public API. Random incoming connection to the instance is not supported. {{ api-gw-name }}, trigger, custom or default network, and actual outgoing path as per the [{{ sf-name }} network model](../../../../functions/concepts/networking.md) are recorded.

{#profile-sf-secrets}

**Secrets and credentials**

The [{{ sf-name }} and {{ lockbox-short-name }}](../../../../functions/operations/function/lockbox-secret-transmit.md) integration is at the Preview stage. The link to the secret creates a new version, and the value may be cached for up to five minutes after revocation. The `lockbox.payloadViewer` role for the secret, the `kms.keys.encrypterDecrypter` role for the custom {{ kms-short-name }} key (if used), and the exact version of the secret are checked.

{#profile-sf-configuration}

**Configuration objects**

Function ID, version, and tag, runtime environment, entry point, code hash, memory, timeout, cloud network, service account, links to secrets, log group, scaling, trigger, and {{ api-gw-name }}.

{#profile-sf-telemetry}

**Telemetry and blind spots**

[{{ sf-name }} logs](../../../../functions/concepts/logs.md) contain the query ID and stdout/stderr. [{{ sf-name }} audit logs](../../../../functions/at-ref.md) are published management operations, not data plane logs for each call.

{#profile-sf-checks}

**Positive and negative checks**

1. Make one allowed call and one denied call.
1. Check the trigger identity, version and tag switching, and target resource failure.
1. Check the issuing and revocation of a test secret.
1. Check the query ID correlation and version rollback.

{#profile-sf-inputs}

**What you need for profile implementation**

* Architecture: trigger, Gateway, version, and target resources.
* Policy: access, scaling, timeout, log content redaction, and retention period.
* Legal approach: content of the call and logs.
