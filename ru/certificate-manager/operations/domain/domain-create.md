---
title: "Как создать домен"
description: "Следуя данной инструкции, вы сможете создать домен."
---

# Создать домен

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

Чтобы создать домен:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан домен.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. На панели слева выберите ![image](../../../_assets/certificate-manager/domains.svg) **{{ ui-key.yacloud.certificate-manager.label_domains }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.domain.form.field_domain }}** введите доменное имя.
    1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** введите описание домена.
    1. В поле **{{ ui-key.yacloud.certificate-manager.domain.form.field_certificate }}** выберите сертификат из списка подтвержденных сертификатов от Let's Encrypt с подходящим именем домена.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    В списке доменов появится новый домен.

{% endlist %}
