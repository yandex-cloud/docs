{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `network-1`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. В сети `network-1` [создайте](../../vpc/operations/subnet-create.md) две [подсети](../../vpc/concepts/network.md#subnet) в разных [зонах доступности](../../overview/concepts/geo-scope.md) со следующими параметрами:
     1. Подсеть в зоне доступности `{{ region-id }}-a`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.0.0/24`.
     1. Подсеть в зоне доступности `{{ region-id }}-b`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.
  1. В сети `network-1` [создайте группы безопасности](../../vpc/operations/security-group-create.md):
     1. С именем `bitrix-sg-vm` для ВМ в облаке. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой [группы безопасности](../../vpc/concepts/security-groups.md) в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `HTTP` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `SSH` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

     1. С именем `bitrix-sg` для кластера баз данных {{ MY }}. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой группы безопасности в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `3306` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

{% endlist %}