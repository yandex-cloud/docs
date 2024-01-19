{% note info %}

When creating an L7 load balancer using the management console, make sure there are subnets in all availability zones even if you are not going to accept traffic in them. If any availability zone is missing subnets, [create](../../vpc/operations/subnet-create.md) them. To do this, click **{{ ui-key.yacloud.common.label_create-new_female }}**.

{% endnote %}