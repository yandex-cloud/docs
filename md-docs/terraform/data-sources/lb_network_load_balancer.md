[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Network Load Balancer > Data Sources > lb_network_load_balancer

# yandex_lb_network_load_balancer (DataSource)

Get information about a Yandex Load Balancer network load balancer. For more information, see [the official documentation](../../load-balancer/concepts).

This data source is used to define [Load Balancer Network Load Balancers](../../load-balancer/concepts) that can be used by other resources.

{% note warning %}

One of `network_load_balancer_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Network Load Balancer (NLB).
//
data "yandex_lb_network_load_balancer" "my_nlb" {
  network_load_balancer_id = "my-network-load-balancer"
}
```

## Arguments & Attributes Reference

- `allow_zonal_shift` (*Read-Only*) (Bool). Flag that marks the network load balancer as available to zonal shift.
- `attached_target_group` (*Read-Only*) (Set Of Object). 
  - `healthcheck` . 
    - `healthy_threshold` . 
    - `http_options` . 
      - `path` . 
      - `port` . 
    - `interval` . 
    - `name` . 
    - `tcp_options` . 
      - `port` . 
    - `timeout` . 
    - `unhealthy_threshold` . 
  - `target_group_id` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `listener` (*Read-Only*) (Set Of Object). 
  - `external_address_spec` . 
    - `address` . 
    - `ip_version` . 
  - `internal_address_spec` . 
    - `address` . 
    - `ip_version` . 
    - `subnet_id` . 
  - `name` . 
  - `port` . 
  - `protocol` . 
  - `target_port` . 
- `name` (String). The resource name.
- `network_load_balancer_id` (String). Network load balancer ID.
- `region_id` (*Read-Only*) (String). ID of the availability zone where the network load balancer resides. If omitted, default region is being used.
- `type` (*Read-Only*) (String). Type of the network load balancer. Must be one of 'external' or 'internal'. The default is 'external'.