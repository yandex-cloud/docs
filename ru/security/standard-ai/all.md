---
title: Стандарт безопасности для внедрения и эксплуатации ИИ-систем в {{ yandex-cloud }}, версия {{ security-standard-ai-current-version }}
description: Этот документ содержит все разделы стандарта безопасности для систем искусственного интеллекта, развернутых полностью или частично в {{ yandex-cloud }}, и помогает выбрать меры обеспечения информационной безопасности при разработке и эксплуатации ИИ-систем.
---

# Стандарт безопасности для внедрения и эксплуатации ИИ-систем в {{ yandex-cloud }}, версия {{ security-standard-ai-current-version }}

<!-- Заголовки полной версии задаются здесь; текстовые блоки общие с отдельными страницами. При изменении структуры разделов обновите оба оглавления. -->

## Введение {#intro}

### Назначение и область применения {#scope}

{% include [content](../../_includes/security/standard-ai/intro/scope-body.md) %}

### Разделение ответственности {#responsibility}

{% include [content](../../_includes/security/standard-ai/intro/responsibility-body.md) %}

### Как применять стандарт {#how-to-apply}

{% include [content](../../_includes/security/standard-ai/intro/how-to-apply-body.md) %}

### Исключения {#exceptions}

{% include [content](../../_includes/security/standard-ai/intro/exceptions-body.md) %}

### Идентификаторы {#identifiers}

{% include [content](../../_includes/security/standard-ai/intro/identifiers-body.md) %}

### Свидетельства {#evidence}

{% include [content](../../_includes/security/standard-ai/intro/evidence-body.md) %}

## Безопасная архитектура и разработка ИИ-приложений {#secure-architecture}

{% include [content](../../_includes/security/standard-ai/secure-architecture/secure-architecture-intro-body.md) %}

### Архитектура и изменения {#architecture-changes}

#### Архитектура и риски зафиксированы до выпуска {#architecture-risks-fixed-before-release}

{% include [content](../../_includes/security/standard-ai/secure-architecture/architecture-risks-fixed-before-release-body.md) %}

### Вход, контекст и вывод {#input-context-output}

#### Недоверенный ввод проверяется до использования моделью {#untrusted-input-validated-before-model-use}

{% include [content](../../_includes/security/standard-ai/secure-architecture/untrusted-input-validated-before-model-use-body.md) %}

#### Правила модерации имеют определенные категории и отказоустойчивое поведение {#moderation-rules-defined-categories-failover}

{% include [content](../../_includes/security/standard-ai/secure-architecture/moderation-rules-defined-categories-failover-body.md) %}

#### Вывод модели проверяется до рендеринга и исполнения {#model-output-validated-before-render-exec}

{% include [content](../../_includes/security/standard-ai/secure-architecture/model-output-validated-before-render-exec-body.md) %}

#### Системные инструкции и политики изменяются только доверенным путем {#system-prompts-policies-changed-trusted-path}

{% include [content](../../_includes/security/standard-ai/secure-architecture/system-prompts-policies-changed-trusted-path-body.md) %}

#### Внешний и найденный контекст не получает доверия автоматически {#external-retrieved-context-no-implicit-trust}

{% include [content](../../_includes/security/standard-ai/secure-architecture/external-retrieved-context-no-implicit-trust-body.md) %}

### Внешние связи и публичный периметр {#external-connections}

#### Вызовы внешнего модельного API проходят через управляемую границу {#external-model-api-calls-managed-boundary}

{% include [content](../../_includes/security/standard-ai/secure-architecture/external-model-api-calls-managed-boundary-body.md) %}

#### Публичный HTTP(S)-периметр имеет явную схему защиты {#public-http-perimeter-explicit-protection}

{% include [content](../../_includes/security/standard-ai/secure-architecture/public-http-perimeter-explicit-protection-body.md) %}

## Данные, обучение, модели и выпуски {#data-training-models}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-training-models-intro-body.md) %}

### Прием и подготовка данных {#data-intake}

#### Каждый набор данных имеет владельца, происхождение и разрешенное назначение {#dataset-has-owner-origin-allowed-purpose}

{% include [content](../../_includes/security/standard-ai/data-training-models/dataset-has-owner-origin-allowed-purpose-body.md) %}

#### Загрузчик RAG ограничен утвержденным источником и назначением {#rag-loader-restricted-approved-source-destination}

{% include [content](../../_includes/security/standard-ai/data-training-models/rag-loader-restricted-approved-source-destination-body.md) %}

