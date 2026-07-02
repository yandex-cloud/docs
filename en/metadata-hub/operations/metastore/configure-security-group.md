---
title: Configuring {{ metastore-full-name }} cluster security groups
description: Follow this guide to configure security groups for a {{ metastore-name }} cluster.
---

# Configuring {{ metastore-name }} cluster security groups

If your cloud network uses [security groups](../../../vpc/concepts/security-groups.md), they can hinder the {{ metastore-name }} cluster performance. In which case you need to configure the security group assigned to the {{ metastore-name }} cluster by [adding](../../../vpc/operations/security-group-add-rule.md) the following rules for incoming traffic to it:

* For incoming service traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30000-32767`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `Security group`
   * **Security group**: `Current`

* For incoming traffic from clients over Thrift:

   * **Description**: `thrift`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `9083`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

* For incoming traffic from clients over REST:

   * **Description**: `iceberg rest (4.2+)`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `9001`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

* For incoming load balancer traffic:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can specify more granular rules for your security groups, e.g., to allow traffic only in specific subnets.

{% endnote %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
