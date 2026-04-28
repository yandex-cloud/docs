{% note info %}

Make sure the following properties are identical in the node group and reserved instance pool configurations:
* [Platform](../../compute/concepts/vm-platforms.md)
* Number of vCPUs
* Amount of RAM
* [Availability zone](../../overview/concepts/geo-scope.md)

The number of group nodes in each availability zone must not exceed the size of the reserved instance pools in those zones.

{% endnote %}