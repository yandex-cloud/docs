The configuration check must show actual values, not just the design description. For each profile of the [{#T}](../../../../security/standard-ai/profiles.md) section, its ten fields are checked, including:

* Active version, revision, image digest, model package, or index.
* Public accessibility and endpoints.
* {{ vpc-short-name }}, subnets, security groups, routes, and network policies, where applicable.
* Working service account.
* Direct and inherited {{ iam-short-name }} bindings.
* API key scope and review period or date.
* {{ k8s }} RBAC roles and internal storage permissions.
* Links to secrets without getting their values.
* Trail scope, service filters, log purpose, and retention period.
* Alert rule, notification channel, and delivery test.

Defined for each role are a subject, required operation, resource, and a minimum supported scope of assignment. A simple match between the role name and the service name is not sufficient. For an external supplier, permissions are verified within its approved system; they are not superseded by {{ iam-short-name }}.

Verification commands must not modify bindings, create keys, deploy revisions, or output secrets. A command like `set-access-bindings`, which replaces the entire set of bindings, is not used for diagnostics.
