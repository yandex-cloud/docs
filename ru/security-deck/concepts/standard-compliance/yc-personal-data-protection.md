---
title: Стандарт по защите персональных данных пользователей {{ yandex-cloud }}
description: В этом разделе приведен набор правил помогает автоматизировать контроль соответствия требованиям законодательства по требованиям федерального закона от 27.07.2006 № 152-ФЗ в ресурсах {{ yandex-cloud }}.
---

# Стандарт по защите персональных данных пользователей {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Данный набор правил помогает автоматизировать контроль соответствия требованиям законодательства по требованиям федерального закона от 27.07.2006 № 152-ФЗ в ресурсах {{ yandex-cloud }}.

Эти правила помогают защитить персональные данные в соответствии с Требованиями ФСТЭК (Приказ 21):

#|
|| Идентификатор требования | Требование стандарта безопасности | Идентификаторы проверки в [модуле {{ cspm-name }}](../cspm.md) ||
|| **Идентификация и аутентификация субъектов доступа и объектов доступа** (ИАФ) {.cell-align-center} | > | > ||
|| ИАФ.1 | Идентификация и аутентификация пользователей, являющихся работниками оператора | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings}) ||
|| ИАФ.4 | Управление средствами аутентификации, в том числе хранение, выдача, инициализация, блокирование средств аутентификации и принятие мер в случае утраты и (или) компрометации средств аутентификации |
[cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
[cspm.crypto.secrets-coi](../../rules-reference/cspm.md#secrets-coi)
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.aws-token](../../rules-reference/cspm.md#aws-token)
||
|| **Управление доступом субъектов доступа к объектам доступа** (УПД) {.cell-align-center} | > | > ||
|| УПД.2 | Реализация необходимых методов управления доступом (дискреционный, мандатный, ролевой или иной метод), типов (чтение, запись, выполнение или иной тип) и правил разграничения доступа |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
[cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access)
[cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access)
||
|| УПД.3 | Управление (фильтрация, маршрутизация, контроль соединений, однонаправленная передача и иные способы управления) информационными потоками между устройствами, сегментами информационной системы, а также между информационными системами |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
[cspm.network.db-ip](../../rules-reference/cspm.md#db-ip)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc)
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
||
|| УПД.4 | Разделение полномочий (ролей) пользователей, администраторов и лиц, обеспечивающих функционирование информационной системы |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| УПД.5 | Назначение минимально необходимых прав и привилегий пользователям, администраторам и лицам, обеспечивающим функционирование информационной системы |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
[cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access)
||
|| УПД.6 | Ограничение неуспешных попыток входа в информационную систему (доступа к информационной системе) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| УПД.10 | Блокирование сеанса доступа в информационную систему после установленного времени бездействия (неактивности) пользователя или по его запросу | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#cookie-timeout-organization) ||
|| УПД.11 | Разрешение (запрет) действий пользователей, разрешенных до идентификации и аутентификации | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| УПД.13 | Реализация защищенного удаленного доступа субъектов доступа к объектам доступа через внешние информационно-телекоммуникационные сети | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| УПД.17 | Обеспечение доверенной загрузки средств вычислительной техники | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| **Ограничение программной среды** (ОПС) {.cell-align-center} | > | > ||
|| ОПС.1 | Управление запуском (обращениями) компонентов программного обеспечения, в том числе определение запускаемых компонентов, настройка параметров запуска компонентов, контроль за запуском компонентов программного обеспечения |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm)
||
|| ОПС.2 | Управление установкой (инсталляцией) компонентов программного обеспечения, в том числе определение компонентов, подлежащих установке, настройка параметров установки компонентов, контроль за установкой компонентов программного обеспечения |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
||
|| ОПС.3 | Установка (инсталляция) только разрешенного к использованию программного обеспечения и (или) его компонентов |
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
[cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry)
||
|| **Регистрация событий безопасности** (РСБ) {.cell-align-center} | > | > ||
|| РСБ.1 | Определение событий безопасности, подлежащих регистрации, и сроков их хранения |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| РСБ.2 | Определение состава и содержания информации о событиях безопасности, подлежащих регистрации |
[cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events)
[cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs)
||
|| РСБ.3 | Сбор, запись и хранение информации о событиях безопасности в течение установленного времени хранения |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
[cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs)
||
|| РСБ.4 | Реагирование на сбои при регистрации событий безопасности, в том числе аппаратные и программные ошибки, сбои в механизмах сбора информации и достижение предела или переполнения объема (емкости) памяти | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|| РСБ.7 | Защита информации о событиях безопасности |
[cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock)
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
||
|| **Антивирусная защита** (АВЗ) {.cell-align-center} | > | > ||
|| АВЗ.1 | Реализация антивирусной защиты |
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| АВЗ.2 | Обновление базы данных признаков вредоносных компьютерных программ (вирусов) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| **Обнаружение вторжений** (СОВ) {.cell-align-center} | > | > ||
|| СОВ.1 | Обнаружение вторжений |
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws)
||
|| СОВ.2 | Обновление базы решающих правил | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| **Контроль (анализ) защищенности персональных данных** (АНЗ) {.cell-align-center} | > | > ||
|| АНЗ.1 | Выявление, анализ и устранение уязвимостей информационной системы |
[cspm.active.ip-vulnerability-scan](../../rules-reference/cspm.md#ip-vulnerability-scan)
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| АНЗ.2 | Контроль установки обновлений программного обеспечения, включая программное обеспечение средств защиты информации | [cspm.k8s.version-update](../../rules-reference/cspm.md#version-update) ||
|| АНЗ.3 | Контроль работоспособности, параметров настройки и правильности функционирования программного обеспечения и средств защиты информации |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
||
|| АНЗ.4 | Контроль состава технических средств, программного обеспечения и средств защиты информации | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| АНЗ.5 | Парольная политика | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| **Обеспечение целостности информационной системы и информации** (ОЦЛ) {.cell-align-center} | > | > ||
|| ОЦЛ.1 | Контроль целостности программного обеспечения, включая программное обеспечение средств защиты информации | [cspm.runtime.vm-environment-integrity](../../rules-reference/cspm.md#vm-environment-integrity) ||
|| ОЦЛ.2 | Контроль целостности информации, содержащейся в базах данных информационной системы |
[cspm.crypto.data.application-encryption](../../rules-reference/cspm.md#application-encryption)
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
[cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm)
[cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation)
||
|| ОЦЛ.3 | Обеспечение возможности восстановления программного обеспечения, включая программное обеспечение средств защиты информации, при возникновении нештатных ситуаций |
[cspm.compute.snapshot](../../rules-reference/cspm.md#snapshot)
[cspm.k8s.backup](../../rules-reference/cspm.md#backup)
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| ОЦЛ.4 | Обнаружение и реагирование на поступление в информационную систему незапрашиваемых электронных сообщений (писем, документов) и иной информации, не относящихся к функционированию информационной системы (защита от спама) |
[cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha)
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl)
||
|| ОЦЛ.6 | Ограничение прав пользователей по вводу информации в информационную систему |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
||
|| **Обеспечение доступности персональных данных** (ОДТ) {.cell-align-center} | > | > ||
|| ОДТ.4 | Периодическое резервное копирование информации на резервные машинные носители информации |
[cspm.compute.snapshot](../../rules-reference/cspm.md#snapshot)
[cspm.k8s.backup](../../rules-reference/cspm.md#backup)
||
|| ОДТ.5 | Обеспечение возможности восстановления информации с резервных машинных носителей информации (резервных копий) в течение установленного временного интервала |
[cspm.compute.snapshot](../../rules-reference/cspm.md#snapshot)
[cspm.k8s.backup](../../rules-reference/cspm.md#backup)
||
|| **Защита технических средств** (ЗТС) / **Защита среды виртуализации** (ЗСВ) {.cell-align-center} | > | > ||
|| ЗСВ.1 | Идентификация и аутентификация субъектов доступа и объектов доступа в виртуальной инфраструктуре, в том числе администраторов управления средствами виртуализации |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.access](../../rules-reference/cspm.md#access)
||
|| ЗСВ.2 | Управление доступом субъектов доступа к объектам доступа в виртуальной инфраструктуре, в том числе внутри виртуальных машин |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.access](../../rules-reference/cspm.md#access)
||
|| ЗСВ.3 | Регистрация событий безопасности в виртуальной инфраструктуре | [cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs) ||
|| ЗСВ.4 | Управление (фильтрация, маршрутизация, контроль соединения, однонаправленная передача) потоками информации между компонентами виртуальной инфраструктуры, а также по периметру виртуальной инфраструктуры | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| ЗСВ.5 | Доверенная загрузка серверов виртуализации, виртуальной машины (контейнера), серверов управления виртуализацией | [cspm.runtime.vm-environment-integrity](../../rules-reference/cspm.md#vm-environment-integrity) ||
|| ЗСВ.6 | Управление перемещением виртуальных машин (контейнеров) и обрабатываемых на них данных | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|| ЗСВ.7 | Контроль целостности виртуальной инфраструктуры и ее конфигураций | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|| ЗСВ.8 | Резервное копирование данных, резервирование технических средств, программного обеспечения виртуальной инфраструктуры, а также каналов связи внутри виртуальной инфраструктуры | [cspm.k8s.backup](../../rules-reference/cspm.md#backup) ||
|| ЗСВ.9 | Реализация антивирусной защиты в виртуальной инфраструктуре |
[cspm.appsec.upload-policy](../../rules-reference/cspm.md#upload-policy)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
[cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan)
||
|| ЗСВ.10 | Разбиение виртуальной инфраструктуры на сегменты (сегментирование виртуальной инфраструктуры) для обработки информации отдельным пользователем и (или) группой пользователей |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| **Защита информационной системы, ее средств и систем связи и передачи данных** (ЗИС) {.cell-align-center} | > | > ||
|| ЗИС.1 | Разделение в информационной системе функций по управлению (администрированию) информационной системой, управлению (администрированию) системой защиты информации, функций по обработке информации и иных функций информационной системы | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| ЗИС.3 | Обеспечение защиты информации от раскрытия, модификации и навязывания (ввода ложной информации) при ее передаче (подготовке к передаче) по каналам связи, имеющим выход за пределы контролируемой зоны |
[cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity)
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| ЗИС.4 | Обеспечение доверенных канала, маршрута между администратором, пользователем и средствами защиты информации (функциями безопасности средств защиты информации) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| ЗИС.11 | Обеспечение подлинности сетевых соединений (сеансов взаимодействия), в том числе для защиты от подмены сетевых устройств и сервисов |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| ЗИС.15 | Защита архивных файлов, параметров настройки средств защиты информации и программного обеспечения и иных данных, не подлежащих изменению в процессе обработки информации | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| ЗИС.17 | Разбиение информационной системы на сегменты (сегментирование информационной системы) и обеспечение защиты периметров сегментов информационной системы |
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
[cspm.k8s.api-security](../../rules-reference/cspm.md#api-security)
||
|| **Выявление инцидентов и реагирование на них** (ИНЦ) {.cell-align-center} | > | > ||
|| ИНЦ.2 | Обнаружение, идентификация и регистрация инцидентов |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs)
[cspm.procedure.organization-contacts](../../rules-reference/cspm.md#organization-contacts)
||
|| ИНЦ.6 | Планирование и принятие мер по предотвращению повторного возникновения инцидентов |
[cspm.k8s.version-update](../../rules-reference/cspm.md#version-update)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| **Управление конфигурацией информационной системы и системы защиты персональных данных** (УКФ) {.cell-align-center} | > | > ||
|| УКФ.1–УКФ.4 | Управление конфигурацией информационной системы и системы защиты персональных данных | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|#