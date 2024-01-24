---
title: "Как настроить группы безопасности для инстанса {{ mgl-full-name }}"
---

# Настройка групп безопасности и ограничение доступа к инстансу {{ mgl-name }}

Правила [группы безопасности](../../vpc/concepts/security-groups.md) определяют:

* для каких IP-адресов доступен инстанс, в том числе доступен ли он из интернета;
* по какому протоколу можно работать с Git-репозиториями в инстансе {{ GL }}: [SSH](../../glossary/ssh-keygen.md) или HTTPS;
* какой сертификат можно использовать при работе по HTTPS: [сертификат Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (по умолчанию) или [собственный сертификат]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually);
* выделен ли доступ к [{{ GL }} {{ container-registry-name }}]({{ gl.docs }}/ee/user/packages/container_registry/).

Чтобы задать правила, которые разрешают определенный трафик для инстанса {{ GL }}:

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) в сети {{ yandex-cloud }}, выбранной для инстанса во время его создания.
1. [Добавьте](../../vpc/operations/security-group-add-rule.md) правила в группы безопасности для входящего трафика. Список правил [приведен ниже](#rules).

   {% note info %}

   Не настраивайте правила для исходящего трафика. Сервис {{ mgl-name }} использует для работы внешние ресурсы. Ограничение исходящего трафика может привести к частичной неработоспособности сервиса.

   {% endnote %}

1. [Обратитесь в службу поддержки]({{ link-console-support }}), чтобы привязать группу безопасности к инстансу {{ GL }}.

## Правила группы безопасности для входящего трафика {#rules}

#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для работы с Git-репозиториями по протоколу SSH. | 
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-ssh }}` и `2222`. Для каждого порта создайте отдельное правило.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — задайте диапазоны адресов подсетей внутри {{ yandex-cloud }} или публичные IP-адреса компьютеров в интернете, чтобы открыть доступ для подсетей и компьютеров. Примеры:

   * `172.16.0.0/12`.
   * `85.32.32.22/32`.

   Чтобы разрешить трафик с любых IP-адресов, укажите `0.0.0.0/0`.
|| 
|| Для использования сертификата Let's Encrypt.

Такой сертификат [используется по умолчанию]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) при работе с Git-репозиториями по протоколу HTTPS. Если вы не указываете это правило, то для работы по протоколу HTTPS [добавьте собственный сертификат]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually). |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-http }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `0.0.0.0/0`.
||
|| Для работы с Git-репозиториями по протоколу HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — задайте диапазоны адресов подсетей внутри {{ yandex-cloud }} или публичные IP-адреса компьютеров в интернете, чтобы открыть доступ для подсетей и компьютеров.
||
|| Для подключения к {{ GL }} {{ container-registry-name }}. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — задайте диапазоны адресов подсетей внутри {{ yandex-cloud }} или публичные IP-адреса компьютеров в интернете, чтобы открыть доступ для подсетей и компьютеров.

   Чтобы разрешить трафик с любых IP-адресов, укажите `0.0.0.0/0`.
||
|#
