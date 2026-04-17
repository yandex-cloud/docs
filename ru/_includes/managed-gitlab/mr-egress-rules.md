#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для взаимодействия с публичным адресом инстанса {{ GL }} по протоколу HTTPS (например, для клонирования репозиториев, загрузки артефактов).
Обязательное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — публичный адрес {{ GL }}.
||
|| Для доступа к реестру артефактов (например, Cloud Registry, dockerhub.io).
Рекомендуемое правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`, `5000` или другой.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR реестров, к которым предоставляется доступ. Чтобы разрешить трафик на любые IP-адреса, укажите `0.0.0.0/0`.
||
|| Для доступа к объектным хранилищам (например, LFS, Container Registry).
Рекомендуемое правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR объектных хранилищ, к которым предоставляется доступ. Чтобы разрешить трафик на любые IP-адреса, укажите `0.0.0.0/0`.
||
|| Для доступа к внешним ресурсам.
Опциональное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`, `80` или другой.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR внешних ресурсов.
Если список ресурсов не определен, можно разрешить исходящий трафик к любым адресам (CIDR — `0.0.0.0/0`) через все порты. В этом случае можно пропустить настройку рекомендуемых правил и настройку доступа из управляемого раннера к публичному адресу инстанса {{ GL }}.
||
|#
