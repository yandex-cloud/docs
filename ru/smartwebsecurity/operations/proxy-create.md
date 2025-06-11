---
title: Как создать прокси-сервер в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать прокси-сервер для обработки входящих запросов и защиты доменов в {{ sws-full-name }}.
---

# Создать прокси-сервер

{% note info %}

На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

{% endnote %}

{% list tabs group=instructions %}

[Прокси-сервер](../concepts/domain-protect.md#proxy) принимает запросы от пользователей к вашему сайту или веб-приложению и направляет их на проверку. 

Вы можете добавить несколько прокси-серверов, например, чтобы разделить стабильную версию приложения и версию, которая находится в разработке.

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
  1. Введите произвольное имя прокси-сервера.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md).
  1. (Опционально) Чтобы сохранять подробную информацию об операциях с запросами:

      1. Включите опцию **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.
      1. Выберите существующую лог-группу или [создайте новую](../../logging/operations/create-group.md).
      1. (Опционально) Чтобы уменьшить объем хранимых логов, добавьте правила отбрасывания логов:

          1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}**.
          1. Выберите **HTTP-коды** и (опционально) **Классы HTTP-кодов**, для которых будут отбрасываться логи.
          1. Укажите в процентах, какую часть логов нужно отбрасывать.
          1. Если для разных HTTP-кодов требуется отбрасывать разные доли логов, добавьте дополнительные правила.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

{% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](domain-create.md)
