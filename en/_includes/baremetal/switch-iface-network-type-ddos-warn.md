{% note alert %}

When switching the type of a network attached to a network interface, the physical interface remains connected to the same `Leaf`-[level](../../baremetal/concepts/network.md) switch it was previously connected to. This means that if you replace a public network with a private one on the interface, access to the private network via this interface will be routed through the same switch that handles the public network interfaces of other servers in the same data center rack.

Consequently, if this switch fails or a network attack targets any server in the rack, private network traffic passing through this modified interface may be disrupted or restricted.

This limitation does not apply to servers with [MC-LAG](../../baremetal/concepts/mc-lag.md) network redundancy.

{% endnote %}