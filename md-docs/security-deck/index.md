

# Yandex Security Deck

## Начало работы

 - [Обзор](quickstart-overview.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Окружения {{ sd-name }}

 - [Обзор](operations/workspaces/index.md)

 - [Создать окружение](operations/workspaces/create.md)

 - [Посмотреть дашборд и операции с окружением](operations/workspaces/view-dashboard.md)

 - [Изменить окружение](operations/workspaces/update.md)

 - [Настроить права доступа к окружению](operations/workspaces/manage-access.md)

 - [Удалить окружение](operations/workspaces/delete.md)

### Алерты

 - [Посмотреть алерты](operations/alerts/view.md)

 - [Работа с алертами](operations/alerts/work.md)

### Контроль данных ({{ dspm-name }})

 - [Обзор](operations/dspm/index.md)

 - [Создать источник данных](operations/dspm/create-data-source.md)

 - [Создать сканирование](operations/dspm/create-scan.md)

 - [Управлять анализом данных](operations/dspm/discovery-mode.md)

 - [Управлять результатами сканирования](operations/dspm/work-with-results.md)

### Контроль {{ k8s }}® ({{ kspm-name }})

 - [Обзор](operations/kspm/index.md)

 - [Активировать модуль {{ kspm-name }}](operations/kspm/enable-kspm.md)

 - [Работать с дашбордом](operations/kspm/use-kspm.md)

 - [Посмотреть правила контроля](operations/kspm/view-rules.md)

 - [Проверить соответствие стандартам безопасности](operations/kspm/check-compliance.md)

 - [Управлять исключениями из правил контроля](operations/kspm/manage-exceptions.md)

### Диагностика доступов ({{ ciem-name }})

 - [Обзор](operations/ciem/index.md)

 - [Просмотреть список доступов](operations/ciem/view-permissions.md)

 - [Отозвать доступ](operations/ciem/revoke-permissions.md)

### Контроль конфигурации ({{ cspm-name }})

 - [Обзор](operations/cspm/index.md)

 - [Посмотреть правила контроля и нарушения](operations/cspm/view-rules.md)

 - [Запустить проверку окружения](operations/cspm/check-environment.md)

 - [Проверить соответствие стандартам безопасности](operations/cspm/check-compliance.md)

 - [Управлять исключениями из правил контроля](operations/cspm/manage-exceptions.md)

### {{ td-full-name }} ({{ td-name }})

 - [Обзор](operations/td/index.md)

 - [Посмотреть правила контроля](operations/td/view-rules.md)

 - [Управлять исключениями из правил контроля](operations/td/manage-exceptions.md)

### {{ vuln-man-name }} ({{ vuln-man-short-name }})

 - [Обзор](operations/vulnerability-management/index.md)

 - [Активировать модуль](operations/vulnerability-management/enable-vulnerability-management.md)

 - [Работать с дашбордом](operations/vulnerability-management/use-vulnerability-management.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Окружения {{ sd-name }}](concepts/workspace.md)

 - [{{ alerts-name }} в {{ sd-name }}](concepts/alerts.md)

### Интерфейс соответствия требованиям

 - [Обзор](concepts/standard-compliance/index.md)

 - [Базовые правила безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md)

 - [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](concepts/standard-compliance/yc-cloud-security-standard.md)

 - [Требования стандарта CIS Benchmark™ для {{ k8s }}](concepts/standard-compliance/cis-kubernetes-benchmark.md)

 - [Стандарт по защите персональных данных пользователей {{ yandex-cloud }}](concepts/standard-compliance/yc-personal-data-protection.md)

 - [Стандарт PCI DSS в {{ yandex-cloud }}](concepts/standard-compliance/yc-pci-dss.md)

 - [Требования стандарта ГОСТ Р 57580](concepts/standard-compliance/yc-gost-57580.md)

 - [Контроль данных ({{ dspm-name }})](concepts/dspm.md)

 - [Контроль {{ k8s }}® ({{ kspm-name }})](concepts/kspm.md)

 - [Диагностика доступов ({{ ciem-name }})](concepts/ciem.md)

 - [Контроль конфигурации ({{ cspm-name }})](concepts/cspm.md)

 - [{{ td-full-name }} ({{ td-name }})](concepts/threat-detector.md)

 - [{{ vuln-man-name }} ({{ vuln-man-short-name }})](concepts/vulnerability-management.md)

 - [{{ atr-name }}](concepts/access-transparency.md)

 - [Портал соответствия требованиям](concepts/compliance.md)

 - [AI-ассистент](concepts/ai-assistant.md)

 - [Квоты и лимиты](concepts/limits.md)

## Диагностика ошибок

 - [Обзор](diagnostics/index.md)

 - [Ошибки в работе {{ kspm-name }}](diagnostics/kspm-diagnostics.md)

 - [Ошибки в работе {{ dspm-name }}](diagnostics/dspm-diagnostics.md)

## Управление доступом

 - [Общие роли {{ sd-name }}](security/index.md)

 - [Роли {{ dspm-name }}](security/dspm-roles.md)

 - [Роли {{ kspm-name }}](security/kspm-roles.md)

 - [Роли {{ ciem-name }}](security/ciem-roles.md)

 - [Роли {{ cspm-name }}](security/cspm-roles.md)

 - [Роли {{ atr-name }}](security/access-transparency-roles.md)

 - [Роли модуля {{ alerts-name }}](security/alerts-roles.md)

 - [Правила тарификации](pricing.md)

## Справочник правил

 - [Обзор](rules-reference/index.md)

 - [Все правила](rules-reference/all.md)

 - [{{ cspm-name }}](rules-reference/cspm.md)

 - [{{ kspm-name }}](rules-reference/kspm.md)

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

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)