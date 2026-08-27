{% note info %}

An automatically allocated public address is created in [{{ vpc-full-name }}](../../vpc/); it has no deletion protection and gets deleted along with the L7 load balancer. To preserve the address after the load balancer is deleted, reserve a [static public address](../../vpc/operations/get-static-ip.md) in advance, enable deletion protection for it, and use this address when creating the listener.

{% endnote %}
