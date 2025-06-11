---
title: Как проверить доступность ресурсов в домене {{ sws-name }}
description: Следуя данной инструкции, вы сможете проверить статус и доступность ваших ресурсов из балансировщика прокси-сервера {{ sws-full-name }}.
---

# Проверить доступность ресурсов

Убедитесь, что [прокси-сервер](../concepts/domain-protect.md#proxy), [домен](../concepts/domain-protect.md#domain) и ваша инфраструктура настроены корректно, а балансировщик прокси-сервера имеет доступ к привязанным ресурсам:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [validate-resource-stats](../../_includes/smartwebsecurity/validate-resource-stats.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](setup-infrastructure.md)
* [{#T}](proxy-create.md)
* [{#T}](domain-create.md)
* [{#T}](host-connect.md)

