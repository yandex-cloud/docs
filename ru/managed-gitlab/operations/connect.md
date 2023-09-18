# Подключение к инстансу {{ mgl-name }}

## Настройка групп безопасности {#configuring-security-groups}

В {{ mgl-name }} используется [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group) для выбранной [сети](../../vpc/concepts/network.md#network). Выбрать другую при создании инстанса нельзя.

Настройте группу безопасности по умолчанию для выбранной сети так, чтобы она разрешала входящий трафик с любых IP-адресов на порты 22, 2222, 80, 443, 5050. Для этого [создайте правила](../../vpc/operations/security-group-add-rule.md) для входящего трафика.

Для работы с Git-репозиторием по протоколу [SSH](../../glossary/ssh-keygen.md):
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

Для работы с Git-репозиторием по протоколу SSH:
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `2222`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

Для получения HTTP-трафика:
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `80`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

Для получения HTTPS-трафика:
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `443`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

Для подключения к [{{ container-registry-full-name }}](../../container-registry/):
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `5050`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

## Подключение к инстансу {#connect}

1. Задайте пароль администратора. Для этого перейдите по ссылке из письма, присланного на электронную почту администратора, указанную при регистрации инстанса.
1. Откройте в браузере ссылку на веб-интерфейс инстанса. Она указана в письме, отправленном на электронную почту администратора, и в [детальной информации об инстансе](instance/instance-list.md#get).
1. Авторизуйтесь с помощью логина и пароля администратора.