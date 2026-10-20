{#profile-compute-applicability}

**Scope and status**

This profile applies when the AI model or runtime environment runs on a VM instance or instance group. The organization is responsible for the image, operating system, updates, processes, model loader, and application logs.

{#profile-compute-flow}

**Flow and trust boundaries**

`input/load balancer/{{ api-gw-name }} → VM and process → model → disk/{{ objstorage-name }}/external services`. The VM cloud configuration, OS, process, and model package are considered separately.

{#profile-compute-authentication}

**Workload identity and authentication**

The VM is associated with a service account; the application obtains a short-lived IAM token through the metadata service.

The subject that creates or modifies the VM separately has the `iam.serviceAccounts.user` role for the selected service account, as specified in [this binding guide](../../../../compute/operations/vm-control/vm-connect-sa.md). This deployment permission is not an application runtime role.

The VM cloud identity and OS users remain separate. Learn how to get a token in [this guide on authenticating from within a VM](../../../../compute/operations/vm-connect/auth-inside-vm.md).

{#profile-compute-roles}

**Roles and scope**

* **VM management**. `compute.operator` allows starting, stopping, and restarting the VM, but not creating or modifying it; `compute.editor` is used for task-specific management. The deployment identity is separately assigned the `iam.serviceAccounts.user` role for the associated service account. For a public IP address, the required {{ vpc-short-name }} permission is verified, including `vpc.publicAdmin` where required.
* **{{ kms-short-name }} and {{ lockbox-short-name }}**. When using a customer {{ kms-short-name }} key, the subjects that create the encrypted disk or VM, attach the disk, or start or restart the VM get the `kms.keys.user` role for the specific key as specified in the [{{ compute-name }} encryption guides](../../../../compute/concepts/encryption.md). The `kms.admin` role is not required by default. When retrieving a value from {{ lockbox-short-name }}, the VM service account is assigned the `lockbox.payloadViewer` role for the specific secret. If the secret uses a customer {{ kms-short-name }} key, the VM service account is also assigned the `kms.keys.encrypterDecrypter` role. The VM service account gets no other roles beyond those required for the target storages and APIs.
* **{{ oslogin }}**. The user or service account is assigned the `compute.osLogin` role or the `compute.osAdminLogin` and `resource-manager.auditor` roles or higher for the VM folder; `compute.operator` is only added when connecting over `yc compute ssh`. Check roles and connection method against [this {{ oslogin }} guide](../../../../compute/operations/vm-connect/os-login.md).
* **SSH keys in metadata**. If your organization keeps an SSH key section within instance metadata, it records the relevant subjects, keys, revocation procedure, and policy rationale, without treating it as {{ oslogin }}.

For the general cloud role model, see [{{ compute-name }} guides](../../../../compute/security/index.md).

{#profile-compute-network}

**Network**

The system records {{ vpc-short-name }}, the subnet, security groups, public IP address, routes, NAT, load balancers, and outbound path.

The metadata service is located at `169.254.169.254`. Use `aws-v1-http-token=DISABLED` to disable getting a token via Amazon EC2 IMDSv1 as required by the [baseline {{ yandex-cloud }} security standard](../../../../security/standard/all.md), {{ iam-short-name }} 16. If the app needs the IAM token of the VM service account, GCE metadata with `gce-http-endpoint=enabled`, `gce-http-token=enabled`, and the required `Metadata-Flavor: Google` header are used. If the app does not need it, both options should be disabled. For more information, see the [VM metadata description](../../../../compute/concepts/vm-metadata.md).

{#profile-compute-secrets}

**Secrets and credentials**

In the documented [VM path + {{ lockbox-short-name }}](../../../../compute/operations/vm-create/create-with-lockbox-secret.md), `user-data` only contains the secret ID; the IAM token is taken from the metadata service, and the VM service account with the `lockbox.payloadViewer` role for the secret requests the token value via the API. For a secret with a customer {{ kms-short-name }} key, the system also verifies the `kms.keys.encrypterDecrypter` role for the key under the [{{ lockbox-short-name }} access control model](../../../../lockbox/security/index.md).

The secret value is never stored in the metadata or image.

{#profile-compute-configuration}

**Configuration objects**

VM, disk, disk image, and disk snapshot IDs, {{ kms-short-name }} key, service account, metadata flags, security groups and public IP addresses, routes, load balancers, cloud-init, operating system, runtime, process manager, and model package ID and hash.

For administrative access, the system records the organization's {{ oslogin }} modes, the `serial_port_settings.ssh_authorization` value (`OS_LOGIN` or `INSTANCE_METADATA`), and the `enable-oslogin` value (for an existing VM with the agent installed manually). These values and modes are verified against the [organization's {{ oslogin }} setting](../../../../organization/operations/os-login-access.md) and [guide for the existing VM](../../../../compute/operations/vm-connect/enable-os-login.md).

As per [this {{ compute-name }} guide](../../../../compute/concepts/encryption.md), you can enable {{ kms-short-name }} encryption for a disk, image, or snapshot when creating them.

{#profile-compute-telemetry}

**Telemetry and blind spots**

[{{ compute-name }} {{ at-name }}](../../../../compute/at-ref.md) covers published cloud operations, but not the OS or model process. {{ monitoring-short-name }} metrics require an available service metric, {{ unified-agent-full-name }}, or application instrumentation. Operating system and application logs are delivered separately.

{#profile-compute-checks}

**Positive and negative checks**

1. Check {{ iam-short-name }}, the security groups, routes, public IP addresses, `aws-v1-http-token=DISABLED`, selected GCE metadata flags, and encryption settings. A token request without `Metadata-Flavor: Google` must be denied.
1. For {{ oslogin }}, check that access with `compute.osLogin` or `compute.osAdminLogin` is allowed and, after the role is revoked, denied, and does not require an extra `compute.operator` for non-CLI connections.
1. For the `INSTANCE_METADATA` section, verify the list of SSH keys and revoke the test key.
1. Send an allowed network/IAM request and a denied one.
1. Retrieve and revoke the test secret. Check that the value is missing from the image and `user-data`.
1. Correlate a management event, an OS or application log, and the correlation ID.
1. Verify recovery or rollback.

{#profile-compute-inputs}

**What you need for profile implementation**

* Architecture: ingress path, GPU/CPU, runtime environment, process isolation, and storages.
* Policy: security and OS update settings, metadata, {{ kms-short-name }}, backups, and retention period.
* Legal approach: data, model, and licensing.
