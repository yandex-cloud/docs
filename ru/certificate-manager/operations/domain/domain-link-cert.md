---
title: Как привязать сертификат к домену
description: Следуя данной инструкции, вы сможете привязать сертификат к домену.
---

# Привязать сертификат к домену

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

Для подтверждения прав на домен к нему необходимо привязать [сертификат от Let's Encrypt](../../concepts/managed-certificate.md).

Привязанный к домену сертификат будет использован для обеспечения TLS-соединения в [интегрированных облачных сервисах](../../concepts/domains/services.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан домен.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Перейдите во вкладку **{{ ui-key.yacloud.certificate-manager.label_domains }}**.
    1. Выберите в списке домен, к которому необходимо привязать новый сертификат.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.certificate-manager.domain.action_bind-certificate }}**.
    1. В открывшемся окне выберите сертификат из списка подтвержденных сертификатов от Let's Encrypt с подходящим именем домена.  
    1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.domain.form.button_bind }}**.

{% endlist %}