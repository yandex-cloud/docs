{#ai-iam5-id}

Requirement ID: `AI-IAM5`

{#ai-iam5-requirement}

**Requirement**

For production identities, the access owner must establish the frequency of reviewing the organization policy and conduct out-of-schedule reviews after major updates to the architecture, responsibilities, group membership, external integrations, or the delegation method.

The scope of review encompasses direct assignments, group membership, and inherited permissions; to check the list of direct bindings alone is not enough. The scope covers organization, cloud, folder, and resource-level bindings, API key scopes, and the internal RBAC of the selected storage or runtime, e.g., {{ k8s }} or {{ mos-name }}.

The result must contain the date, covered subjects and resources, the reviewer, the decision for each excessive or unconfirmed permission, and valid exceptions. The review must identify primitive or overly broad roles, assignments above the required resource scope, and capabilities the subject is not actually using for the approved operation. {{ ciem-name }} can be used to view assigned access permissions within its documentation; the decision on whether a permission is required remains up to the organization's policy.

{{ ciem-name }} unavailability is a branch condition, not the result of `N/A` for control: in this case, {{ iam-short-name }} exports and disclosed group membership are retained as manual evidence.

{#ai-iam5-check}

**Check**

1. Select a workload identity, a user with group access, and a subject with an inherited role.
1. Compare the current effective state against the last dated review record and changes made after it.

An overdue review, an out-of-scope inheritance branch, or a permission without a decision means failure to comply. An unused, orphaned, or shared permission and an overly broad role are finds; permission removal has to be confirmed by a repeated negative test.

{#ai-iam5-artifacts}

**Artifact**

* Dated revision record.
* Decisions on excessive permissions.
* Origin of permissions.
* Exception period.
* Repeated negative test.
