# API-ключ


{% note info %}

Создание API-ключей сервисных аккаунтов может быть запрещено [политиками авторизации](../access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

_API-ключ_ — секретный ключ, используемый только для упрощенной аутентификации [сервисных аккаунтов](../users/service-accounts.md) в API Yandex Cloud.

Используйте API-ключи, если у вас нет возможности автоматически запрашивать [IAM-токен](iam-token.md).

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/authentication/manage-api-keys.md#delete-api-key) и [создайте новый](../../operations/authentication/manage-api-keys.md#create-api-key).

{% endnote %}

Пользователь самостоятельно хранит API-ключ. Yandex Cloud предоставляет доступ к API-ключу только в процессе его создания. Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

Чтобы обеспечивать безопасность и контроль над доступом к ресурсам, отслеживать случаи несанкционированного использования ключей, а также удалять неиспользуемые ключи без риска нарушить работу сервисов Yandex Cloud, вы можете отслеживать даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления](https://console.yandex.cloud), а также в поле `last_used_at` при вызове методов управления ключами доступа через API.

## API-ключи с ограничениями области и срока действия {#scoped-api-keys}

При [создании](../../operations/authentication/manage-api-keys.md#create-api-key) API-ключа вы можете задать одну или несколько _областей действия_.

Область действия — совокупность разрешенных сервисному аккаунту действий с ресурсами сервиса. В сервисе может быть больше одной области действия. API-ключ с заданными областями действия нельзя использовать в других сервисах или областях действия.

Область действия ограничивает применение API-ключей в дополнение к собственным правам доступа сервисного аккаунта. 

Дополнительно при создании API-ключа вы можете ограничить срок его действия. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей.

Доступные области действия:


* `yc.ai.foundationModels.execute` — для отправки запросов к [API AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/api.html#yc), [API SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/api), [API Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/concepts/api) и [API Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/ocr/api-ref/index).
* `yc.ai.imageGeneration.execute` — для отправки запросов к моделям генерации изображений в сервисе Yandex AI Studio через [Image Generation API](https://aistudio.yandex.ru/docs/ru/ai-studio/image-generation/api-ref/index).
* `yc.ai.languageModels.execute` — для отправки запросов к моделям генерации текста в сервисе Yandex AI Studio через [Text Generation API](https://aistudio.yandex.ru/docs/ru/ai-studio/text-generation/api-ref/index).
* `yc.ai.speechkitStt.execute` — для [распознавания речи](https://aistudio.yandex.ru/docs/ru/speechkit/stt/index) через [API SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/api).
* `yc.ai.speechkitTts.execute` — для [синтеза речи](https://aistudio.yandex.ru/docs/ru/speechkit/tts/index) через [API SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/api).
* `yc.ai.translate.execute` — для перевода текста через [API Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/concepts/api).
* `yc.ai.vision.execute` — для оптического распознавания текста с помощью [Vision OCR API](https://aistudio.yandex.ru/docs/ru/vision/ocr/api-ref/index).
* `yc.datasphere.community-projects.manageResource` — для управления ресурсами [проектов](../../../datasphere/concepts/project.md) через [API Yandex DataSphere](../../../datasphere/api-ref/overview.md).
* `yc.logging.write` — для записи логов в [лог-группы](../../../logging/concepts/log-group.md) через [API Yandex Cloud Logging](../../../logging/api-ref/authentication.md).
* `yc.managed-ytsaurus.cluster.use` — для работы с [кластерами](../../../managed-ytsaurus/concepts/component-types.md) через [API Yandex Managed Service for YTsaurus](../../../managed-ytsaurus/api-ref/authentication.md).
* `yc.monitoring.manage` — для просмотра и записи данных в Yandex Monitoring через [API Monitoring](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read` — для просмотра данных в Yandex Monitoring через [API Monitoring](../../../monitoring/api-ref/index.md).
* `yc.monium.logs.write` — для записи [логов](../../../monium/logs/quickstart.md) в [Monium](../../../monium/index.md).
* `yc.monium.metrics.write` — для записи [метрик](../../../monium/metrics/overview.md) в [Monium](../../../monium/index.md).
* `yc.monium.traces.write` — для записи [распределенных трассировок](../../../monium/traces/index.md) в [Monium](../../../monium/index.md).
* `yc.monium.telemetry.write` — для записи любого вида телеметрии по протоколу [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol) в [Monium](../../../monium/index.md).
* `yc.postbox.send` — для отправки писем через API [Yandex Cloud Postbox](../../../postbox/index.md).
* `yc.cloud-registry.artifacts.manage` — для просмотра, публикации и удаления артефактов из [Yandex Cloud Registry](../../../cloud-registry/index.md).
* `yc.cloud-registry.artifacts.pull` — для просмотра и скачивания артефактов из [Yandex Cloud Registry](../../../cloud-registry/index.md).
* `yc.cloud-registry.artifacts.push` — для просмотра и публикации артефактов в [Yandex Cloud Registry](../../../cloud-registry/index.md).
* `yc.search-api.execute` — для отправки поисковых запросов к [Yandex Search API](https://aistudio.yandex.ru/docs/ru/search-api/api-ref/index).
* `yc.serverless.containers.invoke` — для вызова контейнеров через [API Serverless Containers](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke` — для вызова функций через [API Cloud Functions](../../../functions/functions/api-ref/index.md).
* `yc.serverless.mcpGateways.invoke` — для вызова [MCP-серверов](../../../glossary/mcp.md) через [Yandex AI Studio MCP Hub](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/mcp-hub/index).
* `yc.serverless.workflows.execute` — для запуска [рабочих процессов](../../../serverless-integrations/concepts/workflows/execution.md) и получения информации о запуске через [API Workflows](../../../serverless-integrations/concepts/index.md#workflows).
* `yc.speech-sense.use` — для работы с [ресурсами](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/resources-hierarchy) SpeechSense через [API Yandex SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/api-ref/authentication).
* `yc.ydb.tables.manage` — для работы с YDB в режиме совместимости с PostgreSQL.
* `yc.ydb.topics.manage` — для работы с [Kafka API](../../../data-streams/kafkaapi/auth.md) в Yandex Data Streams.

При создании API-ключа в [консоли управления](https://console.yandex.cloud) область действия является обязательным параметром. При создании API-ключа с помощью [Yandex Cloud CLI](../../../cli/cli-ref/iam/cli-ref/api-key/create.md), [Terraform](../../../terraform/resources/iam_service_account_api_key.md) или [API](../../api-ref/ApiKey/create.md) задавать область действия необязательно. Если область действия создаваемого API ключа не задана, ему будут по умолчанию назначены следующие области действия:

* `yc.ai.imageGeneration.execute`;
* `yc.ai.languageModels.execute`;
* `yc.ai.speechkitStt.execute`;
* `yc.ai.speechkitTts.execute`;
* `yc.ai.translate.execute`;
* `yc.ai.vision.execute`;
* `yc.monitoring.manage`;
* `yc.search-api.execute`;
* `yc.serverless.containers.invoke`;
* `yc.serverless.functions.invoke`.

## Идентификация API-ключа {#identify-key}

При [просмотре списка](../../operations/authentication/manage-api-keys.md#list-api-keys) API-ключей с помощью Yandex Cloud CLI отображается поле `MASKED KEY`. Оно содержит последние шесть символов секретной части ключа. Это позволяет сопоставить API-ключ с его идентификатором. Демонстрация шести символов безопасна, она не раскрывает ключ полностью.

Поле `MASKED KEY` полезно для быстрой идентификации ключа. Например, при проверке наличия ключа в базах утечек или при сопоставлении ключей в других системах с ключами в Yandex Cloud.

## Использование API-ключа {#use}

Полученный API-ключ указывайте при обращении к ресурсам Yandex Cloud через API. Передавайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

API-ключи в качестве способа аутентификации поддерживаются в следующих сервисах:

* [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/api-ref/authentication)
* [Yandex Cloud Functions](../../../functions/operations/function/auth.md)
* [Yandex DataSphere](../../../datasphere/api-ref/authentication.md)
* [Yandex Monitoring](../../../monitoring/api-ref/authentication.md)
* [Yandex Cloud Postbox](../../../postbox/api-ref/authentication.md)
* [Yandex Search API](https://aistudio.yandex.ru/docs/ru/search-api/api-ref/authentication)
* [Yandex Serverless Containers](../../../serverless-containers/index.md)
* [Yandex Serverless Integrations](../../../serverless-integrations/index.md) — в рамках [Yandex Workflows](../../../serverless-integrations/concepts/workflows/workflow.md).
* [Yandex SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/auth)
* [Yandex SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/api-ref/authentication)
* [Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/api-ref/authentication)
* [Yandex Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/api-ref/authentication)
* Yandex Data Streams — [Kafka API](../../../data-streams/kafkaapi/index.md)
* Yandex Managed Service for YDB — только в режиме совместимости с PostgreSQL. Для других режимов работы используйте соответствующий [способ аутентификации](../../../ydb/operations/connection.md#auth).
* [Yandex MetaData Hub](../../../metadata-hub/concepts/index.md) — в рамках [Yandex Schema Registry](../../../metadata-hub/operations/connect-to-namespace.md).
* [Yandex Cloud Registry](../../../cloud-registry/index.md)

## Примеры использования {#examples}

* [Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows](../../../tutorials/ml-ai/speechsense/auto-upload.md)

#### См. также {#see-also}

* [Создать API-ключ](../../operations/authentication/manage-api-keys.md#create-api-key)
* [IAM-токен](iam-token.md)
* [Как выбрать подходящий способ аутентификации в Yandex Cloud](index.md)