#### Стадии данных разделены {#data-stages-separated}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-stages-separated-body.md) %}

#### Данные классифицированы и минимизированы до передачи в ИИ-контур {#data-classified-minimized-before-ai}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-classified-minimized-before-ai-body.md) %}

#### Качество данных и независимость оценки проверяются до выпуска {#data-quality-independent-assessment-before-release}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-quality-independent-assessment-before-release-body.md) %}

#### Изменения данных и RAG-корпуса контролируются {#data-and-rag-corpus-changes-controlled}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-and-rag-corpus-changes-controlled-body.md) %}

#### Синтетические данные учитываются отдельно {#synthetic-data-accounted-separately}

{% include [content](../../_includes/security/standard-ai/data-training-models/synthetic-data-accounted-separately-body.md) %}

### Обучение и модельные артефакты {#training-artifacts}

#### Разработка, обучение и продуктивное выполнение разделены {#dev-training-prod-execution-separated}

{% include [content](../../_includes/security/standard-ai/data-training-models/dev-training-prod-execution-separated-body.md) %}

#### Модельный комплект имеет проверяемое происхождение {#model-artifact-verifiable-provenance}

{% include [content](../../_includes/security/standard-ai/data-training-models/model-artifact-verifiable-provenance-body.md) %}

#### Формат и загрузчик модели не допускают произвольного выполнения {#model-format-loader-no-arbitrary-exec}

{% include [content](../../_includes/security/standard-ai/data-training-models/model-format-loader-no-arbitrary-exec-body.md) %}

### Выпуск, откат и отзыв {#release-rollback}

#### В продуктивную среду допускается точная проверенная версия {#exact-verified-version-admitted-to-prod}

{% include [content](../../_includes/security/standard-ai/data-training-models/exact-verified-version-admitted-to-prod-body.md) %}

#### Замена, откат и отзыв версии управляются явно {#version-managed-explicitly}

{% include [content](../../_includes/security/standard-ai/data-training-models/version-managed-explicitly-body.md) %}

## {{ iam-short-name }}, сеть, шифрование, секреты и аудит {#iam-network-crypto-secrets-audit}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/iam-network-crypto-secrets-audit-intro-body.md) %}

### Права и доступ {#rights-access}

#### Межкомпонентные соединения ограничены фактической топологией {#intercomponent-connections-limited-by-topology}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/intercomponent-connections-limited-by-topology-body.md) %}

#### Рабочие идентичности имеют минимальные эффективные права {#workload-identities-minimal-effective-rights}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/workload-identities-minimal-effective-rights-body.md) %}

#### Вызов {{ ai-studio-name }} использует документированный способ аутентификации {#ai-studio-call-uses-documented-auth}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/ai-studio-call-uses-documented-auth-body.md) %}

#### Эффективные права пересматриваются по расписанию и после изменений {#effective-rights-reviewed-on-schedule-and-change}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/effective-rights-reviewed-on-schedule-and-change-body.md) %}

#### Учетные записи привилегированных пользователей используют MFA {#privileged-users-use-mfa}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/privileged-users-use-mfa-body.md) %}

#### Обходные административные каналы среды исполнения отключены по умолчанию {#runtime-administrative-bypass-channels-disabled}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/runtime-administrative-bypass-channels-disabled-body.md) %}

### Хранилища и криптографическая защита {#storage-crypto}

#### Хранилища моделей и данных не имеют неучтенного публичного доступа {#model-data-stores-no-unaccounted-public-access}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/model-data-stores-no-unaccounted-public-access-body.md) %}

#### Шифрование выбирается по возможностям конкретного сервиса {#encryption-chosen-by-service-capabilities}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/encryption-chosen-by-service-capabilities-body.md) %}

### Секреты {#secrets}

#### Секрет имеет владельца и управляемый жизненный цикл {#secret-has-owner-managed-lifecycle}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/secret-has-owner-managed-lifecycle-body.md) %}

### Аудит и содержимое журналов {#audit-logs}

#### Для каждой существенной операции указан источник события {#material-operation-has-event-source}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/material-operation-has-event-source-body.md) %}

#### Журналы не собирают чувствительное содержимое без цели {#logs-no-sensitive-content-without-purpose}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/logs-no-sensitive-content-without-purpose-body.md) %}

## Среда исполнения, RAG-хранилища и вывод из эксплуатации {#runtime-rag-decom}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/runtime-rag-decom-intro-body.md) %}

### Изоляция среды исполнения {#runtime-isolation}

