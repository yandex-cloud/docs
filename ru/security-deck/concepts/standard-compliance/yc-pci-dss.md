---
title: Стандарт PCI DSS в {{ yandex-cloud }}
description: В этом разделе приведен набор правил, который помогает автоматизировать соответствие требованиям стандарта безопасности данных индустрии платежных карт (PCI DSS) в ресурсах {{ yandex-cloud }}.
---

# Стандарт PCI DSS в {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Данный набор правил помогает автоматизировать соответствие требованиям некоторых стандартов безопасности данных, разработанных для защиты информации о платежных картах.

Стандарт был создан Советом по стандартам безопасности индустрии платежных карт (PCI SSC, Payment Card Industry Data Security Standard), который был основан ведущими международными платежными системами: Visa, MasterCard, American Express, Discover и JCB.

Эти правила помогают обеспечить соответствие требованиям стандарта PCI DSS:

#|
|| Идентификатор требования | Требование стандарта безопасности | Идентификаторы проверки в [модуле {{ cspm-name }}](../cspm.md) ||
|| **1. Установка и поддержка средств управления сетевой безопасностью** {.cell-align-center} | > | > ||
|| 1.2 | Конфигурация и обслуживание средств управления сетевой безопасностью (NSC) |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
||
|| 1.3 | Ограничение сетевого доступа к среде данных платежных карт (CDE) и из нее |
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| 1.4 | Контроль сетевых соединений между доверенными и недоверенными сетями |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
||
|| **2. Применение безопасных конфигураций ко всем системным компонентам** {.cell-align-center} | > | > ||
|| 2.2 | Безопасная конфигурация и управление системными компонентами |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
||
|| **3. Защита хранимых данных учетных записей** {.cell-align-center} | > | > ||
|| 3.2, 3.3, 3.4 | Минимизация хранения, запрет хранения SAD, ограничение отображения PAN | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| 3.5 | Обеспечение нечитаемости PAN при хранении |
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
[cspm.crypto.data.application-encryption](../../rules-reference/cspm.md#application-encryption)
||
|| 3.6, 3.7 | Защита и управление криптографическими ключами |
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm)
[cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation)
[cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection)
[cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
[cspm.crypto.secrets-coi](../../rules-reference/cspm.md#secrets-coi)
||
|| **4. Защита данных держателей карт с использованием надежной криптографии при передаче по открытым, общедоступным сетям** {.cell-align-center} | > | > ||
|| 4.2 | Защита PAN надежной криптографией при передаче |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
||
|| **5. Защита всех систем и сетей от вредоносного ПО** {.cell-align-center} | > | > ||
|| 5.2, 5.3 | Предотвращение, обнаружение и устранение вредоносного ПО; поддержка механизмов в активном состоянии | [cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy) ||
|| 5.4 | Защита пользователей от фишинговых атак | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| **6. Разработка и поддержка безопасных систем и программного обеспечения** {.cell-align-center} | > | > ||
|| 6.3 | Выявление и устранение уязвимостей безопасности |
[cspm.active.ip-vulnerability-scan](../../rules-reference/cspm.md#ip-vulnerability-scan)
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
[cspm.k8s.version-update](../../rules-reference/cspm.md#version-update)
||
|| 6.4 | Защита общедоступных веб-приложений от атак |
[cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws)
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3)
||
|| **7. Ограничение доступа к системным компонентам и данным держателей карт по принципу служебной необходимости** {.cell-align-center} | > | > ||
|| 7.2 | Надлежащее определение и назначение доступа к системным компонентам и данным |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
[cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access)
[cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| 7.3 | Управление доступом к системным компонентам и данным через систему(-ы) контроля доступа | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| **8. Идентификация пользователей и аутентификация доступа к системным компонентам** {.cell-align-center} | > | > ||
|| 8.3 | Надежная аутентификация для пользователей и администраторов |
[cspm.access.serial-console](../../rules-reference/cspm.md#serial-console)
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
||
|| 8.6 | Управление использованием учетных записей приложений/систем |
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
||
|| **10. Регистрация и мониторинг всех событий доступа к системным компонентам и данным держателей карт** {.cell-align-center} | > | > ||
|| 10.2 | Журналы событий безопасности создаются и содержат необходимые детали |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
[cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events)
[cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs)
||
|| **11. Регулярное тестирование безопасности систем и сетей** {.cell-align-center} | > | > ||
|| 11.3 | Регулярное выявление, приоритизация и устранение внешних и внутренних уязвимостей |
[cspm.active.ip-vulnerability-scan](../../rules-reference/cspm.md#ip-vulnerability-scan)
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
||
|| **12. Поддержка информационной безопасности с помощью организационных политик и программ** {.cell-align-center} | > | > ||
|| 12.10 | Реагирование на инциденты |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
[cspm.k8s.backup](../../rules-reference/cspm.md#backup)
||
|#
