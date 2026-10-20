{#ai-iam-compromise1-id}

Requirement ID: `AI-IAM-COMPROMISE1`

{#ai-iam-compromise1-applicability}

**Scope**

This requirement applies when an agent acts on behalf of a user, tenant, or other session with different permissions.

{#ai-iam-compromise1-requirement}

**Requirement**

Before calling the tool, the trusted component must verify the authenticated user, session, and tenant, and provide the backend with a limited delegation context. The backend independently verifies the exact resource and action; the agent cannot broaden their scope through tool arguments or its own judgment.

Revocation of the user session, permission, or delegation must prevent subsequent actions, and the agent's persistent workload identity must not retain broader privileges.

Short-lived IAM and ID tokens are only used for the documented audience; for each identity, the token audience, lifetime, binding scope, and emergency revocation method are recorded. The OIDC provider's compatibility is verified against the provider's documentation.

If end-to-end delegation is not technically available, the service policy must restrict access to predefined resources and operations, and this restriction must be documented as an architectural property. Data and state for different sessions are kept separate under `AI-INFRA6` and `AI-INFRA-ISOL2`.

{#ai-iam-compromise1-check}

**Check**

1. Perform an allowed action in your session, then attempt to spoof the user, tenant, resource, and action.
1. Revoke the test session or permission and repeat the call.

The backend must reject both the spoofing attempt and the action after revocation, and the trace must show the verified context without retaining the delegation secret. The test set includes a modified audience or tenant and an expired token.

{#ai-iam-compromise1-artifacts}

**Artifact**

* User/tenant spoofing and session revocation test.
* Delegation record.
* Token metadata (excluding secrets).
* Revocation event.
