---
title: Руководство по использованию секретов {{ lockbox-full-name }} для хранения статических ключей доступа
description: Следуя данному руководству, вы сможете настроить сервисы {{ yandex-cloud }} с AWS-совместимым API на использование статических ключей доступа сервисных аккаунтов, хранящихся в секретах {{ lockbox-full-name }}.
alternate:
  - href: ru/tutorials/security/static-key-in-lockbox/index.md
    type: text/markdown
    title: Markdown version
---

# Использование секрета {{ lockbox-full-name }} для хранения статического ключа доступа

{% include [static-key-in-lockbox](../../../_tutorials/security/static-key-in-lockbox.md) %}

* [CLI](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру с помощью CLI.
* [{{ TF }}](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими с помощью подхода «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }} из репозитория GitHub, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).