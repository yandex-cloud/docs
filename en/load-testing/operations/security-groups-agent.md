---
title: How to configure test agent security groups
description: Follow this guide to configure test agent security groups.
---

# Configuring test agent security groups

{% note warning %}

Make sure to set up security groups before creating the [agent](../concepts/agent.md). This way you can restrict the agent's access.

{% endnote %}

{% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

If you plan to use multiple security groups for your agent, allow all traffic between them.
To assign another security group, [update](../../compute/operations/vm-control/vm-update.md) the VM network settings in {{ compute-full-name }}.

{% note info %}

You can specify more granular rules for your security groups, such as allowing traffic only within specific subnets.

Make sure security groups are properly configured for all subnets that will host traffic-generating agents.

{% endnote %}
