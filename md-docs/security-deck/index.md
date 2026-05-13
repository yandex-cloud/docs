# Yandex Security Deck

<em>Сервис Yandex Security Deck находится на <a href="../overview/concepts/launch-stages.md">стадии Preview</a></em>.



Yandex Security Deck — это комплексный сервис CNAPP, включающий в себя модули:

<ul><li><a href="concepts/access-transparency.md">Отслеживания действий команды Yandex Cloud с ресурсами пользователя</a> (Access Transparency).</li> <li><a href="concepts/dspm.md">Контроля данных</a> (DSPM).</li> <li><a href="concepts/cspm.md">Контроля конфигурации</a> (CSPM).</li> <li><a href="concepts/kspm.md">Контроля Kubernetes</a> (KSPM).</li> <li><a href="concepts/ciem.md">Диагностики доступов</a> (CIEM).</li> <li><a href="concepts/vulnerability-management.md">Управления уязвимостями</a>.</li> <li><a href="concepts/alerts.md">Просмотра алертов</a>.</li> <li><a href="concepts/compliance.md">Портал соответствия требованиям</a>.</li></ul>

Сервис также предоставляет <a href="concepts/ai-assistant.md">AI-ассистента</a> на базе YandexGPT для получения рекомендаций по безопасности.

Предоставляемые сервисом инструменты позволяют вести мониторинг и реагировать на инциденты, обнаруживать уязвимости в контейнерных образах, контролировать конфигурацию облачной инфраструктуры и безопасность контейнеризованных приложений, отслеживать и защищать доступ к данным, а также контролировать соблюдение нормативных актов и отраслевых стандартов. Управление настройками и ресурсами модулей осуществляется через <a href="concepts/workspace.md">окружения</a> (Workspaces).

# Yandex Security Deck

