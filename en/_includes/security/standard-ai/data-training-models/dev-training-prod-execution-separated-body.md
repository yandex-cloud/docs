{#ai-train1-id}

Requirement ID: `AI-TRAIN1`

{#ai-train1-requirement}

**Requirement**

If the organization trains, fine-tunes, or runs experimental models, such workflows should be isolated from the production system at the project, namespace, service account, access control, storage, and network path levels in line with the selected environment. Experimental workloads must never have access to production secrets or permissions to change production data simply because they run in the same cloud.

For each job, a secret must only be provided to its workload identity with minimal privileges. Do not store secrets in notebooks, datasets, container images, or logs. Limit outgoing traffic to approved sources, recipients, and scopes. Open internet access may allowed as a rare exception that has an owner, time limit, and compensatory control.

The secret delivery method and network controls are environment-specific and must be reviewed against the requirements from [{#T}](../../../../security/standard-ai/iam-network-crypto-secrets-audit.md) and [{#T}](../../../../security/standard-ai/profiles.md).

{#ai-train1-implementation}

**Implementation**

In {{ ml-platform-name }}, permissions are granted at the community and project levels based on [this access management guide](../../../../datasphere/security/index.md).

[{{ managed-k8s-name }}](../../../../managed-kubernetes/index.yaml) also separates IAM cluster access and {{ k8s }} RBAC. For namespace, network policy, and metadata security best practices, refer to [this {{ k8s }} security guide](../../../../security/domains/kubernetes.md).

For systems that only access a managed model API without training, the `N/A` result applies to this entire requirement.

For {{ ml-platform-name }}, the service account, project network and security groups as well as job evidence are recorded. Management events do not prove the origin of data within a notebook or job.

For {{ k8s }}, a separate namespace or cluster with a workload identity, RBAC, and network policy is used.

For [{{ compute-name }}](../../../../compute/index.yaml), a dedicated service account, security groups, encrypted disk, and secret delivery path are configured.

A workload identity does not modify the production artifact pointer; the release copies the exact approved artifact.

{#ai-train1-check}

**Check**

1. Compare the users and service accounts across the experimental and production environments.
1. Attempt to read a production or another subject’s test secret, modify a production object, or access a restricted endpoint from the experimental environment and unrelated job.
1. Also confirm that a development or training subject cannot deploy or overwrite a production version.

An allowed job must only get the assigned secret and source; unauthorized actions must be denied, and logs must not contain the secret value. Acceptable variance must be documented as an [exception](../../../../security/standard-ai/intro.md#exceptions). Artifacts created within a compromised boundary are considered invalid and must be rebuilt once isolated.

{#ai-train1-artifacts}

**Artifact**

* Contour mapping.
* Unauthorized secret read and production write test.
* Hashes of job input and output objects.
