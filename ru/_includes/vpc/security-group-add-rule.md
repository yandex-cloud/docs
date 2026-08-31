Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}** и в открывшемся окне:

  1. Выберите опцию **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** выберите назначение правила:
    * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов.
    * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`. Выберите вариант:
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` — правило будет применено к ВМ из текущей группы.
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}` — правило будет применено к ВМ из выбранной группы. IP-адреса источника или назначения при обмене трафиком должны быть из [частных диапазонов](../../vpc/concepts/network.md#subnet). Подробнее в разделе [Концепции](../../vpc/concepts/security-groups.md#groups).
      * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, разрешающее проверки состояния ресурсов от [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) или [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
  1. (Опционально) добавьте описание.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.