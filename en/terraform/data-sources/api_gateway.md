---
subcategory: Cloud Logging
---

# yandex_api_gateway (DataSource)

Get information about a Yandex Cloud API Gateway. For more information, see the official documentation [Yandex Cloud API Gateway](https://yandex.cloud/docs/api-gateway/).

{% note warning %}

Either `api_gateway_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing API Gateway
//
data "yandex_api_gateway" "my-api-gateway" {
  name = "my-api-gateway"
}
```

## Arguments & Attributes Reference

- `api_gateway_id` (String). Yandex Cloud API Gateway id used to define api gateway.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `domain` (*Read-Only*) (String). Default domain for the Yandex Cloud API Gateway. Generated at creation time.
- `execution_timeout` (String). Execution timeout in seconds for the Yandex Cloud API Gateway.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). ID of the log group for the Yandex Cloud API Gateway.
- `log_options` [Block]. Options for logging from Yandex Cloud API Gateway.
  - `disabled` (Bool). Is logging from Yandex Cloud API Gateway disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `name` (**Required**)(String). The resource name.
- `status` (*Read-Only*) (String). Status of the Yandex Cloud API Gateway.
- `user_domains` (*Read-Only*) (Set Of String). 

    {% note warning %}

    **DEPRECATED** Use `custom_domains` instead. Set of user domains attached to Yandex Cloud API Gateway.

    {% endnote %}

- `variables` (Map Of String). A set of values for variables in gateway specification.
- `canary` [Block]. Canary release settings of gateway.
  - `variables` (Map Of String). A list of values for variables in gateway specification of canary release.
  - `weight` (Number). Percentage of requests, which will be processed by canary release.
- `connectivity` [Block]. Gateway connectivity. If specified the gateway will be attached to specified network.
  - `network_id` (**Required**)(String). Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.
- `custom_domains` [Block]. Set of custom domains to be attached to Yandex Cloud API Gateway.
  - `certificate_id` (**Required**)(String). 
  - `domain_id` (String). 
  - `fqdn` (**Required**)(String).


