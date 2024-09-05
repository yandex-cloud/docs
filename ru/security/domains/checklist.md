---
title: "Чеклист по безопасности {{ yandex-cloud }}"
description: "Из статьи вы узнаете, из чего состоит чеклист по безопасности на платформе {{ yandex-cloud }}."
---

# Чеклист по безопасности

{% include [kz-services](../../_includes/kz-services.md) %}

## Сетевая безопасность {#network-security}

* **Сегментация**: разделите ресурсы по группам и поместите их в разные каталоги, а если требуется наиболее строгая изоляция — в разные {{ vpc-short-name }}. Трафик внутри {{ vpc-short-name }} по умолчанию разрешен, между {{ vpc-short-name }} — нет (только через [виртуальную машину](../../glossary/vm.md) с двумя сетевыми интерфейсами в разных сетях, [VPN](../../glossary/vpn.md) или {{ interconnect-full-name }}). Посмотрите вебинар [Как работает сеть в {{ yandex-cloud }}](https://www.youtube.com/watch?v=g3cZ0o50qH0).
* **Ограничение сетевого доступа, группы безопасности**: ограничьте сетевой доступ между ресурсами с помощью [групп безопасности](../../vpc/operations/security-group-create.md).
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: настройка групп безопасности (dev/stage/prod) с помощью {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
* **NGFW из {{ marketplace-short-name }}**: если требуется продвинутая сетевая защита, используйте [NGFW]({{ link-cloud-marketplace }}?tab=software&categories=security&publishers=f2evobrhpbdrcue7s9l5%2Cf2e8r8u73qr5310ogjcn%2Cf2eddqeb0p9d7brb89l7) из {{ marketplace-full-name }} или разверните инфраструктуру самостоятельно, см. [руководство по настройке](../../tutorials/routing/high-accessible-dmz.md) высокодоступной отказоустойчивой сетевой инфраструктуры с выделенным DMZ сегментом и комплексной защитой на основе Next-Generation Firewall.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: установка в {{ yandex-cloud }} ВМ — межсетевого экрана (NGFW): Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
* **Безопасный доступ извне облачной инфраструктуры (VPN)**: если требуется удаленный доступ к ресурсам облака, настройте site-to-site VPN, см. [инструкцию по настройке с использованием демона strongSwan](../../tutorials/routing/ipsec/index.md), либо воспользуйтесь [{{ interconnect-name }}](../../interconnect/index.yaml) (также доступна услуга ГОСТ VPN).

  ![](../../_assets/overview/solution-library-icon.svg)[Решение: создание site-to-site VPN-соединения с {{ yandex-cloud }} с помощью {{ TF }}](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan)


* **Безопасный удаленный доступ администраторов (VPN)**: настройте VPN-соединение между удаленными устройствами и {{ yandex-cloud }}, используя решение из {{ marketplace-name }}, см. [руководство по настройке](../../tutorials/routing/openvpn.md) на базе [OpenVPN](/marketplace/products/yc/openvpn-access-server), или разверните инфраструктуру самостоятельно, см. [руководство по настройке](../../tutorials/routing/remote-wireguard-vpn.md) на базе WireGuard VPN.
* **Bastion host**: создайте бастионную ВМ для доступа в инфраструктуру по управляющим протоколам (например, [SSH](../../glossary/ssh-keygen.md), RDP).
* **Исходящий доступ (NAT)**: используйте [NAT-шлюз](../../vpc/concepts/gateways.md#nat-gateway) для безопасного исходящего доступа в интернет. Шлюз транслирует ваши IP-адреса в общий пул адресов. Если необходимо, чтобы выход в интернет был из вашего контролируемого пула IP-адресов, используйте [NAT-инстанс](../../tutorials/routing/nat-instance/index.md#create-nat-instance) (выделенную ВМ).
* **Защита от DDoS**: при назначении публичных IP-адресов на ресурсы облака используйте сервис [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) по кнопке (услуга L4-защиты от DDoS). Если необходима защита от DDoS на уровне L7, обратитесь к своему менеджеру.

## Аутентификация и управление доступом {#authentication}

* **Централизованное управление и федерации удостоверений**: создайте организацию в сервисе [{{ org-full-name }}](/services/organization) и настройте систему единого входа (Single Sign-On) в {{ yandex-cloud }} через свой сервер IdP, см. инструкции по настройке с помощью [AD FS](../../organization/tutorials/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), [Google Workspace](../../organization/tutorials/federations/integration-gworkspace.md).
* **Федеративные аккаунты**: используйте федеративные аккаунты вместо аккаунтов на Яндексе, где это возможно.
* **Принцип минимальных привилегий**: назначайте сервисные роли (например, `compute.images.user`) вместо примитивных (`viewer`, `editor`, `admin`), см. [список всех ролей](../../iam/roles-reference.md) и [примеры назначения ролей](../../iam/operations/roles/grant.md). Посмотрите вебинар [Управление доступами в облаке](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).
* **{{ TF }} {{ yandex-cloud }} {{ iam-full-name }} module**: организуйте группы доступов для пользователей облака.
* **Работа с сервисными аккаунтами**: применяйте механизм [назначения сервисного аккаунта ВМ](../../compute/operations/vm-connect/auth-inside-vm.md) и получения токена через сервис метаданных. Настройте локальный файрвол на ВМ, чтобы только необходимые процессы и пользователи системы имели доступ к сервису метаданных (IP-адрес: 169.254.169.254).<!-- tbd: добавить ссылку на решение -->
* **2FA**: для федерации удостоверений настройте 2FA на стороне вашего IdP, для аккаунта на Яндексе настройте 2FA согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).
* **Защита billing.accounts.owner**: после выполнения первоначальных операций не используйте учетную запись с этой ролью. Для управления платежным аккаунтом назначьте роль `admin`, `editor` или `viewer` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.
* **Защита organization-manager.organizations.owner**:

    {% list tabs %}

    - В федерации удостоверений

      Передайте роль `organization-manager.organizations.owner` федеративному аккаунту, затем удалите из организации паспортный аккаунт с этой ролью. Чтобы минимизировать риски возможных сбоев в работе федерации, выполните шаги, описанные в статье [Удаление паспортного аккаунта из организации](../operations/account-deletion.md).

    - Без федерации удостоверений

      Установите сложный пароль для аккаунта на Яндексе, с которым создана организация. Администраторам организации назначьте менее привилегированную роль `organization-manager.admin` и используйте аккаунт с ролью `organization-manager.organizations.owner` только в случае крайней необходимости.

    {% endlist %}

* **Ресурсная модель**: все критичные ресурсы, которые входят в область соответствия стандартам, поместите в отдельное облако. Группы ресурсов разделите по каталогам. Общие ресурсы (например, сеть и группы безопасности) поместите в отдельный каталог для разделяемых ресурсов.

## Шифрование данных и управление ключами/секретами {#data-encryption}

* **Шифрование в {{ objstorage-full-name }}**: включите шифрование бакетов (server-side encryption), см. [инструкцию](../../storage/operations/buckets/encrypt.md). Такое шифрование защищает данные бакета от опубликования в интернете.
* **Шифрование дисков ВМ (если требуется)**.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: Шифрование диска ВМ с помощью {{ kms-full-name }}](https://github.com/yandex-cloud-examples/yc-encrypt-vm-disk-with-kms)
* **Client-side encryption (если требуется)**: используйте шифрование данных с помощью ключей {{ kms-name }}, см. [обзор способов шифрования](../../kms/tutorials/encrypt/index.md).
* **Защита ключей {{ kms-name }}**: выдавайте только гранулярные доступы к отдельным ключам {{ kms-name }} — роли `kms.keys.encrypter`, `kms.keys.decrypter` или `kms.keys.encrypterDecrypter`; используйте [ротацию ключей](../../kms/concepts/version.md).
* **Управление секретами**: используйте сервисы управления секретами, такие как [{{ lockbox-name }}](../../lockbox/) или [HashiCorp Vault с поддержкой {{ kms-name }}](/marketplace/products/yc/vault-yckms) из {{ marketplace-name }}.<!-- или контейнер {{ registry }}/yc/vault -->

## Безопасная конфигурация {#secure-configuration}

* **Пароли по умолчанию**: следите за паролями по умолчанию в программном обеспечении внутри ВМ организационно и технически с помощью различных сканеров уязвимостей.
* **Стандарты и baseline**: конфигурируйте операционные системы и ПО в соответствии с baseline и стандартами (CIS, PCI DSS и др.), для автоматизации соответствия используйте, например, утилиту [OpenSCAP](https://www.open-scap.org/getting-started/).
* **Отключение серийной консоли**: не используйте серийную консоль, а если это необходимо, то [оценивайте риски](../../compute/operations/serial-console/index.md) и отключайте по окончании работы.
* **Безопасное использование {{ TF }}**: используйте `terraform remote state` на базе {{ objstorage-name }} с функцией блокировки в {{ ydb-full-name }}, см. [пример настройки](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Используйте параметр [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output), если требуется. Не передавайте приватные данные в конфигурацию, а если это необходимо, используйте сервисы [управления секретами](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code) или переменные среды. [Подробнее](../standard/encryption.md#secrets).
  ![](../../_assets/overview/solution-library-icon.svg)[Пример: сканирование tf-файлов с помощью Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
* **Контроль целостности на гостевых ОС**: применяйте бесплатные host-based решения, такие как [Wazuh](/marketplace/products/opennix/wazuh), Osquery, или платные решения из {{ marketplace-name }}.
* **Безопасная конфигурация {{ objstorage-name }}**: используйте шифрование, [политики доступа (bucket policy)](../../storage/concepts/policy.md) и ACL, [версионирование для защиты от удаления](../../storage/concepts/versioning.md), включите [встроенный аудит доступа](../../storage/operations/buckets/enable-logging.md) и настройте [CORS](../../glossary/cors.md) (при необходимости).
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: безопасная конфигурация {{ objstorage-name }} в {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)
* **Безопасная конфигурация {{ sf-full-name }}**: предоставляйте токен сервисного аккаунта через [нативный механизм](../../functions/operations/function-sa.md) с помощью назначенного сервисного аккаунта и метаданных. По возможности используйте [приватные функции](../../functions/operations/function/function-private.md).
* **Безопасная конфигурация {{ container-registry-full-name }}**: не рекомендуется использовать привилегированные контейнеры для запуска нагрузок. Используйте встроенный в сервис [сканер уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) в образах.
* **{{ certificate-manager-full-name }}**: используйте [{{ certificate-manager-name }}](../../certificate-manager/) для хранения, получения и обновления TLS-сертификатов от Let's Encrypt®, а также для загрузки собственных сертификатов. Сервис интегрирован с {{ api-gw-full-name }}, {{ alb-full-name }} и {{ objstorage-name }}.

## Защита от вредоносного кода {#malicious-code-protection}

* **Защита на уровне ОС**: устанавливайте на ВМ антивирусные решения из [{{ marketplace-name }}](/marketplace?categories=security).
* **Защита на уровне сети**: используйте NGFW/IDS/IPS, представленные в [{{ marketplace-name }}](/marketplace?categories=security) (некоторые из них имеют встроенные песочницы).
* **Защита на уровне образов контейнеров**: используйте сканер уязвимостей в образах, встроенный в сервис {{ container-registry-name }}.<!-- tbd: вставить ссылку на инструкцию, когда она появится -->

## Управление уязвимостями {#vulnerability-management}

* **Автоматизированное сканирование уязвимостей**: используйте бесплатные сетевые сканеры, например, nmap, OpenVAS, OWASP ZAP, или агенты на хостах, например, [Wazuh](/marketplace/products/opennix/wazuh), Tripwire.
* **Внешние сканирования безопасности**: проводите сканирования в соответствии с [правилами](../compliance/pentest.md).
* **Обновления ПО, ОС**: самостоятельно устанавливайте обновления, используйте автоматизированные инструменты обновлений.
* **Web Application Firewall**: установите WAF из [{{ marketplace-name }}](/marketplace?categories=security) или воспользуйтесь Managed WAF — для получения доступа обратитесь к своему менеджеру.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: PT Application Firewall на базе {{ yandex-cloud }}](https://github.com/yandex-cloud-examples/yc-webinar-pt-application-firewall-ha-operations)

## Сбор, мониторинг и анализ аудитных логов {#logs-analysis}

* **{{ at-full-name }}**: включите [{{ at-name }}](../../audit-trails/quickstart.md) для всех облаков и каталогов.
* **Сбор событий с уровня гостевых ОС и приложений**: собирайте события, например, с помощью бесплатных решений Osquery, [Wazuh](/marketplace/products/opennix/wazuh) и др.
* **Сбор Flow logs (если требуется)**: например, с помощью NGFW из {{ marketplace-name }} или бесплатного ПО (в планах встроенные возможности).
* **Экспорт событий {{ at-name }} в SIEM**.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: экспорт в ArcSight](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight)
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: экспорт в Splunk](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk)
  Возможен экспорт в любой SIEM с помощью s3fs, см. [инструкцию](../../storage/tools/s3fs.md).
* **Use cases**.
  ![](../../_assets/overview/solution-library-icon.svg)[Use cases и важные события безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
* **Реагирование на {{ at-name }} с {{ sf-name }}**:
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: уведомления и реагирование на события ИБ {{ at-name }} с помощью {{ cloud-logging-full-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response)
* **Регулярный аудит состояния**: используйте [{{ yandex-cloud }} CLI](../../cli/) для запросов к текущему состоянию облачной инфраструктуры либо партнерское решение [Cloud Advisor](/blog/posts/2021/03/cloud-advisor-review).

## Физическая безопасность {#physical-security}

* **Меры физической безопасности**: ознакомьтесь с [подробным описанием мер физической безопасности {{ yandex-cloud }}](../standarts.md#physic-sec).

## Резервное копирование {#backup}

* **Регулярные резервные копии**: настройте создание снимков дисков по расписанию с {{ sf-name }}, см. [руководство](/blog/posts/2020/01/snapshot-triggers).

## Управление бюджетами {#budget-management}

* **Уведомления для контроля расходов**: настройте уведомления на пороги бюджета в сервисе {{ billing-name }}, см. [инструкцию](../../billing/operations/budgets.md).

## Реагирование на инциденты {#incident-response}

* **Процедура реагирования**: постройте процесс реагирования на инциденты. Для получения дополнительных логов следуйте [процедуре запроса данных](../../support/request.md).
