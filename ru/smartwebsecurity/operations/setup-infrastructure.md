---
title: Как настроить инфраструктуру при добавлении домена в {{ sws-name }}
description: Следуя данной инструкции, вы сможете настроить свой домен для работы через прокси-сервер {{ sws-full-name }}.
---

# Настроить инфраструктуру

Чтобы сетевой трафик между пользователями и ресурсами, подключенными к вашему домену, проходил через [прокси-сервер](../concepts/domain-protect.md#proxy) {{ sws-full-name }}, создайте в публичной [DNS-зоне](../../dns/concepts/dns-zone.md#public-zones) вашего домена [ресурсную запись](../../dns/concepts/resource-record.md#a) типа A. A-запись указывает, что запросы к вашему домену надо перенаправлять на публичный IPv4-адрес прокси-сервера. Чтобы запретить к ресурсам запросы, не прошедшие через прокси-сервер, настройте ограничения трафика на вашем сервере.

Чтобы настроить вашу инфраструктуру для работы через прокси-сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Узнайте публичный IPv4-адрес прокси-сервера:

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится ваш прокси-сервер.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
      1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** и выберите нужный прокси-сервер.

          Сохраните IPv4-адрес прокси-сервера, указанный в блоке **{{ ui-key.yacloud.common.overview }}** в поле **{{ ui-key.yacloud.smart-web-security.proxy-servers.publicIpColumn_dPwQF }}** — он понадобится для создания ресурсной DNS-записи.
  1. {% include [create-proxy-a-record](../../_includes/smartwebsecurity/create-proxy-a-record.md) %}
  1. {% include [limit-traffic-to-yc](../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](validate-availability.md)
* [{#T}](proxy-create.md)
* [{#T}](domain-create.md)
* [{#T}](host-connect.md)