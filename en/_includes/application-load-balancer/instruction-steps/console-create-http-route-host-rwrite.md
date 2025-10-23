Optionally, in the **{{ ui-key.yacloud.alb.label_host-rewrite }}** field, select one of these options:

* `none`: The Host header in the request does not change.
* `rewrite`: The Host header is replaced with the specified value.
* `auto`: The Host header in the request is automatically replaced with the target [VM](../../../compute/concepts/vm.md) address.