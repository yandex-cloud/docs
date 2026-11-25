---
subcategory: Resource Manager
---

# yandex_resource_manager_folder_iam_policy_binding (Resource)

Applies an access policy template to the specified folder.


## Arguments & Attributes Reference

- `access_policy_template_id` (**Required**)(String). ID of the access policy template to apply.
- `folder_id` (**Required**)(String). ID of the folder to which the access policy template applies.
- `id` (String). The ID of this resource.
- `parameters` (Map Of String). Parameter values for this binding, keyed by the parameter names defined by the access policy template.
- `sleep_after` (Number). For testing. Number of seconds to wait after creating or updating the binding before reading its state.


