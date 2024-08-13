{% note warning %}

With the manual [instance stopping strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy), {{ ig-name }} will restart or recreate an instance if at least one of the following conditions is met:
* User [stops](../../compute/operations/vm-control/vm-stop-and-start.md#stop) the instance in {{ compute-name }}.
* Application or user stops the instance internally.
* Instance fails the application [health check](../../compute/concepts/instance-groups/autohealing.md#functional-healthcheck).

{% endnote %}
