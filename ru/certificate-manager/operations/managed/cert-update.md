# Обновить сертификат

{{ certificate-manager-name }} запускает процедуру обновления сертификата за 30 дней до окончания срока действия сертификата. Статус сертификата изменится на `Renewing`.

{% note info %}

В некоторых случаях обновление сертификата не требует участия пользователя. Подробнее в разделе [Автоматическая проверка прав](../../concepts/challenges.md#auto). 

{% endnote %}

Чтобы обновить сертификат от Let's Encrypt:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Выберите в списке сертификат в статусе `Renewing`, который необходимо обновить.
    1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** будет указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).
    1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** изменится на `Valid`.
    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`. 

- API {#api}

    Чтобы обновить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/Certificate/update.md).

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}