# Настройка групп безопасности

Подключение к кластеру зависит от настроек групп безопасности. Убедитесь, что в правилах разрешен необходимый трафик.

{% note alert %}

При настройке групп безопасности не изменяйте [правила для служебного трафика](cluster-create.md#change-security-groups). Это может привести к неработоспособности кластера.

{% endnote %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- SSH

    * Для подключения к хостам подкластеров с публичным доступом из облачных сетей и интернета [настройте группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт `{{ port-ssh }}`. Для этого создайте следующее правило для входящего трафика:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * Для подключения к кластеру с промежуточной виртуальной машины:

      1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами подкластеров. Для этого создайте следующие правила:

          * для входящего трафика:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          * для исходящего трафика:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов подсети, в которой находятся хосты кластера. Если подкластеры находятся в разных подсетях, то создайте это правило для каждой подсети.

      1. [Настройте группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-ssh }}`. Для этого создайте следующее правило для входящего трафика:

          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — группа безопасности, в которой находится ВМ.

- UI Proxy

    Для использования [**UI Proxy**](../concepts/interfaces.md) [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности хоста подкластера правила, разрешающие входящий трафик через порт `{{ port-https }}`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    Если подключение выполняется через промежуточную ВМ, [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности хоста подкластера правила, разрешающие подключения через нее:

    * для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов подсети, в которой находится хост подкластера.

- Подключение с перенаправлением портов

    Если вы используете [перенаправление портов](connect-interfaces.md#routing), [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности промежуточной ВМ правила, разрешающие входящий и исходящий трафик через порты требуемых компонентов:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `<порт_компонента>`.

        Номера портов для компонентов {{ dataproc-name }} приведены в таблице:

        | Сервис                        | Порт  |
        | ----------------------------- | ----- |
        | HBase Master                  | 16010 |
        | HBase REST                    |  8085 |
        | HDFS Name Node                |  9870 |
        | Hive Server2                  | 10002 |
        | Livy                          |  8998 |
        | MapReduce Application History | 19888 |
        | Oozie                         | 11000 |
        | Spark History                 | 18080 |
        | YARN Application History      |  8188 |
        | YARN Resource Manager         |  8088 |
        | Zeppelin                      |  8890 |

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например разрешить трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены подкластеры.

{% endnote %}

Подробнее о группах безопасности в разделе [{#T}](../concepts/network.md#security-groups).