## Начало работы

 - [Обзор](quickstart-overview.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Окружения Security Deck

 - [Обзор](operations/workspaces/index.md)

 - [Создать окружение](operations/workspaces/create.md)

 - [Посмотреть дашборд и операции с окружением](operations/workspaces/view-dashboard.md)

 - [Изменить окружение](operations/workspaces/update.md)

 - [Настроить права доступа к окружению](operations/workspaces/manage-access.md)

 - [Удалить окружение](operations/workspaces/delete.md)

### Алерты

 - [Посмотреть алерты](operations/alerts/view.md)

 - [Работа с алертами](operations/alerts/work.md)

### Контроль данных (DSPM)

 - [Обзор](operations/dspm/index.md)

 - [Создать источник данных](operations/dspm/create-data-source.md)

 - [Создать сканирование](operations/dspm/create-scan.md)

 - [Управлять анализом данных](operations/dspm/discovery-mode.md)

 - [Управлять результатами сканирования](operations/dspm/work-with-results.md)

### Контроль Kubernetes® (KSPM)

 - [Обзор](operations/kspm/index.md)

 - [Активировать модуль KSPM](operations/kspm/enable-kspm.md)

 - [Работать с дашбордом](operations/kspm/use-kspm.md)

 - [Посмотреть правила контроля](operations/kspm/view-rules.md)

 - [Проверить соответствие стандартам безопасности](operations/kspm/check-compliance.md)

 - [Управлять исключениями из правил контроля](operations/kspm/manage-exceptions.md)

### Диагностика доступов (CIEM)

 - [Обзор](operations/ciem/index.md)

 - [Просмотреть список доступов](operations/ciem/view-permissions.md)

 - [Отозвать доступ](operations/ciem/revoke-permissions.md)

### Контроль конфигурации (CSPM)

 - [Обзор](operations/cspm/index.md)

 - [Посмотреть правила контроля и нарушения](operations/cspm/view-rules.md)

 - [Проверить соответствие стандартам безопасности](operations/cspm/check-compliance.md)

 - [Управлять исключениями из правил контроля](operations/cspm/manage-exceptions.md)

### Обнаружение угроз (TD)

 - [Обзор](operations/td/index.md)

 - [Посмотреть правила контроля](operations/td/view-rules.md)

 - [Управлять исключениями из правил контроля](operations/td/manage-exceptions.md)

### Управление уязвимостями (VM)

 - [Обзор](operations/vulnerability-management/index.md)

 - [Активировать модуль](operations/vulnerability-management/enable-vulnerability-management.md)

 - [Работать с дашбордом](operations/vulnerability-management/use-vulnerability-management.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Окружения Security Deck](concepts/workspace.md)

 - [Алерты в Security Deck](concepts/alerts.md)

### Интерфейс соответствия требованиям

 - [Обзор](concepts/standard-compliance/index.md)

 - [Базовые правила безопасности облачной платформы Yandex Cloud](concepts/standard-compliance/yc-security-baseline.md)

 - [Стандарт по защите облачной инфраструктуры Yandex Cloud](concepts/standard-compliance/yc-cloud-security-standard.md)

 - [Требования стандарта CIS Benchmark™ для Kubernetes](concepts/standard-compliance/cis-kubernetes-benchmark.md)

 - [Стандарт по защите персональных данных пользователей Yandex Cloud](concepts/standard-compliance/yc-personal-data-protection.md)

 - [Стандарт PCI DSS в Yandex Cloud](concepts/standard-compliance/yc-pci-dss.md)

 - [Контроль данных (DSPM)](concepts/dspm.md)

 - [Контроль Kubernetes® (KSPM)](concepts/kspm.md)

 - [Диагностика доступов (CIEM)](concepts/ciem.md)

 - [Контроль конфигурации (CSPM)](concepts/cspm.md)

 - [Обнаружение угроз (TD)](concepts/threat-detector.md)

 - [Управление уязвимостями (VM)](concepts/vulnerability-management.md)

 - [Access Transparency](concepts/access-transparency.md)

 - [Портал соответствия требованиям](concepts/compliance.md)

 - [AI-ассистент](concepts/ai-assistant.md)

 - [Квоты и лимиты](concepts/limits.md)

## Диагностика ошибок

 - [Обзор](diagnostics/index.md)

 - [Ошибки в работе KSPM](diagnostics/kspm-diagnostics.md)

 - [Ошибки в работе DSPM](diagnostics/dspm-diagnostics.md)

## Управление доступом

 - [Общие роли Security Deck](security/index.md)

 - [Роли DSPM](security/dspm-roles.md)

 - [Роли KSPM](security/kspm-roles.md)

 - [Роли CIEM](security/ciem-roles.md)

 - [Роли CSPM](security/cspm-roles.md)

 - [Роли Access Transparency](security/access-transparency-roles.md)

 - [Роли модуля Алерты](security/alerts-roles.md)

 - [Правила тарификации](pricing.md)

## Справочник правил

 - [Обзор](rules-reference/index.md)

 - [Все правила](rules-reference/all.md)

 - [CSPM](rules-reference/cspm.md)

 - [KSPM](rules-reference/kspm.md)

## Справочник API

 - [Аутентификация](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Alert

 - [Overview](api-ref/grpc/Alert/index.md)

 - [List](api-ref/grpc/Alert/list.md)

 - [Get](api-ref/grpc/Alert/get.md)

 - [Update](api-ref/grpc/Alert/update.md)

 - [ListRelatedResources](api-ref/grpc/Alert/listRelatedResources.md)

#### Comment

 - [Overview](api-ref/grpc/Comment/index.md)

 - [List](api-ref/grpc/Comment/list.md)

 - [Create](api-ref/grpc/Comment/create.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Alert

 - [Overview](api-ref/Alert/index.md)

 - [List](api-ref/Alert/list.md)

 - [Get](api-ref/Alert/get.md)

 - [Update](api-ref/Alert/update.md)

#### Comment

 - [Overview](api-ref/Comment/index.md)

 - [List](api-ref/Comment/list.md)

 - [Create](api-ref/Comment/create.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)