# Instance groups

#### What is {{ ig-name }}? {#what-is}

{{ ig-name }} is a component that allows you to create, use, and scale groups of similar instances in the {{ compute-full-name }} infrastructure.

With {{ ig-name }}, you can:

- Create groups with the required number of instances and performance parameters.
- Scale the computing capacity up or down, depending on the load.

You work with an instance group as a single entity in the {{ compute-full-name }} infrastructure. This allows you to manage the internal settings of the instance group to meet your application's requirements.

#### How is the cost of instance group use calculated? {#ig-cost}

Creation of an instance group is free of charge.

All other {{ yandex-cloud }} services, such as VMs and external IP addresses, are charged as usual.

#### How do I know I'm not overpaying? {#not-overpaying}

To select the appropriate number of instances and minimize costs:

- Estimate the amount of computing resources required for your service and see the calculation examples and [pricing policy](../../compute/pricing.md) for {{ compute-full-name }}.
- Try to frequently monitor the load on the service at different times of day.

#### Why can't I delete a service account linked to an instance group? {#sa-deletion}

{% include [sa-dependence](../../_includes/instance-groups/sa-dependence.md) %}