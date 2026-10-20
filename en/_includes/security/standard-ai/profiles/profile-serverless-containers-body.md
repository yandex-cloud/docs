{#profile-serverless-containers-applicability}

**Scope and status**

The profile is applied if {{ serverless-containers-name }} is the runtime.

{#profile-serverless-containers-flow}

**Flow and trust boundaries**

`HTTPS/trigger/{{ api-gw-name }} → service's public API → active revision → targets`. The managed instance does not accept an arbitrary inbound connection directly.

{#profile-serverless-containers-authentication}

**Workload identity and authentication**

For a non-public container, the calling environment obtains an IAM token for its workload identity and has the `serverless-containers.containerInvoker` role. The public branch exists only if this role is bound to the `system:allUsers` system group, in which case the request does not contain an authorization header. The binding and the absence of credentials are verified as per the [public container guide](../../../../serverless-containers/operations/container-public.md).

The revision's service account accesses targets and obtains a short-lived IAM token through the GCE metadata service as per the [official guide](../../../../serverless-containers/operations/sa.md). These subjects and their permissions are kept separate.

{#profile-serverless-containers-roles}

**Roles and scope**

`serverless-containers.containerInvoker` is used for invocation; `serverless-containers.editor` manages the container, and `serverless-containers.admin` manages its access permissions only depending on what operation is required.

The subject that creates the revision with a service account separately has `iam.serviceAccounts.user` for that account.

The revision's service account gets granular roles for the targets and, if the image resides in a non-public {{ container-registry-name }}, also the `container-registry.images.puller` role for the selected registry or repository. The semantics and assignment levels are cross-checked against the [Containers access model](../../../../serverless-containers/security/index.md).

{#profile-serverless-containers-network}

**Network**

Even if connecting a custom network, the container is invoked via the public API of the service. The inbound access mode, cloud network, subnet, and outbound path are recorded; the custom network opens access to its resources, while the default network uses documented NAT. For more information, see the [network model](../../../../serverless-containers/concepts/networking.md) description.

{#profile-serverless-containers-secrets}

**Secrets and credentials**

The [Container + {{ lockbox-short-name }}](../../../../serverless-containers/operations/lockbox-secret-transmit.md) integration is at the Preview stage. The service account gets `lockbox.payloadViewer` for the specific secret and `kms.keys.encrypterDecrypter` for the key if the secret is encrypted with a custom {{ kms-short-name }} key. The link forms a part of the new revision; the value may be cached for up to five minutes after revocation.

{#profile-serverless-containers-configuration}

**Configuration objects**

Container and revision IDs, active revision, image digest, service account, access mode, CPU, memory, concurrent request processing, timeout, environment variables and links to secrets, cloud network, log group, and access permissions.

{#profile-serverless-containers-telemetry}

**Telemetry and blind spots**

{{ cloud-logging-name }} receives the request log and stdout/stderr as per the [log model](../../../../serverless-containers/concepts/logs); requests are correlated via `X-Request-Id`. [{{ at-name }}](../../../../serverless-containers/at-ref) shows published management operations but not every invoke or application decision.

{#profile-serverless-containers-checks}

**Positive and negative checks**

1. Perform an invocation with and without the role.
1. Check the active and previous revisions, and the operation with the target performed by the minimum role.
1. Check the issuing and revocation of a test secret with cache taken into account.
1. Check the request log and rollback.

{#profile-serverless-containers-inputs}

**What you need for profile implementation**

* Architecture: trigger, inbound mode, network, and targets.
* Policy: public accessibility, scaling, timeout, log content redaction, and retention period.
* Legal approach: request content and logs.
