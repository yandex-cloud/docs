---
title: Настройка групп безопасности и ограничение доступа к инстансу {{ mgl-full-name }}
description: Из статьи вы узнаете про настройку групп безопасности и ограничение доступа к инстансу {{ mgl-name }}, а также ознакомитесь с правилами входящего и исходящего трафика.
---

# Настройка групп безопасности и ограничение доступа к инстансу {{ mgl-name }}

Правила [группы безопасности](../../vpc/concepts/security-groups.md) определяют:

* для каких IP-адресов доступен инстанс, в том числе доступен ли он из интернета;
* по какому протоколу можно работать с Git-репозиториями в инстансе {{ GL }}: [SSH](../../glossary/ssh-keygen.md) или HTTPS;
* какой сертификат можно использовать при работе по HTTPS: [сертификат Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (по умолчанию) или [собственный сертификат]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually);
* выделен ли доступ к [{{ GL }} Container Registry]({{ gl.docs }}/ee/user/packages/container_registry/).

{% note warning %}

От настройки группы безопасности зависит работоспособность и доступность инстанса {{ mgl-name }}.

{% endnote %}

Чтобы настроить группу безопасности инстанса {{ mgl-name }}:
1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в имеющуюся группу безопасности правила для [входящего](#ingress-rules) и [исходящего](#egress-rules) трафика или [создайте](../../vpc/operations/security-group-create.md) новую группу с указанными правилами.
1. Примените группу безопасности к инстансу {{ GL }} при [создании](instance/instance-create.md) или [изменении](instance/instance-update.md).

Если к инстансу не привязать отдельную группу безопасности, к нему применится группа, созданная по умолчанию в сети инстанса. Правила этой группы безопасности, добавленные для других сервисов, влияют на доступ к инстансу {{ GL }}.

Если у вас возникли проблемы с настройкой группы безопасности, обратитесь в [техническую поддержку]({{ link-console-support }}).

## Правила для входящего трафика {#ingress-rules}

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
|| Для работы с Git-репозиториями по протоколу HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — задайте диапазоны адресов подсетей внутри {{ yandex-cloud }} или публичные IP-адреса компьютеров в интернете, чтобы открыть доступ для подсетей и компьютеров.
||
|| Для использования сертификата Let's Encrypt.

Такой сертификат [используется по умолчанию]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) при работе с Git-репозиториями по протоколу HTTPS. Если вы не указываете это правило, то для работы по протоколу HTTPS [добавьте собственный сертификат]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually). |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-http }}` и `{{ port-https }}`. Для каждого порта создайте отдельное правило.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `0.0.0.0/0`.
||
|| Для создания резервных копий инстанса. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `213.180.193.243/32`.
||
|| Для [проверки доступности ресурсов](../../network-load-balancer/concepts/health-check.md) сетевым балансировщиком. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `80`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
||
|| Для подключения к {{ GL }} Container Registry. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — задайте диапазоны адресов подсетей внутри {{ yandex-cloud }} или публичные IP-адреса компьютеров в интернете, чтобы открыть доступ для подсетей и компьютеров.

   Чтобы разрешить трафик с любых IP-адресов, укажите `0.0.0.0/0`.
||
|#

## Правила для исходящего трафика {#egress-rules}

{{ mgl-name }} использует для работы внешние ресурсы. Если в группе безопасности инстанса вы ограничили исходящий трафик, инстанс может работать некорректно. Чтобы избежать этого, добавьте в группу безопасности следующие правила:

#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для использования сертификата Let's Encrypt. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `0.0.0.0/0`.
||
|| Для создания резервных копий инстанса. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `213.180.193.243/32`.
||
|| Для запросов в службу [метаданных](../../compute/concepts/vm-metadata.md) при обновлении инстанса. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `80`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `169.254.169.254/32`.
||
|| Для запросов в службу DNS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `53`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_udp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `<второй_IP-адрес_в_подсети>/32`. Например для подсети `10.128.0.0/24` это будет CIDR `10.128.0.2/32`.
   
   Если в вашей подсети есть собственный DNS-сервер, также разрешите исходящий трафик к нему, например `IP-адрес_DNS_сервера/32`.
||
|| Для запросов к NTP-серверам для поддержки двухфакторной аутентификации. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `123`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_udp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `0.0.0.0/0`.
||
|| Для доступа к воркерам под управлением раннера, [созданного с помощью консоли управления](../tutorials/install-gitlab-runner.md#create-runner). |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `22`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR подсети, в которой находится инстанс {{ mgl-name }} (воркеры создаются в ней же). Например `10.128.0.0/24`.
||
|#
