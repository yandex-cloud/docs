# Стандарт по защите облачной инфраструктуры Yandex Cloud

Приведенный набор правил содержит элементы управления безопасностью на основе [Стандарта](../../../security/standard/all.md) по защите облачной инфраструктуры Yandex Cloud.

Стандарт по защите облачной инфраструктуры Yandex Cloud предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе Yandex Cloud.

Эти элементы управления помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей безопасности облачных сред:

#|
|| Идентификатор требования | Требование [стандарта безопасности](../../../security/standard/all.md) | Идентификаторы проверки в [модуле CSPM](../cspm.md) ||
|| **Аутентификация и управление доступом** {align="center"} | > | > ||
|| `IAM2` | [Настроено сопоставление групп пользователей в федерации удостоверений](../../../security/standard/all.md#group-mapping) | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#access-user-groups-mapping) ||
|| `IAM4` | [Таймаут жизни cookie в федерации меньше 6 часов](../../../security/standard/all.md#cookie-timeout) | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#cookie-timeout-organization) ||
|| `IAM5` | [Только необходимые администраторы управляют членством в IAM-группах](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| `IAM6` | [Используются сервисные роли вместо примитивных: admin, editor, viewer, auditor](../../../security/standard/all.md#min-privileges) | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| `IAM9` | [Сервисным аккаунтам назначены минимальные привилегии](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| `IAM10` | [Только доверенные администраторы имеют доступ к сервисным аккаунтам](../../../security/standard/all.md#sa-admins) | [cspm.access.privileged-sa-access](../../rules-reference/cspm.md#access-privileged-sa-access) ||
|| `IAM11` | [Выполняется периодическая ротация ключей сервисных аккаунтов](../../../security/standard/all.md#sa-key-rotation) | [cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
|| `IAM12` | [Для API-ключей сервисных аккаунтов задана область действия](../../../security/standard/all.md#api-key-scopes) | [cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes) ||
|| `IAM16` | [На ВМ отключено получение токена через AWS IMDSv1](../../../security/standard/all.md#aws-token) | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| `IAM18` | [Привилегированные роли назначены только доверенным администраторам](../../../security/standard/all.md#privileged-users) | [cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles) ||
|| `IAM22` | [Для ресурсов в организации отсутствует публичный доступ](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| `IAM24` | [На ресурсах используются метки](../../../security/standard/all.md#labels) | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| `IAM27` | [Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием Yandex Security Deck CIEM](../../../security/standard/all.md#ciem-access-control) | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings) ||
|| **Сетевая безопасность** {align="center"} | > | > ||
|| `NET1` | [Для объектов облака используется межсетевой экран или группы безопасности](../../../security/standard/all.md#firewall) | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| `NET2` | [В Yandex Virtual Private Cloud существует как минимум одна группа безопасности](../../../security/standard/all.md#vpc-sg) | [cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall) ||
|| `NET3` | [В группах безопасности отсутствует слишком широкое правило доступа](../../../security/standard/all.md#access-rule) |
[cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#k8s-network-firewall-scope)
||
|| `NET4` | [Доступ по управляющим портам открыт только для доверенных IP-адресов](../../../security/standard/all.md#trusted-ip) |
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| `NET5` | [Включена защита от DDoS-атак](../../../security/standard/all.md#ddos-protection) |
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
||
|| **Безопасная конфигурация виртуальной среды** {align="center"} | > | > ||
|| `ENV1` | [Использование серийной консоли контролируется либо отсутствует](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| `ENV7` | [Отсутствует публичный доступ к бакету Object Storage](../../../security/standard/all.md#bucket-access) | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| `ENV8` | [В Object Storage используются политики доступа (Bucket Policy)](../../../security/standard/all.md#bucket-policy) | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| `ENV9` | [В Object Storage включена функция «Блокировка версии объекта» (objectlock)](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| `ENV14` | [На управляемых базах данных назначена Группа безопасности](../../../security/standard/all.md#db-security-group) | [cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group) ||
|| `ENV15` | [На управляемых базах данных не назначен публичный IP-адрес](../../../security/standard/all.md#db-ip) | [cspm.network.db-ip](../../rules-reference/cspm.md#db-ip) ||
|| `ENV16` | [Включена настройка защиты от удаления (deletion protection)](../../../security/standard/all.md#deletion-protection) | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| `ENV17` | [Выключена настройка доступа из DataLens без необходимости](../../../security/standard/all.md#db-datalens-access) | [cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access) ||
|| `ENV18` | [На управляемых БД выключен доступ из консоли управления](../../../security/standard/all.md#db-console-access) | [cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access) ||
|| `ENV19` | [Serverless Containers/Cloud Functions использует внутреннюю сеть VPC](../../../security/standard/all.md#vpc-functions) | [cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc) ||
|| `ENV26` | [Публичный доступ отсутствует для YDB](../../../security/standard/all.md#ydb-public) | [cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public) ||
|| `ENV28` | [Настроен ACL по IP-адресам для Yandex Container Registry](../../../security/standard/all.md#acl-container-registry) | [cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry) ||
|| `ENV29` | [Срок действия сертификата Yandex Certificate Manager составляет как минимум 30 дней](../../../security/standard/all.md#certificate-validity) | [cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity) ||
|| `ENV33` | [Для подключения к виртуальной машине или узлу Kubernetes используется OS Login](../../../security/standard/all.md#os-login-onto-hosts) | [cspm.access.os-login-onto-hosts.vm](../../rules-reference/cspm.md#vm) ||
|| `ENV37` | [Используется Cloud Backup или механизм snapshot по расписанию](../../../security/standard/all.md#snapshot) |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| **Шифрование данных и управление ключами** {align="center"} | > | > ||
|| `CRYPT1` | [В Yandex Object Storage включено шифрование данных at rest с ключом KMS](../../../security/standard/all.md#storage-kms) | [cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption) ||
|| `CRYPT2` | [В Yandex Object Storage включено HTTPS для хостинга статического сайта](../../../security/standard/all.md#storage-https) | [cspm.data.storage-https](../../rules-reference/cspm.md#storage-https) ||
|| `CRYPT3` | [В Yandex Application Load Balancer используется HTTPS](../../../security/standard/all.md#alb-https) | [cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https) ||
|| `CRYPT4` | [В Yandex API Gateway используется HTTPS и собственный домен](../../../security/standard/all.md#api-gateway-https) | [cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https) ||
|| `CRYPT5` | [В Yandex Cloud CDN используется HTTPS и собственный SSL-сертификат](../../../security/standard/all.md#cdn-https) | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| `CRYPT8` | [Используется шифрование дисков и снимков виртуальных машин](../../../security/standard/all.md#managed-vm-kms) | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| `CRYPT9` | [Ключи Key Management Service хранятся в аппаратном модуле безопасности (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| `CRYPT10` | [Права на управление ключами в KMS выданы контролируемым пользователям](../../../security/standard/all.md#keys-controlled-users) | [cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access) ||
|| `CRYPT11` | [Для ключей KMS включена ротация](../../../security/standard/all.md#keys-rotation) | [cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation) ||
|| `CRYPT12` | [Для ключей KMS включена защита от удаления](../../../security/standard/all.md#keys-deletion-protection) | [cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection) ||
|| `CRYPT13` | [В организации используется Yandex Lockbox для безопасного хранения секретов](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| `CRYPT14` | [Для Serverless Containers и Cloud Functions используются секреты Lockbox](../../../security/standard/all.md#secrets-serverless-functions) | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| **Сбор, мониторинг и анализ аудитных логов** {align="center"} | > | > ||
|| `AUDIT1` | [Включен сервис Yandex Audit Trails на уровне организации](../../../security/standard/all.md#audit-trails) |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| `AUDIT8` | [Отслеживаются события уровня сервисов](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Защита приложений** {align="center"} | > | > ||
|| `APPSEC1` | [Используется Yandex SmartCaptcha](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| `APPSEC2` | [Docker-образы сканируются при загрузке в Yandex Container Registry](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| `APPSEC3` | [Выполняется периодическое сканирование Docker-образов, хранящихся в Container Registry](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| `APPSEC4` | [Контейнерные образы, используемые в продакшн-среде, имеют последнюю дату сканирования не позднее недели](../../../security/standard/all.md#last-scan-date) | [cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan) ||
|| `APPSEC9` | [Используется профиль безопасности Smart Web Security](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| `APPSEC10` | [Используется Web Application Firewall](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| `APPSEC11` | [Используется Advanced Rate Limiter](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **Безопасность Kubernetes** {align="center"} | > | > ||
|| `K8S3` | [Нет доступа к API Kubernetes](../../../security/standard/all.md#api-security) | [cspm.k8s.api-security](../../rules-reference/cspm.md#api-security) ||
|| `K8S4` | [В Managed Service for Kubernetes настроены аутентификация и управление доступом](../../../security/standard/all.md#kubernetes-auth) | [cspm.k8s.access](../../rules-reference/cspm.md#access) ||
|| `K8S5` | [В Yandex Managed Service for Kubernetes используется безопасная конфигурация](../../../security/standard/all.md#kubernetes-safe-config) | [cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration) ||
|| `K8S11` | [Используется политика безопасности Kubernetes](../../../security/standard/all.md#security-standards) | [cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm) ||
|#