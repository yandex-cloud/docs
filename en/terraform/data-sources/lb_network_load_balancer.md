---
subcategory: Network Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/lb_network_load_balancer.md
---

# yandex_lb_network_load_balancer (DataSource)

Get information about a Yandex Load Balancer network load balancer. For more information, see [the official documentation](https://yandex.cloud/docs/load-balancer/concepts/).

This data source is used to define [Load Balancer Network Load Balancers](https://yandex.cloud/docs/load-balancer/concepts/) that can be used by other resources.

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

- `allow_zonal_shift` (Bool). Flag that marks the network load balancer as available to zonal shift.
- `attached_target_group` [Block]. An AttachedTargetGroup resource.
  - `healthcheck` [Block]. A HealthCheck resource.

      {% note warning %}

      One of `http_options` or `tcp_options` should be specified.

      {% endnote %}
    - `healthy_threshold` (Number). Number of successful health checks required in order to set the `HEALTHY` status for the target.
    - `http_options` [Block]. Options for HTTP health check.
      - `path` (String). URL path to set for health checking requests for every target in the target group. For example `/ping`. The default path is `/`.
      - `port` (**Required**)(Number). Port to use for HTTP health checks.
    - `interval` (Number). The interval between health checks. The default is 2 seconds.
    - `name` (**Required**)(String). Name of the health check. The name must be unique for each target group that attached to a single load balancer.
    - `tcp_options` [Block]. Options for TCP health check.
      - `port` (**Required**)(Number). Port to use for TCP health checks.
    - `timeout` (Number). Timeout for a target to return a response for the health check. The default is 1 second.
    - `unhealthy_threshold` (Number). Number of failed health checks before changing the status to `UNHEALTHY`. The default is 2.
  - `target_group_id` (**Required**)(String). ID of the target group.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `listener` [Block]. Listener specification that will be used by a network load balancer.

    {% note warning %}

    One of `external_address_spec` or `internal_address_spec` should be specified.

    {% endnote %}
  - `external_address_spec` [Block]. External IP address specification. 
    - `address` (String). External IP address for a listener. IP address will be allocated if it wasn't been set.
    - `ip_version` (String). IP version of the external addresses that the load balancer works with. Must be one of `ipv4` or `ipv6`. The default is `ipv4`.
  - `internal_address_spec` [Block]. Internal IP address specification. 
    - `address` (String). Internal IP address for a listener. Must belong to the subnet that is referenced in subnet_id. IP address will be allocated if it wasn't been set.
    - `ip_version` (String). IP version of the external addresses that the load balancer works with. Must be one of `ipv4` or `ipv6`. The default is `ipv4`.
    - `subnet_id` (**Required**)(String). ID of the subnet to which the internal IP address belongs.
  - `name` (**Required**)(String). Name of the listener. The name must be unique for each listener on a single load balancer.
  - `port` (**Required**)(Number). Port for incoming traffic.
  - `protocol` (String). Protocol for incoming traffic. TCP or UDP and the default is TCP.
  - `target_port` (Number). Port of a target. The default is the same as listener's port.
- `name` (String). The resource name.
- `network_load_balancer_id` (String). Network load balancer ID.
- `region_id` (String). ID of the availability zone where the network load balancer resides. If omitted, default region is being used.
- `type` (String). Type of the network load balancer. Must be one of 'external' or 'internal'. The default is 'external'.