#### Независимые нагрузки и арендаторы изолированы {#independent-workloads-tenants-isolated}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/independent-workloads-tenants-isolated-body.md) %}

#### Состояние между независимыми задачами не сохраняется по умолчанию {#no-state-preserved-between-independent-tasks}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/no-state-preserved-between-independent-tasks-body.md) %}

#### Исполнение кода, команд и динамических запросов ограничено {#code-commands-dynamic-queries-restricted}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/code-commands-dynamic-queries-restricted-body.md) %}

### Авторизация RAG {#rag-authorization}

#### Право на документ проверяется до передачи фрагмента модели {#document-access-checked-before-rag-retrieval}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/document-access-checked-before-rag-retrieval-body.md) %}

### Вывод из эксплуатации {#decommissioning}

#### Компонент выводится из эксплуатации полностью {#component-decommissioned-fully}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/component-decommissioned-fully-body.md) %}

## Мониторинг и реагирование на инциденты {#monitoring-incident-response}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/monitoring-incident-response-intro-body.md) %}

### Сигналы и оповещения {#signals-alerts}

#### Нетипичное использование API и ресурсов обнаруживается {#atypical-api-resource-usage-detected}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/atypical-api-resource-usage-detected-body.md) %}

### Сквозная прикладная трассировка {#end-to-end-trace}

#### Модельный и агентный запрос прослеживается без избыточного содержимого {#model-agent-request-traced-no-excess-content}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/model-agent-request-traced-no-excess-content-body.md) %}

#### Каждая итерация агентного цикла связана с задачей и действием {#agent-loop-iteration-linked-to-task-action}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/agent-loop-iteration-linked-to-task-action-body.md) %}

### Сохранность материалов расследования {#forensic-preservation}

#### Архив содержимого диалога имеет утвержденный объем и контролируемый доступ {#dialog-archive-approved-scope-controlled-access}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/dialog-archive-approved-scope-controlled-access-body.md) %}

#### Материалы расследования защищены от незаметного изменения {#forensic-materials-protected-from-tampering}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/forensic-materials-protected-from-tampering-body.md) %}

### Порядок реагирования {#response-procedure}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/response-procedure-body.md) %}

## Агенты, инструменты, MCP и агентный RAG {#agents-tools-mcp}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agents-tools-mcp-intro-body.md) %}

### Возможности и автономность {#capabilities-autonomy}

#### Возможности агента и внешние последствия перечислены {#agent-capabilities-external-effects-enumerated}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agent-capabilities-external-effects-enumerated-body.md) %}

#### Автономное выполнение имеет лимиты и условия остановки {#autonomous-execution-limits-stop-conditions}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/autonomous-execution-limits-stop-conditions-body.md) %}

#### Цель и полномочия агента поступают только из доверенных источников {#agent-goal-authority-from-trusted-sources}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agent-goal-authority-from-trusted-sources-body.md) %}

### Идентичность инструмента и подтверждение человека {#tool-identity-hitl}

#### Каждый инструмент использует отдельную учетную запись с минимальными правами {#each-tool-has-separate-minimal-identity}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/each-tool-has-separate-minimal-identity-body.md) %}

#### Полномочия сессии определяются доверенной делегацией {#session-authority-defined-by-trusted-delegation}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/session-authority-defined-by-trusted-delegation-body.md) %}

#### Действия с существенными последствиями подтверждает человек {#material-consequence-actions-confirmed-by-human}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/material-consequence-actions-confirmed-by-human-body.md) %}

### MCP Gateway и целевой сервис {#mcp-gateway-target}

#### Доступ к MCP Gateway и целевому сервису разделен {#mcp-gateway-target-service-access-separated}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/mcp-gateway-target-service-access-separated-body.md) %}

### Межагентные сообщения и агентный RAG {#interagent-rag}

#### Сообщение другого агента проверяется как недоверенное {#other-agent-message-checked-as-untrusted}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/other-agent-message-checked-as-untrusted-body.md) %}

## Цепочка поставок {#supply-chain}

{% include [content](../../_includes/security/standard-ai/supply-chain/supply-chain-intro-body.md) %}

### Сторонние датасеты {#third-party-datasets}

#### Происхождение и целостность стороннего датасета проверены {#third-party-dataset-provenance-integrity-verified}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-dataset-provenance-integrity-verified-body.md) %}

#### Содержимое стороннего датасета проходит приемную проверку {#third-party-dataset-content-intake-check}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-dataset-content-intake-check-body.md) %}

### Сторонние модели {#third-party-models}

