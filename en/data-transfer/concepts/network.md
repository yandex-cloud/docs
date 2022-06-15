# Network in {{ data-transfer-full-name }}

When creating an endpoint, you can select a {% if audience != "internal" %}[cloud network](../../vpc/concepts/network.md) and [security groups](../../vpc/concepts/security-groups.md){% else %}cloud network and security groups{% endif %} for network traffic. If the VMs and DB clusters used in endpoints are hosted in the selected cloud network, the rules of the selected security groups will apply to them during a transfer. This lets you perform transfers without changing the rules for the existing security groups of your VMs or DB clusters.

## Bandwidth {#bandwidth}

The speed for copying data can reach 15 MBps. It usually takes 2-3 hours to copy a 100 GB database. The exact time depends on the target settings.

When you replicate data, the bandwidth may be up to 20-30 thousand transactions per second.
