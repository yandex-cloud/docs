### Не выдавайте привилегированные роли в ИИ-сервисах системным группам и группам с большим количеством субъектов {#system-groups}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.system-groups ||
|#

#### Описание

**Как работает правило**: проверяется наличие [системных групп](https://yandex.cloud/ru/docs/iam/concepts/access-control/system-group) в организации.

Привилегированные AI- и MCP-роли должны выдаваться узким группам только при условии, что они действительно нужны для выполнения конкретной задачи. Особенно опасны `ai.admin`, `ai.editor`, роли для управления моделями, [датасетами](https://aistudio.yandex.ru/docs/ru/ai-studio/security/#datasets-roles), AI Assistant, MCP Gateway и [роли](https://aistudio.yandex.ru/docs/ru/ai-studio/security/#guardrails-roles) для модерации ответов моделей.

Публичные и системные группы для таких ролей недопустимы. Для ролей чтения `viewer` и `auditor` и ролей `*user`риск ниже, но широкая выдача все равно требует пересмотра.

#### Инструкции и решения по выполнению

1. Получите привязки доступа организации: 

   ```bash
   yc organization-manager organization list-access-bindings --id <org-id> --format json 
   ``` 

1. Также проверьте привязки на уровне каталога и облака, если AI- и MCP-роли назначаются ниже уровня организации. 
1. Роли критичного и высокого уровня риска для широких групп: `ai.admin, ai.editor, ai.models.admin, ai.models.editor, ai.datasets.admin, ai.datasets.editor, ai.guardrails.admin, ai.guardrails.editor, ai.assistants.admin, ai.assistants.editor, serverless.mcpGateways.admin, serverless.mcpGateways.editor`. 
1. Роли среднего риска и потенциально опасные роли для широких групп: `ai.viewer, ai.auditor, ai.models.user, ai.models.viewer, ai.datasets.user, ai.datasets.viewer, ai.guardrails.user, ai.guardrails.viewer, ai.assistants.user, ai.assistants.viewer, ai.languageModels.user, ai.imageGeneration.user, ai.translate.user, ai.vision.user, ai.speechkit-stt.user, ai.speechkit-tts.user, ai.playground.user, serverless.mcpGateways.invoker`. 
1. Перед внедрением в конкретном тенанте сверяйте имена ролей с актуальным [справочником ролей](https://yandex.cloud/ru/docs/iam/roles-reference). Если роль отсутствует в тенанте, сканер не должен прекращать задание; он должен выдавать сообщение `role not found / not applicable`. 
1. Для групп получите состав: 

   ```bash
   yc organization-manager group list-members --group-id <id> --format json 
   ``` 

1. Публичные и системные группы `allUsers, allAuthenticatedUsers` всегда нарушение для привилегированных ролей. 
1. Порог широкой группы — параметр стандарта: 
   * по умолчанию: больше 50 уникальных идентичностей, привязанных к человеку (human subjects); 
   * для ролей высокого риска `ai.admin, ai.editor, ai.models.admin, ai.models.editor, serverless.mcpGateways.admin, serverless.mcpGateways.editor` — больше 10 идентичностей, привязанных к человеку (human subjects).

   **Решение**: создайте узкую группу с владельцем, процессом одобрения выдачи прав и регулярным пересмотром доступов, перенесите роль на эту группу, удалите назначение прав с широкой группы или публичной группы.
