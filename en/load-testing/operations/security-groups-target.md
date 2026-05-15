---
title: How to configure test target security groups
description: Follow this guide to configure test target security groups.
---

# Configuring test target security groups

{% include [loadtesting-sunset-warning](../../_includes/load-testing/sunset-warning.md) %}


{% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure security groups are properly configured for all subnets that will host test targets.

{% endnote %}