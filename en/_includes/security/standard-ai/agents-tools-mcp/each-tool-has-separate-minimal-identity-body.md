{#ai-iam-leastpriv3-id}

Requirement ID: `AI-IAM-LEASTPRIV3`

{#ai-iam-leastpriv3-requirement}

**Requirement**

Any tool that can access the target resource must use a dedicated account with least-privilege permissions for specific operations. Unrelated tools must not share a single administrative service account.

The backend must verify the user or the authorized delegation context; a username provided to the model as an argument is not proof of authorization.

The following must be recorded for each tool: the calling subject, runtime service account, target system resource and action, exact role and scope of binding, secret, and network path.

If the technical architecture does not support propagating user context, the backend must apply a predefined service policy and narrow down the resource scope to the required minimum. This limitation must be explicitly stated in the agent’s capability description. A service account may only be reused within a single approved boundary with the owner, data, and actions are the same; gateway invocation or management roles are not a substitute for target system access.

{#ai-iam-leastpriv3-check}

**Check**

1. For each tool, map the backend, service account, roles, and target resources.
1. Attempt to invoke another user’s operation or spoof the user ID.

The authorization decision must come from the backend and {{ iam-short-name }}, and must not be inferred from the model text. The same identity must not be authorized to call an unrelated target system, manage {{ iam-short-name }}, or read an unrelated secret.

{#ai-iam-leastpriv3-artifacts}

**Artifact**

* Backend, service account, and role mapping.
* Spoofing test.
* Tool matrix.
* Secret IDs.
