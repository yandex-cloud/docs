### API-ключи для сервисов AI Studio должны иметь ограниченные области действия {#api-key-scopes}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.api-key-scopes ||
|#

#### Описание

**Как работает правило**: проверяются API-ключи с заданными областями действия в AI Studio, выводится список ключей с обширным областями действия.

Область действия API-ключа должна соответствовать минимально необходимому действию. Если при создании API-ключа через CLI/API/Terraform вы не указываете область действия, применяется широкий набор областей [по умолчанию](https://yandex.cloud/ru/docs/iam/concepts/authorization/api-key#scoped-api-keys). Такой ключ часто получает доступ не только к операциям в ИИ-сервисах, но и к Monitoring, Search API, Serverless Functions/Containers invoke.

Область действия API-ключа нельзя изменить после создания; решение — перевыпуск ключа с минимальным набором областей действия и удаление старого ключа после миграции потребителей.

#### Инструкции и решения по выполнению

1. Получите API-ключи сервисного аккаунта:

   ```bash
   yc iam api-key list --service-account-id <sa-id> --format json 
   ```

1. Для каждого ключа получите детали:

   ```bash 
   yc iam api-key get --id <key-id> --format json 
   ```

   Список областей действия API-ключа, созданного через CLI/API/Terraform без указания областей: `yc.ai.imageGeneration.execute, yc.ai.languageModels.execute, yc.ai.speechkitStt.execute, yc.ai.speechkitTts.execute, yc.ai.translate.execute, yc.ai.vision.execute, yc.monitoring.manage, yc.search-api.execute, yc.serverless.containers.invoke, yc.serverless.functions.invoke`.

   Если полученная область действия ключа совпадает со списком по умолчанию или оказалась шире минимально необходимого профиля приложения, это нарушение.

   Минимальные рекомендуемые профили: 
   * Text generation only: yc.ai.languageModels.execute 
   * Image generation only: yc.ai.imageGeneration.execute 
   * Speech-to-text only: yc.ai.speechkitStt.execute 
   * Text-to-speech only: yc.ai.speechkitTts.execute 
   * Translate only: yc.ai.translate.execute 
   * Vision/OCR only: yc.ai.vision.execute 
   * MCP invoke only: yc.serverless.mcpGateways.invoke 
   * Workflow execution only: yc.serverless.workflows.execute

   Дополнительные доступные области действия, которые не должны появляться без явной необходимости: `yc.monitoring.manage, yc.monitoring.read, yc.search-api.execute, yc.serverless.functions.invoke, yc.serverless.containers.invoke, yc.serverless.workflows.execute, yc.serverless.mcpGateways.invoke, yc.logging.write, yc.datasphere.community-projects.manageResource, yc.speech-sense.use` и другие области действия из [актуального справочника](https://yandex.cloud/ru/docs/iam/concepts/authorization/api-key#scoped-api-keys) API-ключей.

1. Если вы создали ключ через интерфейс AI Studio, не полагайтесь на источник создания. Всегда проверяйте фактические области действия ключа. 
1. Перевыпустите ключ с минимальным набором областей:

   ```bash
   yc iam api-key create --service-account-id <sa-id> --scopes <scope1>,<scope2> --expires-at <iso8601> 
   ``` 

1. Обновите потребителей, затем удалите старый ключ:

   ```bash 
   yc iam api-key delete --id <old-key-id> 
   ```

   В Terraform используйте актуальный атрибут `scopes = [...]`. Не используйте `lifecycle.ignore_changes` для областей, если цель контроля — обнаруживать и исправлять drift.