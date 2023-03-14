# ycp_monitoring_service_provider_resource (Resource)

Monitoring service provider resource

## Schema

### Required

- `abc_slug` (String) Abc slug
- `name` (String) Resource name
- `parameters` (Map of String) Resource parameters
- `service_provider_id` (String) Resource service provider id
- `type` (String) Resource type

### Optional

- `environment` (String) Resource environment
- `id` (String) The ID of this resource.
- `project_id` (String) Resource monitoring project
- `responsible` (String) Resource responsible
- `severity` (String) Resource severity. SERVICE_PROVIDER_RESOURCE_SEVERITY_HIGHLY_CRITICAL is default
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_service_provider_resource" "my-cluster" {
  abc_slug = "solomon_tests"
  name = "n12"
  service_provider_id = "managed-postgresql"
  parameters = {
    cluster = "cls"
  }
  type = "cluster"
  project_id = "alextrushkin2"
  severity = "SERVICE_PROVIDER_RESOURCE_SEVERITY_HIGHLY_CRITICAL"
  responsible = "me"
  environment = "PRODUCTION"
}
```

Non critical resources:
```
//CLusters
variable "clusters" {
  type = map(object({
    clusters = set(string)
  }))
  default = {
    "solomon_tests" = {
      clusters = ["cluster1", "cluster2"]
    }
    "solomon" = {
      clusters = ["cluster3", "cluster4"]
    }
  }
}

locals {
  clusters = flatten([
  for abc_key, list in var.clusters : [
  for clusterId in list.clusters : {
    abc     = abc_key
    cluster = clusterId
  }
  ]
  ])
}

// Create non critical resources
// [
//  {
//    "abc" = "solomon"
//    "cluster" = "cluster3"
//  },
//  {
//    "abc" = "solomon"
//    "cluster" = "cluster4"
//  },
//  {
//    "abc" = "solomon_tests"
//    "cluster" = "cluster1"
//  },
//  {
//    "abc" = "solomon_tests"
//    "cluster" = "cluster2"
//  },
//]
resource "ycp_monitoring_service_provider_resource" "resources_nn_critical" {
  for_each = {
  for cluster in local.clusters : "${cluster.abc}${cluster.cluster}" => cluster
  }

  abc_slug            = each.value.abc
  name                = "n12"
  service_provider_id = "managed-postgresql"
  parameters          = {
    cluster = each.value.cluster
  }
  type     = "cluster"
  severity = "SERVICE_PROVIDER_RESOURCE_SEVERITY_NON_CRITICAL"
}
```
