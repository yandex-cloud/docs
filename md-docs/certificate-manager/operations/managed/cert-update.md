# Обновить сертификат

{{ certificate-manager-name }} запускает процедуру обновления сертификата за 30 дней до окончания срока действия сертификата. Статус сертификата изменится на `Renewing`.

{% note info %}

В некоторых случаях обновление сертификата не требует участия пользователя. Подробнее в разделе [Автоматическая проверка прав](../../concepts/challenges.md#auto). 

{% endnote %}

Чтобы обновить сертификат от Let's Encrypt:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Выберите сертификат в статусе `Renewing`, который необходимо обновить.
    1. В блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** будет указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).
    1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** изменится на `Valid`.
    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`. 

- API {#api}

    Чтобы обновить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/Certificate/update.md).

{% endlist %}

{% note info %}

Чтобы DNS-проверка прав на домен по записи `CNAME` прошла успешно, для поддомена `_acme-challenge` проверяемого доменного имени не должно быть других [ресурсных записей](../../../dns/concepts/resource-record.md), кроме `CNAME`. Например, для имени `_acme-challenge.example.com.` должна существовать только CNAME-запись и не должно быть TXT-записи.

{% endnote %}