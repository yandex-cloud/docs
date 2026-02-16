# Resources

*Resources* in {{ TF }} are the fundamental building blocks for creating, modifying, and managing infrastructure. In {{ TF }} configurations, the resources represent various cloud entities, such as virtual machines, networks, data storages, and other infrastructure components.

In {{ TF }}, resources are described in configuration files using the HCL syntax. These files specify attributes of each resource, such as its type, properties, and dependencies on other resources.

{{ TF }} follows a declarative approach to infrastructure management. This means the user describes the desired end state of the infrastructure, and {{ TF }} automatically takes the necessary steps to achieve that state. The declarative approach simplifies infrastructure management and helps to prevent errors.

Each resource type in {{ TF }} has its own attributes you can set when creating the infrastructure. For example, for the `yandex_compute_instance` resource, you can specify the platform, disk size, number of cores, and other parameters.

Resources can reference each other, defining their creation and deletion order. For example, the `yandex_vpc_subnet` resource may depend on the `yandex_vpc_network` resource. This enables {{ TF }} to automatically create and delete resources in the correct order.

When you update the configuration, {{ TF }} compares the current infrastructure state with the target state and only takes the actions required to achieve the target state. This ensures infrastructure consistency and simplifies its updates.
