[Документация Yandex Cloud](../index.md) > Yandex Certificate Manager > Certificate Manager

# Yandex Certificate Manager

Yandex Certificate Manager — сервис для получения и обновления TLS-сертификатов от Let's Encrypt, а также для загрузки собственных сертификатов, которые можно использовать для доступа к сайтам, шлюзам API Gateway и ресурсам Cloud CDN по протоколу HTTPS, а также для обработки TLS-трафика в Application Load Balancer.

# Yandex Certificate Manager

 - [Начало работы](quickstart/index.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Сертификат от Let's Encrypt

 - [Добавление сертификата](operations/managed/cert-create.md)

 - [Получение содержимого сертификата](operations/managed/cert-get-content.md)

 - [Прохождение процедуры проверки прав на домен](operations/managed/cert-validate.md)

 - [Обновление сертификата](operations/managed/cert-update.md)

 - [Изменение сертификата](operations/managed/cert-modify.md)

 - [Удаление сертификата](operations/managed/cert-delete.md)

### Пользовательский сертификат

 - [Добавление сертификата](operations/import/cert-create.md)

 - [Получение содержимого сертификата](operations/import/cert-get-content.md)

 - [Обновление сертификата](operations/import/cert-update.md)

 - [Изменение сертификата](operations/import/cert-modify.md)

 - [Удаление сертификата](operations/import/cert-delete.md)

 - [Резервное копирование](operations/cert-backup.md)

 - [Добавление алерта для сертификата](operations/alert.md)

 - [Настроить права доступа к сертификату](operations/cert-access.md)

 - [Посмотреть операции с сертификатом](operations/operation-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Организация виртуального хостинга](tutorials/virtual-hosting.md)

 - [Хостинг статического сайта на фреймворке Gatsby в Object Storage](tutorials/gatsby-static-website.md)

### Терминирование TLS-соединений

 - [Обзор](tutorials/tls-termination/index.md)

 - [Консоль управления](tutorials/tls-termination/console.md)

 - [Terraform](tutorials/tls-termination/terraform.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Сертификат от Let's Encrypt](concepts/managed-certificate.md)

 - [Пользовательский сертификат](concepts/imported-certificate.md)

 - [Проверка прав на домен](concepts/challenges.md)

 - [Интеграция с сервисами Yandex Cloud](concepts/services.md)

 - [Квоты и лимиты](concepts/limits.md)

### Домен

 - [Обзор](concepts/domains/index.md)

 - [Интеграция с сервисами Yandex Cloud](concepts/domains/services.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### certificate

 - [Overview](cli-ref/certificate/index.md)

 - [add-access-binding](cli-ref/certificate/add-access-binding.md)

 - [content](cli-ref/certificate/content.md)

 - [create](cli-ref/certificate/create.md)

 - [delete](cli-ref/certificate/delete.md)

 - [get](cli-ref/certificate/get.md)

 - [list](cli-ref/certificate/list.md)

 - [list-access-bindings](cli-ref/certificate/list-access-bindings.md)

 - [list-operations](cli-ref/certificate/list-operations.md)

 - [remove-access-binding](cli-ref/certificate/remove-access-binding.md)

 - [request](cli-ref/certificate/request.md)

 - [set-access-bindings](cli-ref/certificate/set-access-bindings.md)

 - [update](cli-ref/certificate/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### certificate

 - [Overview](cli-ref/v0/certificate/index.md)

 - [add-access-binding](cli-ref/v0/certificate/add-access-binding.md)

 - [content](cli-ref/v0/certificate/content.md)

 - [create](cli-ref/v0/certificate/create.md)

 - [delete](cli-ref/v0/certificate/delete.md)

 - [get](cli-ref/v0/certificate/get.md)

 - [list](cli-ref/v0/certificate/list.md)

 - [list-access-bindings](cli-ref/v0/certificate/list-access-bindings.md)

 - [list-operations](cli-ref/v0/certificate/list-operations.md)

 - [remove-access-binding](cli-ref/v0/certificate/remove-access-binding.md)

 - [request](cli-ref/v0/certificate/request.md)

 - [set-access-bindings](cli-ref/v0/certificate/set-access-bindings.md)

 - [update](cli-ref/v0/certificate/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### CertificateContent

 - [Overview](api-ref/grpc/CertificateContent/index.md)

 - [Get](api-ref/grpc/CertificateContent/get.md)

 - [GetEx](api-ref/grpc/CertificateContent/getEx.md)

#### Certificate

 - [Overview](api-ref/grpc/Certificate/index.md)

 - [Get](api-ref/grpc/Certificate/get.md)

 - [List](api-ref/grpc/Certificate/list.md)

 - [ListVersions](api-ref/grpc/Certificate/listVersions.md)

 - [Create](api-ref/grpc/Certificate/create.md)

 - [Update](api-ref/grpc/Certificate/update.md)

 - [Delete](api-ref/grpc/Certificate/delete.md)

 - [RequestNew](api-ref/grpc/Certificate/requestNew.md)

 - [ListOperations](api-ref/grpc/Certificate/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Certificate/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Certificate/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Certificate/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Certificate Manager Private CA API

 - [Overview](privateca/api-ref/grpc/index.md)

##### Operation

 - [Overview](privateca/api-ref/grpc/Operation/index.md)

 - [Get](privateca/api-ref/grpc/Operation/get.md)

 - [Cancel](privateca/api-ref/grpc/Operation/cancel.md)

##### Policy

 - [Overview](privateca/api-ref/grpc/Policy/index.md)

 - [Create](privateca/api-ref/grpc/Policy/create.md)

 - [Update](privateca/api-ref/grpc/Policy/update.md)

 - [Delete](privateca/api-ref/grpc/Policy/delete.md)

 - [Get](privateca/api-ref/grpc/Policy/get.md)

 - [List](privateca/api-ref/grpc/Policy/list.md)

 - [ListAccessBindings](privateca/api-ref/grpc/Policy/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/grpc/Policy/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/grpc/Policy/updateAccessBindings.md)

##### PrivateCaCertificateContent

 - [Overview](privateca/api-ref/grpc/PrivateCaCertificateContent/index.md)

 - [GetChain](privateca/api-ref/grpc/PrivateCaCertificateContent/getChain.md)

 - [GetPrivateKey](privateca/api-ref/grpc/PrivateCaCertificateContent/getPrivateKey.md)

##### PrivateCaCertificate

 - [Overview](privateca/api-ref/grpc/PrivateCaCertificate/index.md)

 - [IssueCertificate](privateca/api-ref/grpc/PrivateCaCertificate/issueCertificate.md)

 - [IssueCertificateByCsr](privateca/api-ref/grpc/PrivateCaCertificate/issueCertificateByCsr.md)

 - [Update](privateca/api-ref/grpc/PrivateCaCertificate/update.md)

 - [Delete](privateca/api-ref/grpc/PrivateCaCertificate/delete.md)

 - [Get](privateca/api-ref/grpc/PrivateCaCertificate/get.md)

 - [List](privateca/api-ref/grpc/PrivateCaCertificate/list.md)

 - [RevokeCertificate](privateca/api-ref/grpc/PrivateCaCertificate/revokeCertificate.md)

 - [ListAccessBindings](privateca/api-ref/grpc/PrivateCaCertificate/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/grpc/PrivateCaCertificate/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/grpc/PrivateCaCertificate/updateAccessBindings.md)

##### PrivateCaContent

 - [Overview](privateca/api-ref/grpc/PrivateCaContent/index.md)

 - [GetChain](privateca/api-ref/grpc/PrivateCaContent/getChain.md)

 - [GetPrivateKey](privateca/api-ref/grpc/PrivateCaContent/getPrivateKey.md)

##### PrivateCa

 - [Overview](privateca/api-ref/grpc/PrivateCa/index.md)

 - [GenerateCertificateAuthority](privateca/api-ref/grpc/PrivateCa/generateCertificateAuthority.md)

 - [GenerateCertificateAuthorityByCsr](privateca/api-ref/grpc/PrivateCa/generateCertificateAuthorityByCsr.md)

 - [ImportCertificateAuthority](privateca/api-ref/grpc/PrivateCa/importCertificateAuthority.md)

 - [GenerateCsrForCertificateAuthority](privateca/api-ref/grpc/PrivateCa/generateCsrForCertificateAuthority.md)

 - [SendSignedCertificateOfCertificateAuthority](privateca/api-ref/grpc/PrivateCa/sendSignedCertificateOfCertificateAuthority.md)

 - [Delete](privateca/api-ref/grpc/PrivateCa/delete.md)

 - [GetCsrForCertificateAuthority](privateca/api-ref/grpc/PrivateCa/getCsrForCertificateAuthority.md)

 - [Get](privateca/api-ref/grpc/PrivateCa/get.md)

 - [List](privateca/api-ref/grpc/PrivateCa/list.md)

 - [Update](privateca/api-ref/grpc/PrivateCa/update.md)

 - [ListAccessBindings](privateca/api-ref/grpc/PrivateCa/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/grpc/PrivateCa/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/grpc/PrivateCa/updateAccessBindings.md)

##### Template

 - [Overview](privateca/api-ref/grpc/Template/index.md)

 - [Create](privateca/api-ref/grpc/Template/create.md)

 - [Delete](privateca/api-ref/grpc/Template/delete.md)

 - [Get](privateca/api-ref/grpc/Template/get.md)

 - [List](privateca/api-ref/grpc/Template/list.md)

 - [Update](privateca/api-ref/grpc/Template/update.md)

 - [ListAccessBindings](privateca/api-ref/grpc/Template/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/grpc/Template/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/grpc/Template/updateAccessBindings.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### CertificateContent

 - [Overview](api-ref/CertificateContent/index.md)

 - [Get](api-ref/CertificateContent/get.md)

 - [GetEx](api-ref/CertificateContent/getEx.md)

#### Certificate

 - [Overview](api-ref/Certificate/index.md)

 - [Get](api-ref/Certificate/get.md)

 - [List](api-ref/Certificate/list.md)

 - [ListVersions](api-ref/Certificate/listVersions.md)

 - [Create](api-ref/Certificate/create.md)

 - [Update](api-ref/Certificate/update.md)

 - [Delete](api-ref/Certificate/delete.md)

 - [RequestNew](api-ref/Certificate/requestNew.md)

 - [ListOperations](api-ref/Certificate/listOperations.md)

 - [ListAccessBindings](api-ref/Certificate/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Certificate/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Certificate/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Certificate Manager Private CA API

 - [Overview](privateca/api-ref/index.md)

##### Operation

 - [Overview](privateca/api-ref/Operation/index.md)

 - [Get](privateca/api-ref/Operation/get.md)

 - [Cancel](privateca/api-ref/Operation/cancel.md)

##### Policy

 - [Overview](privateca/api-ref/Policy/index.md)

 - [Create](privateca/api-ref/Policy/create.md)

 - [Update](privateca/api-ref/Policy/update.md)

 - [Delete](privateca/api-ref/Policy/delete.md)

 - [Get](privateca/api-ref/Policy/get.md)

 - [List](privateca/api-ref/Policy/list.md)

 - [ListAccessBindings](privateca/api-ref/Policy/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/Policy/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/Policy/updateAccessBindings.md)

##### PrivateCaCertificateContent

 - [Overview](privateca/api-ref/PrivateCaCertificateContent/index.md)

 - [GetChain](privateca/api-ref/PrivateCaCertificateContent/getChain.md)

 - [GetPrivateKey](privateca/api-ref/PrivateCaCertificateContent/getPrivateKey.md)

##### PrivateCaCertificate

 - [Overview](privateca/api-ref/PrivateCaCertificate/index.md)

 - [IssueCertificate](privateca/api-ref/PrivateCaCertificate/issueCertificate.md)

 - [IssueCertificateByCsr](privateca/api-ref/PrivateCaCertificate/issueCertificateByCsr.md)

 - [Update](privateca/api-ref/PrivateCaCertificate/update.md)

 - [Delete](privateca/api-ref/PrivateCaCertificate/delete.md)

 - [Get](privateca/api-ref/PrivateCaCertificate/get.md)

 - [List](privateca/api-ref/PrivateCaCertificate/list.md)

 - [RevokeCertificate](privateca/api-ref/PrivateCaCertificate/revokeCertificate.md)

 - [ListAccessBindings](privateca/api-ref/PrivateCaCertificate/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/PrivateCaCertificate/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/PrivateCaCertificate/updateAccessBindings.md)

##### PrivateCaContent

 - [Overview](privateca/api-ref/PrivateCaContent/index.md)

 - [GetChain](privateca/api-ref/PrivateCaContent/getChain.md)

 - [GetPrivateKey](privateca/api-ref/PrivateCaContent/getPrivateKey.md)

##### PrivateCa

 - [Overview](privateca/api-ref/PrivateCa/index.md)

 - [GenerateCertificateAuthority](privateca/api-ref/PrivateCa/generateCertificateAuthority.md)

 - [GenerateCertificateAuthorityByCsr](privateca/api-ref/PrivateCa/generateCertificateAuthorityByCsr.md)

 - [ImportCertificateAuthority](privateca/api-ref/PrivateCa/importCertificateAuthority.md)

 - [GenerateCsrForCertificateAuthority](privateca/api-ref/PrivateCa/generateCsrForCertificateAuthority.md)

 - [SendSignedCertificateOfCertificateAuthority](privateca/api-ref/PrivateCa/sendSignedCertificateOfCertificateAuthority.md)

 - [Delete](privateca/api-ref/PrivateCa/delete.md)

 - [GetCsrForCertificateAuthority](privateca/api-ref/PrivateCa/getCsrForCertificateAuthority.md)

 - [Get](privateca/api-ref/PrivateCa/get.md)

 - [List](privateca/api-ref/PrivateCa/list.md)

 - [Update](privateca/api-ref/PrivateCa/update.md)

 - [ListAccessBindings](privateca/api-ref/PrivateCa/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/PrivateCa/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/PrivateCa/updateAccessBindings.md)

##### Template

 - [Overview](privateca/api-ref/Template/index.md)

 - [Create](privateca/api-ref/Template/create.md)

 - [Delete](privateca/api-ref/Template/delete.md)

 - [Get](privateca/api-ref/Template/get.md)

 - [List](privateca/api-ref/Template/list.md)

 - [Update](privateca/api-ref/Template/update.md)

 - [ListAccessBindings](privateca/api-ref/Template/listAccessBindings.md)

 - [SetAccessBindings](privateca/api-ref/Template/setAccessBindings.md)

 - [UpdateAccessBindings](privateca/api-ref/Template/updateAccessBindings.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## Справочник аудитных логов

 - [CreateCaUsageRestriction](events-ref/CreateCaUsageRestriction.md)

 - [CreateCertificate](events-ref/CreateCertificate.md)

 - [CreateDomain](events-ref/CreateDomain.md)

 - [DeleteCaUsageRestriction](events-ref/DeleteCaUsageRestriction.md)

 - [DeleteCertificate](events-ref/DeleteCertificate.md)

 - [DeleteDomain](events-ref/DeleteDomain.md)

 - [GetCertificateContent](events-ref/GetCertificateContent.md)

 - [GetExCertificateContent](events-ref/GetExCertificateContent.md)

 - [SetCaUsageRestrictionAccessBindings](events-ref/SetCaUsageRestrictionAccessBindings.md)

 - [SetCertificateAccessBindings](events-ref/SetCertificateAccessBindings.md)

 - [SetCertificateAuthorityAccessBindings](events-ref/SetCertificateAuthorityAccessBindings.md)

 - [SetDomainPrimaryCertificate](events-ref/SetDomainPrimaryCertificate.md)

 - [UpdateCaUsageRestriction](events-ref/UpdateCaUsageRestriction.md)

 - [UpdateCaUsageRestrictionAccessBindings](events-ref/UpdateCaUsageRestrictionAccessBindings.md)

 - [UpdateCertificate](events-ref/UpdateCertificate.md)

 - [UpdateCertificateAccessBindings](events-ref/UpdateCertificateAccessBindings.md)

 - [UpdateCertificateAuthorityAccessBindings](events-ref/UpdateCertificateAuthorityAccessBindings.md)

 - [UpdateDomain](events-ref/UpdateDomain.md)

 - [UpdateDomainAccessBindings](events-ref/UpdateDomainAccessBindings.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)