# Чеклист по безопасности

## Сетевая безопасность

- **Сегментация**: разделите ресурсы по группам и поместите их в разные каталоги, а если требуется наиболее строгая изоляция — в разные VPC. Трафик внутри VPC по умолчанию разрешен, между VPC нет (только через ВМ с двумя сетевыми интерфейсами в разных сетях, VPN или Cloud Interconnect). Посмотрите вебинар [Как работает сеть в Облаке](https://www.youtube.com/watch?v=g3cZ0o50qH0).
- **Ограничение сетевого доступа, группы безопасности**: ограничьте сетевой доступ между ресурсами с помощью [групп безопасности](../../../vpc/operations/security-group-create.md).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: настройка групп безопасности (dev/stage/prod) с помощью Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
- **NGFW из Marketplace**: если требуется продвинутая сетевая защита, используйте NGFW из [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=network).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: установка в Yandex.Cloud ВМ — межсетевого экрана (NGFW): Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
- **Безопасный доступ извне облачной инфраструктуры (VPN)**: если требуется удаленный доступ к ресурсам облака, то настройте site-to-site VPN, см. [инструкцию по настройке с использованием демона strongSwan](../../../solutions/routing/ipsec-vpn.md), либо воспользуйтесь услугой [Cloud Interconnect](../../../interconnect/index.yaml) (также доступна услуга ГОСТ VPN).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: создание site-to-site VPN-соединения с Yandex.Cloud с помощью Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn)
- **Безопасный удаленный доступ администраторов (VPN)**: настройте VPN-соединение между удаленными устройствами и Yandex.Cloud, используя решения из [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=network), см. [инструкцию по настройке на базе OpenVPN](../../../solutions/routing/openvpn.md).
- **Bastion host**: создайте бастионную виртуальную машину для доступа в инфраструктуру по управляющим протоколам (например, SSH, RDP).
- **Исходящий доступ (NAT)**: используйте [встроенный сервис NAT](../../../vpc/operations/enable-nat.md) для безопасного исходящего доступа в интернет (egress NAT). Этот сервис делает трансляцию ваших адресов в общий пул адресов. Если необходимо, чтобы выход в интернет был из вашего контролируемого пула адресов, используйте [NAT-инстанс](../../../solutions/routing/nat-instance.md#create-nat-instance) (выделенную ВМ).
- **Защита от DDoS**: при назначении публичных IP-адресов на ресурсы облака используйте встроенный компонент [DDoS Protection](../../../vpc/ddos-protection/index.md) по кнопке (услуга L4/L4-защиты от DDoS). Если необходима защита от DDoS на уровне L7, обратитесь к своему менеджеру.

## Аутентификация и управление доступом

- **Централизованное управление и федерации удостоверений**: создайте организацию в сервисе [Yandex Cloud Organization](https://cloud.yandex.ru/services/organization) и настройте систему единого входа (Single Sign-On) в Yandex.Cloud через свой сервер IdP, см. инструкции по настройке с помощью [AD FS](../../../organization/operations/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), [Google Workspace](../../../organization/operations/federations/integration-gworkspace.md).
- **Федеративные аккаунты**: используйте федеративные аккаунты вместо аккаунтов на Яндексе, где это возможно.
- **Принцип минимальных привилегий**: назначайте сервисные роли (например, `compute.images.user`) вместо примитивных (`viewer`, `editor`, `admin`), см. [список всех ролей](../../../iam/concepts/access-control/roles.md) и [примеры назначения ролей](../../../iam/operations/roles/grant.md). Посмотрите вебинар [Управление доступами в облаке](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).
- **Terraform Yandex Cloud IAM module**: организуйте группы доступов для пользователей облака.
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: IAM в Terraform для Yandex.Cloud](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auth_and_access/iam#identity-and-access-management-iam-terraform-module-for-yandexcloud)
- **Работа с сервисными аккаунтами**: применяйте механизм [назначения сервисного аккаунта виртуальной машине](../../../compute/operations/vm-connect/auth-inside-vm.md) и получения токена через сервис метаданных. Настройте локальный файрвол на ВМ, чтобы только необходимые процессы и пользователи системы имели доступ к сервису метаданных (IP-адрес: 169.254.169.254).<!-- tbd: добавить ссылку на решение -->
- **2FA**: для федерации удостоверений настройте 2FA на стороне вашего IdP, для аккаунта на Яндексе настройте 2FA согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).
- **Защита billing.accounts.owner**: после выполнения первоначальных операций не используйте учетную запись с этой ролью. Для управления платежным аккаунтом назначьте роль `admin`, `editor` или `viewer` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.
- **Защита resource-manager.clouds.owner**: назначьте роль `resource-manager.clouds.owner` сотрудникам организации с федеративным аккаунтом. Аккаунту на Яндексе, с которым создано облако, назначьте сложный пароль и используйте этот аккаунт только в случае крайней необходимости. Назначьте администраторам менее привилегированные доступы и используйте `resource-manager.clouds.owner` в случае крайней необходимости.
- **Ресурсная модель**: все критичные ресурсы, которые входят в область соответствия стандартам, поместите в отдельное облако. Группы ресурсов разделите по каталогам. Общие ресурсы (например, сеть и группы безопасности) поместите в отдельный каталог для разделяемых ресурсов.

## Шифрование данных и управление ключами/секретами

- **Шифрование в Object Storage**: включите шифрование бакетов (server-side encryption), см. [инструкцию](../../../storage/operations/buckets/encrypt.md). Такое шифрование защищает данные бакета от опубликования в интернете.
- **Шифрование дисков ВМ (если требуется)**.
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: Шифрование диска ВМ с помощью KMS](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)
- **Сlient-side encryption (если требуется)**: используйте шифрование данных с помощью ключей KMS, см. [обзор способов шифрования](../../../kms/solutions/encrypt/index.md).
- **Защита ключей KMS**: выдавайте только гранулярные доступы к отдельным ключам KMS — роль `kms.keys.encrypterDecrypter`; используйте [ротацию ключей](../../../kms/concepts/version.md).
- **Управление секретами**: используйте сервисы управления секретами, такие как [Yandex Lockbox](../../../lockbox/index.yaml) или [HashiCorp Vault c поддержкой KMS](https://cloud.yandex.ru/marketplace/products/f2eokige6vtlf94uvgs2) из Yandex Cloud Marketplace. <!-- или контейнер cr.yandex/yc/vault -->

## Безопасная конфигурация

- **Пароли по умолчанию**: следите за паролями по умолчанию в ПО внутри ВМ организационно и технически с помощью различных сканеров уязвимостей.
- **Стандарты и baseline**: конфигурируйте ОС и ПО в соответствии с baseline и стандартами (CIS, PCI DSS и др.), для автоматизации соответствия используйте, например, утилиту [OpenSCAP](https://www.open-scap.org/getting-started/).
- **Отключение серийной консоли**: не используйте серийную консоль, а если это необходимо, то [оценивайте риски](../../../compute/operations/serial-console/index.md) и отключайте по окончании работы.
- **Безопасное использование Terraform**: используйте `terraform remote state` на базе Yandex Object Storage с функцией блокировки в Yandex Database, см. [пример настройки](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Используйте параметр [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output), если требуется. Не передавайте приватные данные в конфигурацию, а если это необходимо, используйте сервисы управления секретами или переменные среды. [Подробнее](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code)
- **Контроль целостности на гостевых ОС**: применяйте бесплатные host-based решения, такие как Wazuh, Osquery, или платные решения из Yandex Cloud Marketplace, например Kaspersky Security.
- **Безопасная конфигурация Object Storage**: используйте шифрование, [политики доступа (bucket policy)](../../../storage/concepts/policy.md) и ACL, [версионирование для защиты от удаления](../../../storage/concepts/versioning.md), включите [встроенный аудит доступа](../../../storage/operations/buckets/enable-logging.md) и настройте CORS (при необходимости).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: безопасная конфигурация Yandex Object Storage в Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)
- **Безопасная конфигурация Cloud Functions**: предоставляйте токен сервисного аккаунта через [нативный механизм](../../../functions/operations/function-sa.md) с помощью назначенного сервисного аккаунта и метаданных. По возможности используйте [приватные функции](../../../functions/operations/function-public.md).
- **Безопасная конфигурация Yandex Container Registry**: не рекомендуется использовать привилегированные контейнеры для запуска нагрузок. Используйте встроенный в сервис [сканер уязвимостей](../../../container-registry/solutions/image-auto-scan.md) в образах.
- **Yandex Certificate Manager**: используйте [Yandex Certificate Manager](../../../certificate-manager/index.yaml) для хранения, получения и обновления TLS-сертификатов от Let's Encrypt®, а также для загрузки собственных сертификатов. Сервис интегрирован с Yandex Object Storage, Yandex API Gateway, Application Load Balancer.

## Защита от вредоносного кода

- **Защита на уровне ОС**: устанавливайте на ВМ антивирусные решения из [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=security).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: развертывание Kaspersky Antivirus в Yandex.Cloud (Compute Instance, COI)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/malware-defense/kaspersy-install-in-yc)
- **Защита на уровне сети**: используйте NGFW/IDS/IPS, представленные в [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=security) (некоторые из них имеют встроенные песочницы).
- **Защита на уровне образов контейнеров**: используйте сканер уязвимостей в образах, встроенный в сервис Yandex Container Registry.<!-- tbd: вставить ссылку на инструкцию, когда она появится -->

## Управление уязвимостями

- **Автоматизированное сканирование уязвимостей**: используйте бесплатные сетевые сканеры, например nmap, OpenVAS, OWASP ZAP, или агенты на хостах, например Wazuh, Tripwire.
- **Внешние сканирования безопасности**: проводите сканирования в соответствии с [правилами](../../../overview/compliance/pentest.md).
- **Обновления ПО, ОС**: самостоятельно устанавливайте обновления, используйте автоматизированные инструменты обновлений.
- **Web Application Firewall**: установите WAF из [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=security) или воспользуйтесь Managed WAF — для получения доступа обратитесь к своему менеджеру.
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: PT Application Firewall на базе Yandex.Cloud](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/unmng-waf-ptaf-cluster)
  ![](../../../_assets/overview/solution-library-icon.png)[Пример: установка уязвимого веб-приложения (DVWA) в Yandex.Cloud с помощью Terraform для тестирования Managed WAF](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/vulnerable-web-app-waf-test)

