---
subcategory: Application Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/alb_http_router.md
---

# yandex_alb_http_router (Resource)

Creates an HTTP Router in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/application-load-balancer/concepts/http-router).

## Example usage

```terraform
//
// Create a new ALB HTTP Router
//
resource "yandex_alb_http_router" "tf-router" {
  name = "my-http-router"
  labels {
    tf-label    = "tf-label-value"
    empty-label = "s"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `route_options` [Block]. Route options for the virtual host.
  - `security_profile_id` (String). SWS profile ID.
  - `rbac` [Block]. RBAC configuration.
    - `action` (String). 
    - `principals` [Block]. 
      - `and_principals` [Block]. 
        - `any` (Bool). 
        - `remote_ip` (String). 
        - `header` [Block]. 
          - `name` (**Required**)(String). 
          - `value` [Block]. The `path` and `fqmn` blocks.

              {% note warning %}

              Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

              {% endnote %}
            - `exact` (String). Match exactly.
            - `prefix` (String). Match prefix.
            - `regex` (String). Match regex.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_alb_http_router.<resource Name> <resource Id>
terraform import yandex_alb_http_router.my_router ds7ph**********hm4in
```
