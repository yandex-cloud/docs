#|
|| **Rule purpose** | **Rule settings** ||
|| To access the {{ GL }} instance's public address over HTTPS, e.g., for cloning repositories or downloading artifacts.
This is a required rule. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: public {{ GL }} address.
||
|| To access the artifact registry, e.g., Cloud Registry or dockerhub.io.
This is a recommended rule. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `443`, `5000`, or other.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: CIDRs of the registries to which access is granted. To allow traffic to any IP addresses, specify `0.0.0.0/0`.
||
|| To access object storages, e.g., LFS or Container Registry.
This is a recommended rule. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: CIDRs of the object storages to which access is granted. To allow traffic to any IP addresses, specify `0.0.0.0/0`.
||
|| To access external resources.
This is an optional rule. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `443`, `80`, or other.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: CIDRs of external resources.
If the list of resources is not defined, you can allow outgoing traffic to any addresses (the `0.0.0.0/0` CIDR) on all ports. In this case, you can skip configuring the recommended rules and access from a managed runner to the {{ GL }} instance's public address.
||
|#
