At the hardware level, {{ baremetal-name }} servers are managed by a baseboard management controller (BMC) via the [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface).

Modifying BMC settings by the user will lead to the following:
* Server management via the [KVM console](../../baremetal/operations/servers/server-kvm.md) will be unavailable.
* You will be unable to stop, start, or restart the server using the [management console]({{ link-console-main }}), {{ yandex-cloud }} [CLI](../../cli/cli-ref/baremetal/cli-ref/index.md), or [API](../../api-design-guide/index.yaml).
* You will be unable to reinstall the server OS.
* You will be unable to view server hardware health metrics (processor temperature, fan speed, etc.)

{% note alert %}

If the user modifies BMC settings, {{ baremetal-full-name }} cannot guarantee the correct operation of the KVM console and other server management tools.

{% endnote %}