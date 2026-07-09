Имя события | Описание
--- | ---
`batch_inference.CancelBatchInference` | Остановка работы модели в пакетном режиме
`batch_inference.DeleteBatchInference` | Удаление результата обработки в пакетном режиме
`batch_inference.StartBatchInference` | Запуск модели в пакетном режиме
`dedicated_instance.CreateDedicatedInstance` | Создание [выделенного инстанса]({{ link-docs-ai }}/ai-studio/concepts/generation/dedicated-instance)
`dedicated_instance.DeleteDedicatedInstance` | Удаление выделенного инстанса
`dedicated_instance.StartDedicatedInstance` | Запуск выделенного инстанса
`dedicated_instance.StopDedicatedInstance` | Остановка выделенного инстанса
`dedicated_instance.UpdateDedicatedInstance` | Изменение выделенного инстанса
`foundationmodels.UpdateDataLogging` | Изменение настроек логирования данных
`guardrails.BlockContentByClassifier` | Блокировка контента по классификатору
`guardrails.BlockContentByDictionary` | Блокировка контента по словарю
`guardrails.ChangeDefaultGuardrail` | Изменение правила модерации по умолчанию
`guardrails.CompleteContentCheck` | Завершение проверки контента
`guardrails.CreateDictionary` | Создание [словаря]({{ link-docs-ai }}/ai-studio/concepts/security/guardrails#dictionaries) фраз и регулярных выражений в [правиле модерации]({{ link-docs-ai }}/ai-studio/concepts/security/guardrails#rules)
`guardrails.CreateGuardrail` | Создание правила модерации
`guardrails.DeleteDictionary` | Удаление словаря фраз и регулярных выражений из правила модерации
`guardrails.DeleteGuardrail` | Удаление правила модерации
`guardrails.SetBinding` | Применение правила модерации для инстанса
`guardrails.UnsetBinding` | Отключение правила модерации от инстанса
`guardrails.UpdateDictionary` | Изменение словаря фраз и регулярных выражений в правиле модерации
`guardrails.UpdateDictionaryItems` | Изменение состава элементов словаря фраз и регулярных выражений в правиле модерации
`guardrails.UpdateGuardrail` | Изменение правила модерации
`mcp_hub.CreateMcpGateway` | Создание MCP-сервера
`mcp_hub.DeleteMcpGateway` | Удаление MCP-сервера
`mcp_hub.SetMcpGatewayAccessBindings` | Назначение прав доступа для MCP-сервера
`mcp_hub.UpdateMcpGateway` | Изменение MCP-сервера
`mcp_hub.UpdateMcpGatewayAccessBindings` | Изменение прав доступа для MCP-сервера
`responses.CancelResponse` | Отмена ответа
`responses.CreateResponse` | Создание ответа
`responses.DeleteResponse` | Удаление ответа
`responses.FileSearchToolSearch` | Поиск по файлам через инструмент поиска
`responses.GetResponse` | Получение ответа
`responses.McpToolApprovalRequest` | Запрос подтверждения вызова MCP-инструмента
`responses.McpToolApprovalResponse` | Ответ на запрос подтверждения вызова MCP-инструмента
`responses.McpToolCall` | Вызов MCP-инструмента
`responses.McpToolList` | Получение списка MCP-инструментов
`responses.WebSearchToolSearch` | Поиск через инструмент веб-поиска (Web Search)
`settings.SetFolderSettings` | Изменение настроек сервиса в каталоге
`tuning.CancelTuning` | Остановка [дообучения]({{ link-docs-ai }}/ai-studio/concepts/tuning/index) модели
`tuning.StartTuning` | Запуск дообучения модели