[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Logging > Data Sources > api_gateway

# yandex_api_gateway (DataSource)

Get information about a Yandex Cloud API Gateway. For more information, see the official documentation [Yandex Cloud API Gateway](../../api-gateway/index.md).

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
- `description` (*Read-Only*) (String). The resource description.
- `domain` (*Read-Only*) (String). Default domain for the Yandex Cloud API Gateway. Generated at creation time.
- `execution_timeout` (String). Execution timeout in seconds for the Yandex Cloud API Gateway.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). ID of the log group for the Yandex Cloud API Gateway.
- `log_options` (*Read-Only*) (List Of Object). 
  - `disabled` . 
  - `folder_id` . 
  - `log_group_id` . 
  - `min_level` . 
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). Status of the Yandex Cloud API Gateway.
- `user_domains` (*Read-Only*) (Set Of String). 

    {% note warning %}

    **DEPRECATED** Use `custom_domains` instead. Set of user domains attached to Yandex Cloud API Gateway.

    {% endnote %}

- `variables` (Map Of String). A set of values for variables in gateway specification.
- `canary` [Block]. 
  - `variables` (Map Of String). 
  - `weight` (Number). 
- `connectivity` [Block]. 
  - `network_id` (**Required**)(String). 
- `custom_domains` [Block]. 
  - `certificate_id` (**Required**)(String). 
  - `domain_id` (String). 
  - `fqdn` (**Required**)(String).