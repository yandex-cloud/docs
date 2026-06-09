# API-ключ


{% note info %}

Создание API-ключей сервисных аккаунтов может быть запрещено [политиками авторизации](../access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

_API-ключ_ — секретный ключ, используемый только для упрощенной аутентификации [сервисных аккаунтов](../users/service-accounts.md) в API {{ yandex-cloud }}.

Используйте API-ключи, если у вас нет возможности автоматически запрашивать [IAM-токен](iam-token.md).

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/authentication/manage-api-keys.md#delete-api-key) и [создайте новый](../../operations/authentication/manage-api-keys.md#create-api-key).

{% endnote %}

Пользователь самостоятельно хранит API-ключ. {{ yandex-cloud }} предоставляет доступ к API-ключу только в процессе его создания. Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

Чтобы обеспечивать безопасность и контроль над доступом к ресурсам, отслеживать случаи несанкционированного использования ключей, а также удалять неиспользуемые ключи без риска нарушить работу сервисов {{ yandex-cloud }}, вы можете отслеживать даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления]({{ link-console-main }}), а также в поле `last_used_at` при вызове методов управления ключами доступа через API.

## API-ключи с ограничениями области и срока действия {#scoped-api-keys}

При [создании](../../operations/authentication/manage-api-keys.md#create-api-key) API-ключа вы можете задать одну или несколько _областей действия_.

Область действия — совокупность разрешенных сервисному аккаунту действий с ресурсами сервиса. В сервисе может быть больше одной области действия. API-ключ с заданными областями действия нельзя использовать в других сервисах или областях действия.

Область действия ограничивает применение API-ключей в дополнение к собственным правам доступа сервисного аккаунта. 

Дополнительно при создании API-ключа вы можете ограничить срок его действия. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей.

Доступные области действия:


* `yc.ai.foundationModels.execute` — для отправки запросов к [API {{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/concepts/api.html#yc), [API {{ speechkit-name }}]({{ link-docs-ai }}speechkit/concepts/api), [API {{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/api) и [API {{ vision-name }}]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.ai.imageGeneration.execute` — для отправки запросов к моделям генерации изображений в сервисе {{ ai-studio-full-name }} через [Image Generation API]({{ link-docs-ai }}ai-studio/image-generation/api-ref/index).
* `yc.ai.languageModels.execute` — для отправки запросов к моделям генерации текста в сервисе {{ ai-studio-full-name }} через [Text Generation API]({{ link-docs-ai }}ai-studio/text-generation/api-ref/index).
* `yc.ai.speechkitStt.execute` — для [распознавания речи]({{ link-docs-ai }}speechkit/stt/index) через [API {{ speechkit-name }}]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.speechkitTts.execute` — для [синтеза речи]({{ link-docs-ai }}speechkit/tts/index) через [API {{ speechkit-name }}]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.translate.execute` — для перевода текста через [API {{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/api).
* `yc.ai.vision.execute` — для оптического распознавания текста с помощью [{{ vision-name }} API]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.datasphere.community-projects.manageResource` — для управления ресурсами [проектов](../../../datasphere/concepts/project.md) через [API {{ ml-platform-full-name }}](../../../datasphere/api-ref/overview.md).
* `yc.logging.write` — для записи логов в [лог-группы](../../../logging/concepts/log-group.md) через [API {{ cloud-logging-full-name }}](../../../logging/api-ref/authentication.md).
* `yc.managed-ytsaurus.cluster.use` — для работы с [кластерами](../../../managed-ytsaurus/concepts/component-types.md) через [API {{ myt-full-name }}](../../../managed-ytsaurus/api-ref/authentication.md).
* `yc.monitoring.manage` — для просмотра и записи данных в {{ monitoring-full-name }} через [API {{ monitoring-name }}](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read` — для просмотра данных в {{ monitoring-full-name }} через [API {{ monitoring-name }}](../../../monitoring/api-ref/index.md).
* `yc.monium.logs.write` — для записи [логов](../../../monium/logs/quickstart.md) в [{{ monium-name }}](../../../monium/index.md).
* `yc.monium.metrics.write` — для записи [метрик](../../../monium/metrics/overview.md) в [{{ monium-name }}](../../../monium/index.md).
* `yc.monium.traces.write` — для записи [распределенных трассировок](../../../monium/traces/index.md) в [{{ monium-name }}](../../../monium/index.md).
* `yc.monium.telemetry.write` — для записи любого вида телеметрии по протоколу [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol) в [{{ monium-name }}](../../../monium/index.md).
* `yc.postbox.send` — для отправки писем через API [{{ postbox-name }}](../../../postbox/index.md).
* `yc.cloud-registry.artifacts.manage` — для просмотра, публикации и удаления артефактов из [{{ cloud-registry-full-name }}](../../../cloud-registry/index.md).
* `yc.cloud-registry.artifacts.pull` — для просмотра и скачивания артефактов из [{{ cloud-registry-full-name }}](../../../cloud-registry/index.md).
* `yc.cloud-registry.artifacts.push` — для просмотра и публикации артефактов в [{{ cloud-registry-full-name }}](../../../cloud-registry/index.md).
* `yc.search-api.execute` — для отправки поисковых запросов к [{{ search-api-name }}]({{ link-docs-ai }}search-api/api-ref/index).
* `yc.serverless.containers.invoke` — для вызова контейнеров через [API {{ serverless-containers-short-name }}](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke` — для вызова функций через [API {{ sf-short-name }}](../../../functions/functions/api-ref/index.md).
* `yc.serverless.mcpGateways.invoke` — для вызова [MCP-серверов](../../../glossary/mcp.md) через [{{ ai-studio-full-name }} {{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index).
* `yc.serverless.workflows.execute` — для запуска [рабочих процессов](../../../serverless-integrations/concepts/workflows/execution.md) и получения информации о запуске через [API {{ sw-name }}](../../../serverless-integrations/concepts/index.md#workflows).
* `yc.speech-sense.use` — для работы с [ресурсами]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy) {{ speechsense-name }} через [API {{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/api-ref/authentication).
* `yc.ydb.tables.manage` — для работы с {{ ydb-short-name }} в режиме совместимости с {{ PG }}.
* `yc.ydb.topics.manage` — для работы с [Kafka API](../../../data-streams/kafkaapi/auth.md) в {{ yds-full-name }}.

При создании API-ключа в [консоли управления]({{ link-console-main }}) область действия является обязательным параметром. При создании API-ключа с помощью [{{ yandex-cloud }} CLI](../../../cli/cli-ref/iam/cli-ref/api-key/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_api_key) или [API](../../api-ref/ApiKey/create.md) задавать область действия необязательно. Если область действия создаваемого API ключа не задана, ему будут по умолчанию назначены следующие области действия:

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

При [просмотре списка](../../operations/authentication/manage-api-keys.md#list-api-keys) API-ключей с помощью {{ yandex-cloud }} CLI отображается поле `MASKED KEY`. Оно содержит последние шесть символов секретной части ключа. Это позволяет сопоставить API-ключ с его идентификатором. Демонстрация шести символов безопасна, она не раскрывает ключ полностью.

Поле `MASKED KEY` полезно для быстрой идентификации ключа. Например, при проверке наличия ключа в базах утечек или при сопоставлении ключей в других системах с ключами в {{ yandex-cloud }}.

## Использование API-ключа {#use}

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передавайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

API-ключи в качестве способа аутентификации поддерживаются в следующих сервисах:

* [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/api-ref/authentication)
* [{{ sf-full-name }}](../../../functions/operations/function/auth.md)
* [{{ ml-platform-full-name }}](../../../datasphere/api-ref/authentication.md)
* [{{ monitoring-full-name }}](../../../monitoring/api-ref/authentication.md)
* [{{ postbox-full-name }}](../../../postbox/api-ref/authentication.md)
* [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/api-ref/authentication)
* [{{ serverless-containers-full-name }}](../../../serverless-containers/index.md)
* [{{ si-full-name }}](../../../serverless-integrations/index.md) — в рамках [{{ sw-full-name }}](../../../serverless-integrations/concepts/workflows/workflow.md).
* [{{ speechkit-full-name }}]({{ link-docs-ai }}{{ speechkit-slug }}/concepts/auth)
* [{{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/api-ref/authentication)
* [{{ translate-full-name }}]({{ link-docs-ai }}translate/api-ref/authentication)
* [{{ vision-full-name }}]({{ link-docs-ai }}vision/api-ref/authentication)
* {{ yds-full-name }} — [Kafka API](../../../data-streams/kafkaapi/index.md)
* {{ ydb-full-name }} — только в режиме совместимости с {{ PG }}. Для других режимов работы используйте соответствующий [способ аутентификации](../../../ydb/operations/connection.md#auth).
* [{{ metadata-hub-full-name }}](../../../metadata-hub/concepts/index.md) — в рамках [{{ schema-registry-full-name }}](../../../metadata-hub/operations/connect-to-namespace.md).
* [{{ cloud-registry-full-name }}](../../../cloud-registry/index.md)

## Примеры использования {#examples}

* [{#T}](../../../tutorials/ml-ai/speechsense/auto-upload.md)

#### См. также {#see-also}

* [{#T}](../../operations/authentication/manage-api-keys.md#create-api-key)
* [{#T}](iam-token.md)
* [{#T}](index.md)