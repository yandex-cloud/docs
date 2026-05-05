{% note info %}

The configuration of the instance reserve pool must match the configuration of the instance group you want to create in terms of:
* [Platform](../../compute/concepts/vm-platforms.md)
* Number of vCPUs
* Amount of RAM
* [Availability zone](../../overview/concepts/geo-scope.md)

The number of VMs in each availability zone must not exceed the size of the reserved instance pools in those zones.

{% endnote %}