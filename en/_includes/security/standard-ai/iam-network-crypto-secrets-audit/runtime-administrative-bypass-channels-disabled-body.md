{#ai-infra-console1-id}

Requirement ID: `AI-INFRA-CONSOLE1`

{#ai-infra-console1-applicability}

**Scope**

This requirement applies to {{ compute-full-name }} VM instances used in the execution, loading, and administration environments, RAG store, agent backend, MCP tools, telemetry, or other AI system components.

{#ai-infra-console1-requirement}

**Requirement**

For AI system VMs, access to the serial console (`serial console`) must be disabled. The serial console must not be used as the standard method for production VM administration.

Standard administrative access must take place via an approved method, e.g., OS Login over SSH. Access must be personalized, limited to {{ iam-short-name }} roles, and loggable.

The serial console can be enabled only for emergency response or approved maintenance works. Each time, the following must be specified: VM, reason, responsible party, validity period, and approval. After the works are completed, the serial console must be disabled.

{#ai-infra-console1-implementation}

**Implementation**

For each VM in the AI system, the following are recorded:

* Serial console access option status.
* Approved administrative access method.
* Users or groups with OS Login permissions.
* Source of administrative action logs.

For Linux VMs, we recommend using OS Login with the `compute.osLogin` or `compute.osAdminLogin` roles instead of persistent SSH keys on the VM. If OS Login is not used as such, another approved method of personalized and loggable access must be documented.

The OS Login, SSH access, VM service account, and metadata access configuration is checked separately from the serial console configuration. The presence of {{ iam-short-name }} minimum roles does not mean that the serial console is disabled.

{#ai-infra-console1-check}

**Check**

1. For each VM in the AI system, check that serial console access is disabled in the VM settings.
1. If the serial console is on, check that there is a valid exception stating the VM, reason, owner, approval, and duration.
1. After the emergency work are done, confirm that the serial console is off by re-checking the VM configuration.

A VM with enabled serial console and no valid exception in place is considered non-compliant.

{#ai-infra-console1-artifacts}

**Artifact**

* Export or screenshot of the VM configuration with serial console access status.
* List of the AI system's VMs.
* Approved administrative access method.
* List of OS Login roles or another access mechanism.
* Request for temporary activation of the serial console, if any.
* Confirmation that it was disabled after the works ended.
