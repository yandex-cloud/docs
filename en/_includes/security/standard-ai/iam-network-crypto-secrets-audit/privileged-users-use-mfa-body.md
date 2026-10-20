{#ai-iam-mfa1-id}

Requirement ID: `AI-IAM-MFA1`

{#ai-iam-mfa1-applicability}

**Scope**

This requirement applies to users that have administrative access to AI system resources in {{ yandex-cloud }}, either directly or through a group. It covers roles that allow managing access, secrets, {{ ai-studio-name }}, {{ ml-platform-name }}, runtime, networks, storages, logs, and other resources used by the AI system.

{#ai-iam-mfa1-requirement}

**Requirement**

Multi-factor authentication (MFA) must be enabled for every privileged user. MFA must be enabled before granting privileged access and remain enabled until that access expires.

For local and federated {{ org-full-name }} users, MFA is configured in {{ org-full-name }}. For external federation users, you must verify that the identity provider has enabled and enforced MFA for the user or group with assigned {{ yandex-cloud }} roles.

Service accounts, API keys, static keys, and other technical credentials do not replace MFA for a person who manages access to or resources of the AI system.

{#ai-iam-mfa1-implementation}

**Implementation**

The access owner defines the privileged roles and groups used in the AI system and maps them to users. Role assignments at the organization, cloud, folder, and resource levels are reviewed, including direct assignments and assignments to groups.

At a minimum, broad roles, such as `admin` and `editor`, are reviewed, as well as administrative roles in {{ iam-short-name }}, {{ org-full-name }}, {{ lockbox-short-name }}, {{ at-name }}, {{ ai-studio-name }}, {{ ml-platform-name }}, {{ managed-k8s-name }}, Serverless, {{ compute-name }}, {{ vpc-short-name }}, {{ objstorage-name }}, {{ container-registry-name }}, {{ ydb-short-name }}, and OpenSearch if the relevant services are part of the AI system architecture.

Exceptions are allowed only for a specific user, role, or resource and must have a documented justification and expiration date. Exceptions for an entire group or federation are not allowed.

{#ai-iam-mfa1-check}

**Check**

1. Get a list of role bindings at the organization, cloud, folder, and critical resource levels for the AI system.
1. Expand groups to individual users and identify users with privileged roles.
1. For every such user, verify the MFA status in {{ org-full-name }} or in the external IdP in use.

The requirement is met if MFA is enabled for every privileged user or a valid documented exception is in place.

After remediating the non-compliance, verify again that MFA is enabled or that the privileged role has been revoked.

{#ai-iam-mfa1-artifacts}

**Artifact**

* List of privileged roles and groups.
* Export of role bindings.
* List of users with permissions inherited through groups.
* Evidence of enabled MFA in {{ org-full-name }} or external IdP.
* Register of exceptions including the user, role, resource, justification, and expiration date.
* Re-export after remediation.
