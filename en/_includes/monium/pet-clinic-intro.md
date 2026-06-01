In this example, you will install the [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) demo app and configure it to send telemetry to {{ monium-name }}. 

To install the demo application, you can temporarily create a {{ compute-full-name }} [VM](../../compute/concepts/vm.md). Learn more about creating a suitable VM [here](../../compute/operations/vm-create/create-linux-vm.md).

Below are examples of commands for installing the demo application on Linux Ubuntu.

{% note warning %}

For the `OTel Collector` agent to work correctly, the VM or server must allow _outgoing traffic_ on TCP port `443`.

For the demo application to work correctly, the VM or server must allow _incoming traffic_ on TCP ports `4317`, `4318`, and `8080`.

If you are using a {{ compute-name }} VM, [create](../../vpc/operations/security-group-create.md) and [link](../../compute/operations/vm-control/vm-change-security-groups-set.md) to it a [security group](../../vpc/concepts/security-groups.md) allowing these traffic types.

{% endnote %}