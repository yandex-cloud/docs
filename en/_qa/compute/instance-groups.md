# Instance groups

{% include [minitoc](minitoc/instance-groups.md) %}

#### What is {{ ig-name }}? {#what-is}

{{ ig-name }} is a component that enables you to create, use, and scale groups of same-type VM instances in the {{ compute-full-name }} infrastructure.

With {{ ig-name }}, you can:

- Create groups with the required number of VM instances and performance parameters.
- Scale your computing capacity up or down, depending on the utilization.

You handle an instance group as a single entity in the {{ compute-full-name }} infrastructure. This enables you to manage internal settings of instance groups in line with your app requirements.

#### How do I calculate the cost of using instance groups? {#ig-cost}

Creating an instance group is free of charge.

All other {{ yandex-cloud }} services, e.g., creating VMs and allocating external IP addresses, are charged in the usual way.

#### How do I make sure I'm not overpaying? {#not-overpaying}

To choose the right number of VM instances and minimize costs:

- Estimate the amount of computing resources required for your service and see the calculation examples and [pricing policy](../../compute/pricing.md) for {{ compute-full-name }}.
- Regularly check your service load at various times throughout the day.

#### Why can't I delete a service account linked to my instance group? {#sa-deletion}

{% include [sa-dependence](../../_includes/instance-groups/sa-dependence.md) %}

#### Can I install the required software on an instance in the group when creating that instance? {#preinstall-software}

Yes, you can. To do this, specify a custom script with commands to install the required software in the metadata section of your new instance template. For more information, see [{#T}](../../compute/operations/vm-create/create-with-cloud-init-scripts.md).