---
subcategory: Identity Hub
alternate:
  - href: ru/terraform/resources/organization_manager_organization_iam_policy_binding.md
    type: text/markdown
    title: Markdown version
---

# yandex_organization_manager_organization_iam_policy_binding (Resource)

Applies an access policy template to the specified organization.


## Arguments & Attributes Reference

- `access_policy_template_id` (**Required**)(String). ID of the access policy template to apply.
- `id` (String). The ID of this resource.
- `organization_id` (**Required**)(String). ID of the organization to which the access policy template applies.
- `parameters` (Map Of String). Parameter values for this binding, keyed by the parameter names defined by the access policy template.
- `sleep_after` (Number). For testing. Number of seconds to wait after creating or updating the binding before reading its state.