## Сбор, мониторинг и анализ логов аудита

- **Audit trails**: включите [Yandex Audit Trails](../../../audit-trails/quickstart.md) для всех облаков и каталогов.
- **Сбор событий с уровня гостевых ОС и приложений**: собирайте события, например, с помощью [Yandex Managed Service for Elasticsearch](../../../managed-elasticsearch/index.yaml) или с помощью бесплатных решений Osquery, Wazuh и др.
- **Сбор Flow logs (если требуется)**: например, с помощью NGFW из Yandex Cloud Marketplace или бесплатного ПО (в планах встроенные возможности).
- **Экспорт событий Audit Trails в SIEM**.
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: экспорт в Yandex Managed Service for Elasticsearch (ELK)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: экспорт в ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: экспорт в Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)
  Возможен экспорт в любой SIEM с помощью s3fs, см. [инструкцию](../../../storage/tools/s3fs.md).
- **Use cases**.
  ![](../../../_assets/overview/solution-library-icon.png)[Use cases и важные события безопасности в логах аудита](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
- **Реагирование на Audit Trails с Cloud Functions**:
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: уведомления и реагирование на события ИБ Audit Trails с помощью Cloud Logging/Cloud Functions + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)
- **Регулярный аудит состояния**: используйте [CLI](../../../cli/index.yaml) для запросов к текущему состоянию облачной инфраструктуры либо партнерское решение [Cloud Advisor](https://cloud.yandex.ru/blog/posts/2021/03/cloud-advisor-review).

## Физическая безопасность

- **Меры физической безопасности**: ознакомьтесь с [подробным описанием мер физической безопасности Yandex.Cloud](../../../overview/security/standarts.md#physic-sec).

## Резервное копирование

- **Регулярные резервные копии**: настройте создание снимков дисков по расписанию с Yandex Cloud Functions, см. [туториал](https://cloud.yandex.ru/blog/posts/2020/01/snapshot-triggers).

## Управление бюджетами

- **Уведомления для контроля расходов**: настройте уведомления на пороги бюджета в биллинге, см. [инструкцию](../../../billing/operations/budgets.md).

## Реагирование на инциденты

- **Процедура реагирования**: постройте процесс реагирования на инциденты. Для получения дополнительных логов следуйте [процедуре запроса данных](../../../support/request.md).

## Безопасность Managed Service for Kubernetes

### Шифрование данных и управление ключами/секретами

- **Server-side шифрование**: включите шифрование секретов в etcd, см. [инструкцию](../../../kms/solutions/k8s.md). Делайте это всегда, вне зависимости от того, будете ли вы использовать сервисы управления секретами.
- **Управление секретами**: используйте [Yandex Lockbox](../../../lockbox/index.yaml) или [HashiCorp Vault c поддержкой KMS](https://cloud.yandex.ru/marketplace/products/f2eokige6vtlf94uvgs2) из Yandex Cloud Marketplace. <!-- или контейнер `cr.yandex/yc/vault` -->
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: управление секретами c SecretManager ({{ lockbox-name }}, Vault)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/encrypt_and_keys/secret-management)

### Сетевая безопасность

- **Группы безопасности**: настройте группы безопасности для Kubernetes, см. [инструкцию](../../../managed-kubernetes/operations/security-groups.md). Не рекомендуется выдавать публичный доступ и публичные адреса компонентам Kubernetes.
- **Ingress-контроллер**: для доступа извне к сервисам Kubernetes используйте Ingress-контроллер (HTTPS) с типом LoadBalancer (внешний или внутренний): [Application Load Balancer Ingress-контроллер](../../../managed-kubernetes/solutions/alb-ingress-controller.md) (рекомендуется) или другой, например [NGINX Ingress Controller](../../../managed-kubernetes/solutions/ingress-cert-manager.md).
- **Защита от DDoS**: создайте IP-адрес с защитой от DDoS и назначьте его сервису либо Ingress-контроллеру.
- **Сетевые политики (network policy)**: ограничьте доступ на уровне Kubernetes с помощью [сетевых политик Calico](../../../managed-kubernetes/operations/calico.md) либо продвинутых [сетевых политик Cilium](../../../managed-kubernetes/operations/cilium.md).
- **Доступ только из ограниченного пула адресов (если требуется)**: для Application Load Balancer Ingress-контроллера назначьте группы безопасности, для других Ingress-контроллеров используйте сетевые политики.

### Аутентификация и управление доступом

- **Управление доступом**: настройте роли для доступа к Kubernetes, см. [инструкцию](../../../managed-kubernetes/security/index.md#sa-annotation). Контролируйте права доступа сервисного аккаунта группы узлов (как правило, достаточно роли `container-registry.images.puller`).
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: настройка ролевых моделей и политик в Managed Service for Kubernetes](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)

### Безопасная конфигурация

- **Конфигурация группы узлов в соответствии с baseline и стандартами**: настройте группы узлов в соответствии со стандартами и baseline: NIST, CIS и др. Возможно использовать автоматизированные инструменты: kube-bench, kubescape.
- **Runtime security и policy engine**: используйте решения для runtime security, например Falco, а также решения для policy engine, например OPA Gatekeeper, Kyverno. 
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: установка Falco и policy engine с отправкой алертов в Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
- **Обновления безопасности**: выберите подходящий [канал обновления](../../../managed-kubernetes/concepts/release-channels-and-updates.md) и настройте автоматическое применение обновлений либо применяйте их вручную сразу после публикации в выбранном канале. Также выполняйте своевременное обновление собственного ПО на группах узлов.
- **Распределение подов на разные группы узлов**: настройте node taints and tolerations + node affinity (по нагрузке и степени приватности).

### Сбор, мониторинг и анализ логов аудита

- **Сбор и анализ логов аудита Kubernetes и инструментов защиты**.
  ![](../../../_assets/overview/solution-library-icon.png)[Решение: анализ логов безопасности Kubernetes в Managed Service for Elasticsearch: логи аудита, policy engine, Falco](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
- **Сбор и анализ логов аудита workloads и группы узлов**: например, с помощью открытых инструментов Fluentbit, Beats и др.
- **Мониторинг аномальной нагрузки**: используйте [Yandex Monitoring](../../../monitoring/index.yaml).

### Резервное копирование

- **Резервное копирование**: настройте резервное копирование кластера Kubernetes в Yandex Object Storage, см. [инструкцию](../../../managed-kubernetes/solutions/backup.md). Следуйте рекомендациям раздела [Безопасная конфигурация Yandex Object Storage](secure-config.md#object-storage).
