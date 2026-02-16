{% note warning %}

With the [instance stopping strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), {{ ig-name }} will restart or recreate a VM instance if at least one of the following conditions is met:
* The user [stops](../../compute/operations/vm-control/vm-stop-and-start.md#stop) the instance in {{ compute-name }}.
* The application or user stops the instance internally.
* The instance fails the application [health check](../../compute/concepts/instance-groups/autohealing.md#functional-healthcheck).

{% endnote %}
