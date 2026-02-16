---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_service_agent.md
---

# yandex_iam_service_agent (DataSource)

Get information about a Yandex Cloud Service Agent.

## Example usage

```terraform
//
// Get information about existing IAM Service Agent.
//
data "yandex_iam_service_agent" "my_service_agent" {
  cloud_id        = "some_cloud_id"
  service_id      = "some_service_id"
  microservice_id = "some_microservice_id"
}

output "my_service_agent_id" {
  value = "data.yandex_iam_service_agent.my_service_agent.id"
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). ID of the cloud.
- `id` (String). 
- `microservice_id` (String). ID of the service-control microservice.
- `service_id` (String). ID of the service-control service.


