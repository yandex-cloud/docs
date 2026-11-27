---
title: Как создать прокси-сервер в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать прокси-сервер для обработки входящих запросов и защиты доменов в {{ sws-full-name }}.
alternate:
  - href: ru/smartwebsecurity/operations/proxy-create.md
    type: text/markdown
    title: Markdown version
---

# Создать прокси-сервер

{% include [roles-for-creating-proxy-notice](../../_includes/smartwebsecurity/roles-for-creating-proxy-notice.md)%}

[Прокси-сервер](../concepts/domain-protect.md#proxy) принимает запросы от пользователей к вашему сайту или веб-приложению и направляет их на проверку.

Вы можете добавить несколько прокси-серверов, например, чтобы разделить стабильную версию приложения и версию, которая находится в разработке.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
  1. Введите произвольное имя прокси-сервера.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md).
  1. (Опционально) Чтобы записывать HTTP-запросы и результаты их проверки:

      1. Включите опцию **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.

         Логи будут записываться в {{ monium-logs-name }} в [проект каталога](*monium-folder-project) с прокси-сервером.
      1. (Опционально) Чтобы уменьшить объем хранимых логов, добавьте правила отбрасывания логов:

          1. В блоке **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.discard-rules-title_xn6cP }}** нажмите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}**.
          1. Выберите **HTTP-коды** или **Классы HTTP-кодов**, для которых нужно сократить запись логов.
          1. Укажите **Долю отбрасываемых логов**: `0%` — записывать все логи выбранных кодов, `100%` — отбрасывать все.

          Если для разных HTTP-кодов нужны разные доли отбрасывания, добавьте отдельные правила.

  1. Нажмите **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

{% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

{% endlist %}

{% note info %}

На прокси-сервере установлено ограничение MTU для всех пакетов — 1 450 байт.

{% endnote %}

#### Полезные ссылки {#see-also}

[{#T}](domain-create.md)

[*monium-folder-project]: {% include notitle [folder-project](../../_popups/monium/folder-project.md) %}
