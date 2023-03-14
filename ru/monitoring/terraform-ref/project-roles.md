# ycp_monitoring_roles (Resource)

Monitoring projectRoles

## Schema

### Required

- `project_id` (String) Project identifier

### Optional

- `group` (String) Group id
- `id` (String) The ID of this resource.
- `login` (String) Staff login
- `roles` (List of String) Roles values
- `service` (String) Service id
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `tvm` (String) Tvm login

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_roles" "role1" {
  project_id = "project_id_here"
  login      = "alextrushkin"
  roles      = ["ROLE_EDITOR", "ROLE_VIEWER", "ROLE_ADMIN"]
}

resource "ycp_monitoring_roles" "role2" {
  project_id = "project_id_here"
  service    = "29885"
  roles      = ["ROLE_ADMIN"]
}

resource "ycp_monitoring_roles" "role3" {
  project_id = "project_id_here"
  tvm        = "2032782"
  roles      = ["ROLE_EDITOR", "ROLE_VIEWER"]
}
```
