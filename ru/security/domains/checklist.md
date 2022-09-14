# Чеклист по безопасности

## Сетевая безопасность {#network-security}

* **Сегментация**: разделите ресурсы по группам и поместите их в разные каталоги, а если требуется наиболее строгая изоляция — в разные {{ vpc-short-name }}. Трафик внутри {{ vpc-short-name }} по умолчанию разрешен, между {{ vpc-short-name }} — нет (только через виртуальную машину с двумя сетевыми интерфейсами в разных сетях{% if product == "cloud-il" %} или VPN){% endif %}{% if product == "yandex-cloud" %}, VPN или {{ interconnect-full-name }}). Посмотрите вебинар [Как работает сеть в {{ yandex-cloud }}](https://www.youtube.com/watch?v=g3cZ0o50qH0){% endif %}.
* **Ограничение сетевого доступа, группы безопасности**: ограничьте сетевой доступ между ресурсами с помощью [групп безопасности](../../vpc/operations/security-group-create.md).
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: настройка групп безопасности (dev/stage/prod) с помощью {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
* **NGFW из {{ marketplace-short-name }}**: если требуется продвинутая сетевая защита, используйте [NGFW](/marketplace?tab=software&search=NGFW) из {{ marketplace-full-name }}.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: установка в {{ yandex-cloud }} ВМ — межсетевого экрана (NGFW): Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
{% endif %}
* **Безопасный доступ извне облачной инфраструктуры (VPN)**: если требуется удаленный доступ к ресурсам облака, настройте site-to-site VPN, см. [инструкцию по настройке с использованием демона strongSwan](../../tutorials/routing/ipsec-vpn.md){% if product == "yandex-cloud" %}, либо воспользуйтесь [{{ interconnect-name }}](../../interconnect/) (также доступна услуга ГОСТ VPN){% endif %}.

{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: создание site-to-site VPN-соединения с {{ yandex-cloud }} с помощью {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn)

{% endif %}

* **Безопасный удаленный доступ администраторов (VPN)**: настройте VPN-соединение между удаленными устройствами и {{ yandex-cloud }}, используя решения из {{ marketplace-name }}, см. [руководство по настройке](../../tutorials/routing/openvpn.md) на базе [OpenVPN](/marketplace/products/yc/openvpn-access-server).
* **Bastion host**: создайте бастионную ВМ для доступа в инфраструктуру по управляющим протоколам (например, SSH, RDP).
* **Исходящий доступ (NAT)**: используйте [встроенный сервис NAT](../../vpc/operations/enable-nat.md) для безопасного исходящего доступа в интернет (egress NAT). Этот сервис делает трансляцию ваших IP-адресов в общий пул адресов. Если необходимо, чтобы выход в интернет был из вашего контролируемого пула IP-адресов, используйте [NAT-инстанс](../../tutorials/routing/nat-instance.md#create-nat-instance) (выделенную ВМ).
{% if product == "yandex-cloud" %}
* **Защита от DDoS**: при назначении публичных IP-адресов на ресурсы облака используйте сервис [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) по кнопке (услуга L4-защиты от DDoS). Если необходима защита от DDoS на уровне L7, обратитесь к своему менеджеру.
{% endif %}

## Аутентификация и управление доступом {#authentication}

* **Централизованное управление и федерации удостоверений**: создайте организацию в сервисе [{{ org-full-name }}](/services/organization) и настройте систему единого входа (Single Sign-On) в {{ yandex-cloud }} через свой сервер IdP, см. инструкции по настройке с помощью [AD FS](../../organization/operations/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), [Google Workspace](../../organization/operations/federations/integration-gworkspace.md).
* **Федеративные аккаунты**: используйте федеративные аккаунты вместо аккаунтов {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}, где это возможно.
* **Принцип минимальных привилегий**: назначайте сервисные роли (например, `compute.images.user`) вместо примитивных (`viewer`, `editor`, `admin`), см. [список всех ролей](../../iam/concepts/access-control/roles.md) и [примеры назначения ролей](../../iam/operations/roles/grant.md).{% if product == "yandex-cloud" %} Посмотрите вебинар [Управление доступами в облаке](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).{% endif %}
* **{{ TF }} {{ yandex-cloud }} {{ iam-full-name }} module**: организуйте группы доступов для пользователей облака.
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: {{ iam-name }} в {{ TF }} для {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auth_and_access/iam#identity-and-access-management-iam-terraform-module-for-yandexcloud)
{% endif %}
* **Работа с сервисными аккаунтами**: применяйте механизм [назначения сервисного аккаунта ВМ](../../compute/operations/vm-connect/auth-inside-vm.md) и получения токена через сервис метаданных. Настройте локальный файрвол на ВМ, чтобы только необходимые процессы и пользователи системы имели доступ к сервису метаданных (IP-адрес: 169.254.169.254).<!-- tbd: добавить ссылку на решение -->
* **2FA**: для федерации удостоверений настройте 2FA на стороне вашего IdP,{% if product == "yandex-cloud" %} для аккаунта на Яндексе настройте 2FA согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html){% endif %}{% if product == "cloud-il" %}для аккаунта Google настройте 2FA согласно [инструкции](https://support.google.com/accounts/answer/185839?ref_topic=2954345l){% endif %}.
* **Защита billing.accounts.owner**: после выполнения первоначальных операций не используйте учетную запись с этой ролью. Для управления платежным аккаунтом назначьте роль `admin`, `editor` или `viewer` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.
* **Защита resource-manager.clouds.owner**: назначьте роль `resource-manager.clouds.owner` сотрудникам организации с федеративным аккаунтом. Аккаунту {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}, с которым создано облако, назначьте сложный пароль и используйте этот аккаунт только в случае крайней необходимости. Назначьте администраторам менее привилегированные доступы и используйте `resource-manager.clouds.owner` в случае крайней необходимости.
* **Ресурсная модель**: все критичные ресурсы, которые входят в область соответствия стандартам, поместите в отдельное облако. Группы ресурсов разделите по каталогам. Общие ресурсы (например, сеть и группы безопасности) поместите в отдельный каталог для разделяемых ресурсов.

## Шифрование данных и управление ключами/секретами {#data-encryption}

{% if product == "yandex-cloud" %}
* **Шифрование в {{ objstorage-full-name }}**: включите шифрование бакетов (server-side encryption), см. [инструкцию](../../storage/operations/buckets/encrypt.md). Такое шифрование защищает данные бакета от опубликования в интернете.
* **Шифрование дисков ВМ (если требуется)**.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: Шифрование диска ВМ с помощью {{ kms-full-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)
{% endif %}
* **Client-side encryption (если требуется)**: используйте шифрование данных с помощью ключей {{ kms-name }}, см. [обзор способов шифрования](../../kms/tutorials/encrypt/index.md).
* **Защита ключей {{ kms-name }}**: выдавайте только гранулярные доступы к отдельным ключам {{ kms-name }} — роль `kms.keys.encrypterDecrypter`; используйте [ротацию ключей](../../kms/concepts/version.md).
* **Управление секретами**: используйте сервисы управления секретами, такие как [{{ lockbox-name }}](../../lockbox/){% if product == "yandex-cloud" %} или [HashiCorp Vault c поддержкой {{ kms-name }}](/marketplace/products/yc/vault-yckms) из {{ marketplace-name }}{% endif %}.<!-- или контейнер cr.yandex/yc/vault -->

## Безопасная конфигурация {#secure-configuration}

* **Пароли по умолчанию**: следите за паролями по умолчанию в программном обеспечении внутри ВМ организационно и технически с помощью различных сканеров уязвимостей.
* **Стандарты и baseline**: конфигурируйте операционные системы и ПО в соответствии с baseline и стандартами (CIS, PCI DSS и др.), для автоматизации соответствия используйте, например, утилиту [OpenSCAP](https://www.open-scap.org/getting-started/).
* **Отключение серийной консоли**: не используйте серийную консоль, а если это необходимо, то [оценивайте риски](../../compute/operations/serial-console/index.md) и отключайте по окончании работы.
* **Безопасное использование {{ TF }}**: {% if product == "yandex-cloud" %}используйте `terraform remote state` на базе {{ objstorage-name }} с функцией блокировки в {{ ydb-full-name }}, см. [пример настройки](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Используйте{% endif %}{% if product == "cloud-il" %}используйте{% endif %} параметр [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output), если требуется. Не передавайте приватные данные в конфигурацию, а если это необходимо, используйте сервисы [управления секретами](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code) или переменные среды. [Подробнее](./secure-config.md#terraform).
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Пример: сканирование tf-файлов с помощью Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
{% endif %}
* **Контроль целостности на гостевых ОС**: применяйте бесплатные host-based решения, такие как Wazuh, Osquery{% if product == "yandex-cloud" %}, или платные решения из {{ marketplace-name }}, например [Kaspersky Security](/marketplace?search=Kaspersky+Security){% endif %}.
{% if product == "yandex-cloud" %}
* **Безопасная конфигурация {{ objstorage-name }}**: используйте шифрование, [политики доступа (bucket policy)](../../storage/concepts/policy.md) и ACL, [версионирование для защиты от удаления](../../storage/concepts/versioning.md), включите [встроенный аудит доступа](../../storage/operations/buckets/enable-logging.md) и настройте CORS (при необходимости).
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: безопасная конфигурация {{ objstorage-name }} в {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)
* **Безопасная конфигурация {{ sf-full-name }}**: предоставляйте токен сервисного аккаунта через [нативный механизм](../../functions/operations/function-sa.md) с помощью назначенного сервисного аккаунта и метаданных. По возможности используйте [приватные функции](../../functions/operations/function-public.md).
{% endif %}
* **Безопасная конфигурация {{ container-registry-full-name }}**: не рекомендуется использовать привилегированные контейнеры для запуска нагрузок.{% if product == "yandex-cloud" %} Используйте встроенный в сервис [сканер уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) в образах.{% endif %}
* **{{ certificate-manager-full-name }}**: используйте [{{ certificate-manager-name }}](../../certificate-manager/) для хранения, получения и обновления TLS-сертификатов от Let's Encrypt®, а также для загрузки собственных сертификатов. Сервис интегрирован с {% if product == "yandex-cloud" %}{{ api-gw-full-name }}, {% endif %}{{ alb-full-name }} и {{ objstorage-name }}.

## Защита от вредоносного кода {#malicious-code-protection}

* **Защита на уровне ОС**: устанавливайте на ВМ антивирусные решения{% if product == "yandex-cloud" %} из [{{ marketplace-name }}](/marketplace?categories=security){% endif %}.
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: развертывание Kaspersky Antivirus в {{ yandex-cloud }} ({{ compute-full-name }}, {{ coi }})](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/malware-defense/kaspersy-install-in-yc)
{% endif %}
* **Защита на уровне сети**: используйте NGFW/IDS/IPS{% if product == "yandex-cloud" %}, представленные в [{{ marketplace-name }}](/marketplace?categories=security) (некоторые из них имеют встроенные песочницы){% endif %}.
* **Защита на уровне образов контейнеров**: используйте сканер уязвимостей в образах, встроенный в сервис {{ container-registry-name }}.<!-- tbd: вставить ссылку на инструкцию, когда она появится -->

## Управление уязвимостями {#vulnerability-management}

* **Автоматизированное сканирование уязвимостей**: используйте бесплатные сетевые сканеры, например, nmap, OpenVAS, OWASP ZAP, или агенты на хостах, например, Wazuh, Tripwire.
* **Внешние сканирования безопасности**: проводите сканирования в соответствии с [правилами](../compliance/pentest.md).
* **Обновления ПО, ОС**: самостоятельно устанавливайте обновления, используйте автоматизированные инструменты обновлений.
* **Web Application Firewall**: {% if product == "yandex-cloud" %}установите WAF из [{{ marketplace-name }}](/marketplace?categories=security){% endif %}{% if product == "cloud-il" %}используйте собственную инсталяцию WAF{% endif %}{% if product == "yandex-cloud" %} или воспользуйтесь Managed WAF — для получения доступа обратитесь к своему менеджеру{% endif %}.
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: PT Application Firewall на базе {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/unmng-waf-ptaf-cluster)
  ![](../../_assets/overview/solution-library-icon.svg)[Пример: установка уязвимого веб-приложения (DVWA) в {{ yandex-cloud }} с помощью {{ TF }} для тестирования Managed WAF](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/vulnerable-web-app-waf-test)
{% endif %}

## Сбор, мониторинг и анализ аудитных логов {#logs-analysis}

* **{{ at-full-name }}**: включите [{{ at-name }}](../../audit-trails/quickstart.md) для всех облаков и каталогов.
* **Сбор событий с уровня гостевых ОС и приложений**: собирайте события, например,{% if product == "yandex-cloud" %} с помощью [{{ mes-full-name }}](../../managed-elasticsearch/) или{% endif %} с помощью бесплатных решений Osquery, Wazuh и др.
* **Сбор Flow logs (если требуется)**: например,{% if product == "yandex-cloud" %} с помощью NGFW из {{ marketplace-name }} или бесплатного ПО (в планах встроенные возможности){% endif %}{% if product == "cloud-il" %} с помощью межсетевого экрана{% endif %}.
* **Экспорт событий {{ at-name }} в SIEM**{% if product == "cloud-il" %}: для настройки экспорта в любые SIEM подходят утилиты [GeeseFS и s3fs](./checklist.md#export-at).{% endif %}{% if product == "yandex-cloud" %}.{% endif %}
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: экспорт в {{ mes-name }} (ELK)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: экспорт в ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: экспорт в Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)
  Возможен экспорт в любой SIEM с помощью s3fs, см. [инструкцию](../../storage/tools/s3fs.md).
* **Use cases**.
  ![](../../_assets/overview/solution-library-icon.svg)[Use cases и важные события безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
* **Реагирование на {{ at-name }} с {{ sf-name }}**:
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: уведомления и реагирование на события ИБ {{ at-name }} с помощью {{ cloud-logging-full-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)
{% endif %}
* **Регулярный аудит состояния**: используйте [{{ yandex-cloud }} CLI](../../cli/) для запросов к текущему состоянию облачной инфраструктуры{% if product == "yandex-cloud" %} либо партнерское решение [Cloud Advisor](https://cloud.yandex.ru/blog/posts/2021/03/cloud-advisor-review){% endif %}.

## Физическая безопасность {#physical-security}

* **Меры физической безопасности**: ознакомьтесь с [подробным описанием мер физической безопасности {{ yandex-cloud }}](../standarts.md#physic-sec).

## Резервное копирование {#backup}

{% if product == "yandex-cloud" %}
* **Регулярные резервные копии**: настройте создание снимков дисков по расписанию с {{ sf-name }}, см. [руководство](https://cloud.yandex.ru/blog/posts/2020/01/snapshot-triggers).
{% endif %}
{% if product == "cloud-il" %}
* **Регулярные резервные копии**: создавайте снимки дисков с установленной периодичностью.
{% endif %}

{% if product == "yandex-cloud" %}
## Управление бюджетами {#budget-management}

* **Уведомления для контроля расходов**: настройте уведомления на пороги бюджета в биллинге, см. [инструкцию](../../billing/operations/budgets.md).

{% endif %}
## Реагирование на инциденты {#incident-response}

* **Процедура реагирования**: постройте процесс реагирования на инциденты. Для получения дополнительных логов следуйте [процедуре запроса данных](../../support/request.md).

## Безопасность {{ managed-k8s-full-name }} {#kubernetes-security}

### Шифрование данных и управление ключами/секретами {#kubernetes-data-encryption}

* **Server-side шифрование**: включите шифрование секретов в etcd, см. [руководство](../../kms/tutorials/k8s.md). Делайте это всегда, вне зависимости от того, будете ли вы использовать сервисы управления секретами.
* **Управление секретами**: используйте [{{ lockbox-name }}](../../lockbox/){% if product == "yandex-cloud" %} или [HashiCorp Vault c поддержкой {{ kms-name }}](/marketplace/products/yc/vault-yckms) из {{ marketplace-name }}{% endif %}.<!-- или контейнер `cr.yandex/yc/vault` -->
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: управление секретами c SecretManager ({{ lockbox-name }}, Vault)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/encrypt_and_keys/secret-management)
{% endif %}

### Сетевая безопасность {#kubernetes-network-security}

* **Группы безопасности**: настройте группы безопасности для {{ k8s }}, см. [инструкцию](../../managed-kubernetes/operations/connect/security-groups.md). Не рекомендуется выдавать публичный доступ и публичные адреса компонентам {{ k8s }}.
* **Ingress-контроллер**: для доступа извне к сервисам {{ k8s }} используйте Ingress-контроллер (HTTPS) с типом LoadBalancer (внешний или внутренний): [{{ alb-name }} Ingress-контроллер](../../managed-kubernetes/tutorials/alb-ingress-controller.md) (рекомендуется) или другой, например [NGINX Ingress-контроллер](../../managed-kubernetes/tutorials/ingress-cert-manager.md).
{% if product == "yandex-cloud" %}
* **Защита от DDoS**: создайте IP-адрес с защитой от DDoS и назначьте его сервису либо Ingress-контроллеру.
{% endif %}
* **Сетевые политики (network policy)**: ограничьте доступ на уровне {{ k8s }} с помощью [сетевых политик Calico](../../managed-kubernetes/operations/calico.md) либо продвинутых [сетевых политик Cilium](../../managed-kubernetes/operations/cilium.md).
* **Доступ только из ограниченного пула адресов (если требуется)**: для {{ alb-name }} Ingress-контроллера назначьте группы безопасности, для других Ingress-контроллеров используйте сетевые политики.

### Аутентификация и управление доступом {#kubernetes-authentication}

* **Управление доступом**: настройте роли для доступа к {{ k8s }}, см. [инструкцию](../../managed-kubernetes/security/index.md#sa-annotation). Контролируйте права доступа сервисного аккаунта группы узлов (как правило, достаточно роли `container-registry.images.puller`).
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: настройка ролевых моделей и политик в {{ managed-k8s-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)
{% endif %}

### Безопасная конфигурация {#kubernetes-secure-configuration}

* **Конфигурация группы узлов в соответствии с baseline и стандартами**: настройте группы узлов в соответствии со стандартами и baseline: NIST, CIS и др. Возможно использовать автоматизированные инструменты: kube-bench, kubescape.
* **Runtime security и policy engine**: используйте решения для runtime security, например Falco, а также решения для policy engine, например OPA Gatekeeper, Kyverno.
{% if product == "yandex-cloud" %}
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: установка Falco и policy engine с отправкой алертов в {{ mes-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
{% endif %}
* **Обновления безопасности**: выберите подходящий [канал обновления](../../managed-kubernetes/concepts/release-channels-and-updates.md) и настройте автоматическое применение обновлений либо применяйте их вручную сразу после публикации в выбранном канале. Также выполняйте своевременное обновление собственного ПО на группах узлов.
* **Распределение подов на разные группы узлов**: настройте node taints and tolerations + node affinity (по нагрузке и степени приватности).

### Сбор, мониторинг и анализ аудитных логов {#kubernetes-logs-analysis}

{% if product == "yandex-cloud" %}
* **Сбор и анализ аудитных логов {{ k8s }} и инструментов защиты**.
  ![](../../_assets/overview/solution-library-icon.svg)[Решение: анализ логов безопасности {{ k8s }} в {{ mes-name }}: аудитные логи, policy engine, Falco](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
{% endif %}
* **Сбор и анализ аудитных логов workloads и группы узлов**: например, с помощью открытых инструментов Fluent Bit, Beats и др.

{% if audience == "external" %}

* **Мониторинг аномальной нагрузки**: используйте [{{ monitoring-full-name }}](../../monitoring/).

{% endif %}

### Резервное копирование {#kubernetes-backup}

* **Резервное копирование**: настройте резервное копирование кластера {{ k8s }} в {{ objstorage-name }}, см. [руководство](../../managed-kubernetes/tutorials/backup.md). Следуйте рекомендациям раздела [Безопасная конфигурация {{ objstorage-name }}](secure-config.md#object-storage).