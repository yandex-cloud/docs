---
subcategory: Application Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/alb_http_router.md
---

# yandex_alb_http_router (DataSource)

Get information about a Yandex Application Load Balancer HTTP Router. For more information, see [Yandex Cloud Application Load Balancer](https://yandex.cloud/docs/application-load-balancer/quickstart).

This data source is used to define [Application Load Balancer HTTP Router](https://yandex.cloud/docs/application-load-balancer/concepts/http-router) that can be used by other resources.

{% note warning %}

One of `http_router_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing ALB HTTP Router
//
data "yandex_alb_http_router" "tf-router" {
  http_router_id = "my-http-router-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `http_router_id` (String). HTTP Router ID.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `route_options` [Block]. Route options for the virtual host.
  - `rbac` [Block]. RBAC configuration.
    - `action` (String). 
    - `principals` [Block]. 
      - `and_principals` [Block]. 
        - `any` (Bool). 
        - `header` [Block]. 
          - `name` (**Required**)(String). 
          - `value` [Block]. The `path` and `fqmn` blocks.

{% note warning %}

Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

{% endnote %}


            - `exact` (String). Match exactly.
            - `prefix` (String). Match prefix.
            - `regex` (String). Match regex.
        - `remote_ip` (String). 
  - `security_profile_id` (String). SWS profile ID.


