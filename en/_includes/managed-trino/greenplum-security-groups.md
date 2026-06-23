To access the {{ GP }} cluster, the {{ TR }} [connector](../../managed-trino/concepts/greenplum-connector.md) uses the GPFDIST protocol:

* {{ TR }} coordinators and workers send queries to the {{ GP }} master over TCP port `{{ port-mgp }}`.
* {{ GP }} segments forward data to {{ TR }} workers over the GPFDIST TCP port.

Data transmitted between the {{ GP }} and {{ TR }} clusters over the GPFDIST protocol is unencrypted. To secure your connection, configure security groups [in {{ mgp-name }}](#configuring-security-groups-greenplum) and, optionally, [in {{ mtr-name }}](#configuring-security-groups-trino).

If {{ GP }} interacts with other clusters or entities inside the user network, you need to separately configure security group rules for any such clusters or entities.

#### {{ GP }} side setup {#configuring-security-groups-greenplum}

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

    * Rule for internal {{ GP }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections from a {{ TR }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ TR }} cluster security group.

- Outgoing traffic {#outgoing}

    * Rule for internal {{ GP }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections to a {{ TR }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `0-65535`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ TR }} cluster security group.

{% endlist %}

#### {{ mtr-name }} side setup {#configuring-security-groups-trino}

To configure security group rules in {{ TR }}, invert the {{ GP }} rule settings. Setting up rules for a {{ TR }} cluster is optional, but this provides added security for your cluster.

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

  Rule for receiving data from {{ GP }} segments:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `0-65535`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ GP }} cluster security group.

- Outgoing traffic {#outgoing}

  Rule for connections to a {{ GP }} master:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ GP }} cluster security group.

{% endlist %}
