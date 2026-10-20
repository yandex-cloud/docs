{% include [content](iam-network-crypto-secrets-audit/iam-network-crypto-secrets-audit-intro-body.md) %}

## Permissions and access {#rights-access}

### Intercomponent connections are limited by the actual topology {#intercomponent-connections-limited-by-topology}

{% include [content](iam-network-crypto-secrets-audit/intercomponent-connections-limited-by-topology-body.md) %}

### Workload identities have minimal effective permissions {#workload-identities-minimal-effective-rights}

{% include [content](iam-network-crypto-secrets-audit/workload-identities-minimal-effective-rights-body.md) %}

### {{ ai-studio-name }} call uses a documented authentication method {#ai-studio-call-uses-documented-auth}

{% include [content](iam-network-crypto-secrets-audit/ai-studio-call-uses-documented-auth-body.md) %}

### Effective permissions are reviewed on a schedule and after changes {#effective-rights-reviewed-on-schedule-and-change}

{% include [content](iam-network-crypto-secrets-audit/effective-rights-reviewed-on-schedule-and-change-body.md) %}

### Privileged user accounts use MFA {#privileged-users-use-mfa}

{% include [content](iam-network-crypto-secrets-audit/privileged-users-use-mfa-body.md) %}

### Runtime administrative bypass channels are disabled by default {#runtime-administrative-bypass-channels-disabled}

{% include [content](iam-network-crypto-secrets-audit/runtime-administrative-bypass-channels-disabled-body.md) %}

## Storages and cryptographic protection {#storage-crypto}

### Model and data storages have no unaccounted for public access {#model-data-stores-no-unaccounted-public-access}

{% include [content](iam-network-crypto-secrets-audit/model-data-stores-no-unaccounted-public-access-body.md) %}

### Encryption is chosen based on the capabilities of the specific service {#encryption-chosen-by-service-capabilities}

{% include [content](iam-network-crypto-secrets-audit/encryption-chosen-by-service-capabilities-body.md) %}

## Secrets {#secrets}

### A secret has an owner and a managed lifecycle {#secret-has-owner-managed-lifecycle}

{% include [content](iam-network-crypto-secrets-audit/secret-has-owner-managed-lifecycle-body.md) %}

## Audit and log content {#audit-logs}

### Each significant operation has an event source specified {#material-operation-has-event-source}

{% include [content](iam-network-crypto-secrets-audit/material-operation-has-event-source-body.md) %}

### Logs do not collect sensitive content without a purpose {#logs-no-sensitive-content-without-purpose}

{% include [content](iam-network-crypto-secrets-audit/logs-no-sensitive-content-without-purpose-body.md) %}
