[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Application Load Balancer > Data Sources > alb_http_router

# yandex_alb_http_router (DataSource)

Get information about a Yandex Application Load Balancer HTTP Router. For more information, see [Yandex Cloud Application Load Balancer](../../application-load-balancer/quickstart.md).

This data source is used to define [Application Load Balancer HTTP Router](../../application-load-balancer/concepts/http-router.md) that can be used by other resources.

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
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `route_options` (*Read-Only*) (List Of Object). 
  - `rbac` . 
    - `action` . 
    - `principals` . 
      - `and_principals` . 
        - `any` . 
        - `header` . 
          - `name` . 
          - `value` . 
            - `exact` . 
            - `prefix` . 
            - `regex` . 
        - `remote_ip` . 
  - `security_profile_id` .