#### Формат, загрузчик и поведение сторонней модели проверены до допуска {#third-party-model-format-loader-behavior-checked}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-model-format-loader-behavior-checked-body.md) %}

#### Сторонняя модель проходит формальную процедуру приемки {#third-party-model-formal-acceptance-procedure}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-model-formal-acceptance-procedure-body.md) %}

### Уязвимости программных компонентов {#dependency-vulns}

#### Уязвимости зависимостей и контейнерных образов управляются {#dependency-container-image-vulns-managed}

{% include [content](../../_includes/security/standard-ai/supply-chain/dependency-container-image-vulns-managed-body.md) %}

### Воспроизводимый состав выпуска {#reproducible-release}

#### Для выпуска известен состав программных и ИИ-компонентов {#release-software-ai-components-known}

{% include [content](../../_includes/security/standard-ai/supply-chain/release-software-ai-components-known-body.md) %}

### Изменение риска поставщика {#supplier-risk-change}

#### Изменение компонента или внешнего сервиса вызывает повторную оценку {#component-external-service-change-triggers-reassessment}

{% include [content](../../_includes/security/standard-ai/supply-chain/component-external-service-change-triggers-reassessment-body.md) %}

## Профили реализации в {{ yandex-cloud }} {#profiles}

{% include [content](../../_includes/security/standard-ai/profiles/profiles-intro-body.md) %}

### Управляемый инференс через {{ ai-studio-name }} {#profile-ai-studio}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ai-studio-body.md) %}

### RAG через {{ ai-search-name }} {#profile-ai-search}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ai-search-body.md) %}

### RAG через собственное хранилище {#profile-own-storage}

{% include [content](../../_includes/security/standard-ai/profiles/profile-own-storage-body.md) %}

#### {{ mos-name }} {#profile-mos}

{% include [content](../../_includes/security/standard-ai/profiles/profile-mos-body.md) %}

#### {{ ydb-short-name }} {#profile-ydb}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ydb-body.md) %}

### Агент с MCP Gateway и инструментами {#profile-mcp-agent}

{% include [content](../../_includes/security/standard-ai/profiles/profile-mcp-agent-body.md) %}

### Обучение и эксперименты в {{ ml-platform-name }} {#profile-ml-platform}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ml-platform-body.md) %}

### Среда исполнения в {{ managed-k8s-name }} {#profile-k8s}

{% include [content](../../_includes/security/standard-ai/profiles/profile-k8s-body.md) %}

### Среда исполнения в {{ serverless-containers-name }} или {{ sf-name }} {#profile-serverless}

{% include [content](../../_includes/security/standard-ai/profiles/profile-serverless-body.md) %}

#### {{ serverless-containers-name }} {#profile-serverless-containers}

{% include [content](../../_includes/security/standard-ai/profiles/profile-serverless-containers-body.md) %}

#### {{ sf-name }} {#profile-sf}

{% include [content](../../_includes/security/standard-ai/profiles/profile-sf-body.md) %}

### Среда исполнения на {{ compute-name }} с самостоятельно размещенной моделью {#profile-compute}

{% include [content](../../_includes/security/standard-ai/profiles/profile-compute-body.md) %}

### Вызов внешнего модельного API из {{ yandex-cloud }} {#profile-external-api}

{% include [content](../../_includes/security/standard-ai/profiles/profile-external-api-body.md) %}

### Границы общих средств защиты {#shared-tools-boundaries}

{% include [content](../../_includes/security/standard-ai/profiles/shared-tools-boundaries-body.md) %}

## Соответствие требованиям и обработка персональных и регулируемых данных {#compliance-pii}

{% include [content](../../_includes/security/standard-ai/compliance-pii/compliance-pii-intro-body.md) %}

### Правовое решение и размещение {#legal-placement}

#### Утвержденная допустимость обработки {#approved-processing-admissibility}

{% include [content](../../_includes/security/standard-ai/compliance-pii/approved-processing-admissibility-body.md) %}

#### Ограничения размещения реализованы в архитектуре {#placement-restrictions-enforced-in-architecture}

{% include [content](../../_includes/security/standard-ai/compliance-pii/placement-restrictions-enforced-in-architecture-body.md) %}

### Внешние получатели и трансграничные потоки {#external-recipients}

#### Передача внешнему получателю разрешена и ограничена {#external-recipient-transfer-allowed-limited}

{% include [content](../../_includes/security/standard-ai/compliance-pii/external-recipient-transfer-allowed-limited-body.md) %}

