# Разграничение зон контроля пользователей {{ ai-studio-name }} и {{ yandex-cloud }}

При работе с сервисом {{ ai-studio-name }} необходимо учитывать, что контролирует [сервис {{ ai-studio-name }}](#cloud-responsibilities), а что — [клиент {{ yandex-cloud }}](#customer-responsibilities). Понимание этих зон контроля помогает эффективно использовать облачные ресурсы и обеспечивать безопасность при работе с ML-моделями, агентами и ИИ-инструментами.

## Зона контроля {{ yandex-cloud }} {#cloud-responsibilities}

* **Физическая безопасность**. Защита дата-центров, серверного оборудования и физической инфраструктуры.

* **Инфраструктура платформы**. Отказоустойчивость платформы, защита сети, гипервизоров и компонентов инфраструктуры.

* **Сервисы и компоненты {{ ai-studio-name }}**. Безопасность и доступность [Model Gallery]({{ link-docs-ai }}ai-studio/concepts/generation/), [Agent Atelier]({{ link-docs-ai }}ai-studio/concepts/agents/), [MCP Hub]({{ link-docs-ai }}ai-studio/concepts/mcp-hub), [API]({{ link-docs-ai }}ai-studio/concepts/api).

* **ML-модели и их работа**. Обеспечение работы доступных в сервисе моделей, их обновления и поддержка.

* **Шифрование данных в состоянии покоя (at rest)**. Шифрование всех данных пользователей по умолчанию на ключах {{ yandex-cloud }}.

* **Шифрование данных в состоянии передачи (in transit)**. Поддержка протокола TLS с наборами алгоритмов шифрования ([cipher suites](https://en.wikipedia.org/wiki/Cipher_suite)), которые обеспечивают соответствие стандарту [PCI DSS](https://ru.wikipedia.org/wiki/PCI_DSS) для всех API.

* **Управление ключами шифрования**. Инфраструктура [{{ kms-full-name }}](*kms_service_info), поддержка стандарта шифрования с проверкой подлинности AES-GCM с длиной ключа 128, 192 или 256 бит.

* **Управление секретами**. Предоставление сервиса [{{ lockbox-full-name }}](*lockbox_service_info) для безопасного хранения.

* **Доступность и целостность данных клиента**. Защита хранилища, репликация данных, а также мониторинг и логирование.

* **Управление доступом**. Механизмы аутентификации, инфраструктура [{{ iam-full-name }}](*iam_service_info), сервисные роли (`ai.playground.user`, `ai.languageModels.user`, `ai.assistants.editor` и др.).

* **Роли для {{ ai-studio-name }}**. Предоставление [гранулярных](*granularity_definition) ролей: `auditor`, `viewer`, `editor`, `admin` для агентов, [датасетов]({{ link-docs-ai }}ai-studio/concepts/resources/dataset), моделей и MCP-серверов.

* **Аудитные логи**. Сервис [{{ at-full-name }}](*audit-trails_service_info) для сбора событий уровня платформы, экспорт событий в [{{ objstorage-full-name }}](*storage_service_info) или [{{ cloud-logging-full-name }}](*logging_service_info).

* **Сетевая безопасность**. Сервис [{{ sws-full-name }}](*sws_service_info) для защиты от L7-атак, [DDoS Protection](*ddos_protection) для защиты от DDoS-атак.

* **Защита от DDoS**. Инфраструктура DDoS Protection, фильтрация трафика.

* **Сканирование на наличие уязвимостей**. Предоставление [сканера уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) для контейнерных образов.

* **Инструменты для разработки агентов и приложений**. Предоставление API, инструментов разработчика ([SDK]({{ link-docs-ai }}ai-studio/sdk/)), инструментов [Agent Atelier]({{ link-docs-ai }}ai-studio/concepts/agents/) и [интерфейс {{ ai-studio-name }}]({{ link-console-ai }}).

* **Дообучение моделей**. Инфраструктура дообучения моделей ([Tuning API]({{ link-docs-ai }}ai-studio/concepts/tuning)), среда для обучения.

* **Компоненты для интеграции с внешними системами**: [{{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/), [{{ search-api-full-name }}](*search-api_service_info).

* **Мониторинг инфраструктуры**. Мониторинг инфраструктуры платформы и ее компонентов.

* **Соответствие требованиям и сертификация**. Соответствие ISO 27001/27017/27018/27701/42001, 152-ФЗ (приказ ФСТЭК № 21, УЗ-1).

* **Защита API**. Безопасность API платформы, [ограничения скорости обработки запросов](../../api-gateway/concepts/extensions/rate-limit.md), аутентификация запросов.

* **Защита промптов и выходных данных**. Предоставление компонента модерации ответов.

* **Управление инцидентами**. Обнаружение и реагирование на инциденты инфраструктуры.

## Зона контроля клиентов {{ yandex-cloud }} {#customer-responsibilities}

* **ML-модели и их работа**. Использование ML-моделей для решения пользовательских задач.

* **Шифрование данных в состоянии покоя (at rest)**. Включение шифрования с собственными ключами [{{ kms-full-name }}](*kms_service_info) для критичных данных, контроль ротации ключей.

* **Шифрование данных в состоянии передачи (in transit)**. Использование только защищенных соединений, проверка сертификатов.

* **Управление ключами шифрования**. Создание и ротация собственных ключей, установка периода ротации, соответствующего политике информационной безопасности клиента.

* **Управление секретами**. Хранение токенов, API-ключей и секретов в [{{ lockbox-full-name }}](*lockbox_service_info), исключение секретов из кода и метаданных.

* **Управление доступом**. Назначение ролей по принципу минимальных привилегий, управление учетными записями, регулярный аудит прав доступа.

* **Данные клиента**. Классификация данных, разграничение доступа, защита конфиденциальной информации, соответствие нормативным требованиям.

* **Аудитные логи**. Включение [{{ at-full-name }}](*audit-trails_service_info) на уровне организации, анализ логов в [{{ yandex-siem-full-name }}](*siem_service_info), настройка мониторинга событий безопасности.

* **Сетевая безопасность**. Настройка [групп безопасности](../../vpc/concepts/security-groups.md), сегментация сети, использование [бастионных хостов](*bastion_host).

* **Защита от DDoS**. Защита критичных сервисов от DDoS-атак с помощью собственных средств или инструментов {{ yandex-cloud }}, например [{{ ddos-protection-full-name }}](*ddos_protection).

* **Антивирусная защита**. Развертывание антивирусной защиты на виртуальных машинах и в приложениях в облаке клиента.

* **Сканирование на наличие уязвимостей**. [Включение](../../container-registry/operations/scanning-docker-image.md) политики сканирования при загрузке, периодическое сканирование образов, выполняемое не реже одного раза в неделю для среды эксплуатации (production).

* **Разработка агентов и приложений**. Разработка логики [агентов]({{ link-docs-ai }}ai-studio/concepts/agents), настройка [рабочих процессов]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/workflow), тестирование промптов, интеграция в бизнес-процессы.

* **Дообучение моделей**. Подготовка [датасетов]({{ link-docs-ai }}ai-studio/concepts/resources/dataset), выбор параметров дообучения, контроль качества результатов, защита тренировочных данных.

* **Интеграция с внешними системами**. Настройка подключений к корпоративным системам, безопасность интеграций, управление внешними инструментами.

* **Мониторинг инфраструктуры**. Мониторинг прикладного уровня, логирование действий агентов, анализ использования ресурсов.

* **Резервное копирование**. Настройка резервного копирования приложений, пользовательских данных и конфигураций агентов.

* **Соответствие требованиям и сертификация**. Соблюдение отраслевых регуляторных требований, аудит использования данных, документирование процессов.

* **Защита API**. Безопасное хранение API-ключей, контроль использования квот, проверка корректности входных данных.

* **Защита промптов и выходных данных**. Фильтрация чувствительных данных в промптах, проверка корректности ответов моделей, контроль утечки информации через агентов.

* **Управление инцидентами**. Разработка плана реагирования на инциденты уровня приложений, уведомление о подозрительной активности.

{% include [responsibilities-support](../../_includes/overview/responsibilities-support.md) %}

[*kms_service_info]: {% include [kms-service-info-popup](../../_popups/kms/kms-service-info.md) %}

[*lockbox_service_info]: {% include [lockbox-service-info-popup](../../_popups/lockbox/lockbox-service-info.md) %}

[*iam_service_info]: {% include [iam-service-info-popup](../../_popups/iam/iam-service-info.md) %}

[*granularity_definition]: {% include [granularity-in-access-management-definition](../../_popups/granularity-in-access-management-definition.md) %}

[*audit-trails_service_info]: {% include [audit-trails-service-info-popup](../../_popups/audit-trails/audit-trails-service-info.md) %}

[*storage_service_info]: {% include [storage-service-info-popup](../../_popups/storage/storage-service-info.md) %}

[*logging_service_info]: {% include [logging-service-info-popup](../../_popups/logging/logging-service-info.md) %}

[*sws_service_info]: {% include [sws-service-info-popup](../../_popups/sws/sws-service-info.md) %}

[*search-api_service_info]: {% include [search-api-service-info-popup](../../_popups/search-api/search-api-service-info.md) %}

[*siem_service_info]: {% include [siem-service-info-popup](../../_popups/siem/siem-service-info.md) %}

[*bastion_host]: {% include [bastion-host-popup](../../_popups/bastion-host.md) %}

[*ddos_protection]: {% include [ddos-protection-info-popup](../../_popups/vpc/ddos-protection-info.md) %}
