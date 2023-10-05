{% note warning %}

With the [strategy for stopping](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy) VM instances, {{ ig-name }} will restart or recreate an instance only of one of the following conditions is met:
* User [stops](../../compute/operations/vm-control/vm-stop-and-start.md#stop) an instance in {{ compute-name }}.
* Application or user stops the instance internally.
* Instance fails the application [health check](../../compute/concepts/instance-groups/autohealing.md#functional-healthcheck).

{% endnote %}