#### Трансграничный поток разрешен отдельным решением {#cross-border-flow-allowed-by-separate-decision}

{% include [content](../../_includes/security/standard-ai/compliance-pii/cross-border-flow-allowed-by-separate-decision-body.md) %}

### Обезличивание, псевдонимизация и маскирование ПДн {#deidentification-masking}

{% include [content](../../_includes/security/standard-ai/compliance-pii/deidentification-masking-body.md) %}

#### Защитное преобразование выполняется до границы доверия {#protective-transform-before-trust-boundary}

{% include [content](../../_includes/security/standard-ai/compliance-pii/protective-transform-before-trust-boundary-body.md) %}

#### Средства обнаружения ПДн соответствуют данным и риску {#pii-detection-tools-match-data-and-risk}

{% include [content](../../_includes/security/standard-ai/compliance-pii/pii-detection-tools-match-data-and-risk-body.md) %}

#### Преобразование контролируется и не обходится при ошибке {#transform-controlled-not-bypassed-on-error}

{% include [content](../../_includes/security/standard-ai/compliance-pii/transform-controlled-not-bypassed-on-error-body.md) %}

## Проверка и тестирование безопасности {#security-testing}

{% include [content](../../_includes/security/standard-ai/security-testing/security-testing-intro-body.md) %}

### Подготовка области проверки {#test-preparation}

{% include [content](../../_includes/security/standard-ai/security-testing/test-preparation-body.md) %}

### Порядок проверки одного требования {#single-requirement-check}

{% include [content](../../_includes/security/standard-ai/security-testing/single-requirement-check-body.md) %}

### Проверка конфигурации и {{ iam-short-name }} {#config-iam-check}

{% include [content](../../_includes/security/standard-ai/security-testing/config-iam-check-body.md) %}

### Проверка журналов и телеметрии {#logs-telemetry-check}

{% include [content](../../_includes/security/standard-ai/security-testing/logs-telemetry-check-body.md) %}

### Безопасные негативные и прикладные тесты {#negative-app-tests}

{% include [content](../../_includes/security/standard-ai/security-testing/negative-app-tests-body.md) %}

### Активное тестирование (red teaming) {#red-teaming}

{% include [content](../../_includes/security/standard-ai/security-testing/red-teaming-body.md) %}

### Исправление, исключение и повторная проверка {#fix-exception-recheck}

{% include [content](../../_includes/security/standard-ai/security-testing/fix-exception-recheck-body.md) %}

## Метрики внедрения и контроля стандарта {#metrics}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-intro-body.md) %}

### Охват и соответствие стандарту {#metrics-coverage}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-coverage-body.md) %}

### Управление идентификацией, доступом и секретами {#metrics-iam-secrets}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-iam-secrets-body.md) %}

### Защита данных и конвейеров {#metrics-data-pipelines}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-data-pipelines-body.md) %}

### Безопасность моделей, агентов и RAG {#metrics-models-agents-rag}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-models-agents-rag-body.md) %}

### Управление уязвимостями и цепочка поставок {#metrics-vulns-supply-chain}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-vulns-supply-chain-body.md) %}

### Мониторинг, инциденты и наблюдаемость {#metrics-monitoring-incidents}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-monitoring-incidents-body.md) %}

## Безопасность систем искусственного интеллекта для финтех-организаций {#fintech}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-intro-body.md) %}

### Источник внешних рекомендаций {#fintech-source}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-source-body.md) %}

### Статус приложения {#fintech-status}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-status-body.md) %}

### Статусы соответствия {#compliance-statuses}

{% include [content](../../_includes/security/standard-ai/fintech/compliance-statuses-body.md) %}

### Распределение ответственности {#responsibility-distribution}

{% include [content](../../_includes/security/standard-ai/fintech/responsibility-distribution-body.md) %}

### Матрица соответствия {#compliance-matrix}

#### Управление ИИ-рисками {#matrix-ai-risks}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-ai-risks-body.md) %}

#### Данные и приватность {#matrix-data-privacy}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-data-privacy-body.md) %}

#### Модель, разработка и поставка {#matrix-model-supply}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-model-supply-body.md) %}

#### Тестирование и устойчивость {#matrix-testing-resilience}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-testing-resilience-body.md) %}

#### Эксплуатация и мониторинг {#matrix-ops-monitoring}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-ops-monitoring-body.md) %}

#### Управление поставщиками и Open Source Software (OSS) {#matrix-suppliers-oss}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-suppliers-oss-body.md) %}
