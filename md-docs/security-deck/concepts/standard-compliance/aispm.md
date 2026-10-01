[Документация Yandex Cloud](../../../index.md) > [Yandex Security Deck](../../index.md) > [Концепции](../index.md) > [Интерфейс соответствия требованиям](index.md) > Стандарт безопасности ИИ-систем в Yandex Cloud

# Стандарт безопасности ИИ-систем в Yandex Cloud

Стандарт устанавливает требования и рекомендации по безопасности для систем искусственного интеллекта, развернутых полностью или частично в Yandex Cloud. Он предназначен для архитекторов, специалистов по информационной безопасности, разработчиков, ML- и DevSecOps-инженеров, владельцев сервисов, SOC и сотрудников, которые проверяют соответствие.

Приведенный набор требований содержит автоматизированные правила контроля безопасности ИИ-систем в соответствии с рекомендациями стандарта безопасности ИИ-систем в Yandex Cloud:

#|
|| Идентификатор требования | Требование [стандарта безопасности](../../../security/standard-ai/all.md) | Идентификатор проверки в [модуле CSPM](../cspm.md) ||
|| `AI-CORE5` | [Системные инструкции и политики изменяются только доверенным путем](../../../security/standard-ai/all.md#system-prompts-policies-changed-trusted-path) | [cspm.ai.tool-secrets](../../rules-reference/cspm.md#tool-secrets) ||
|| `AI-MCP1` | [Доступ к MCP Gateway и целевому сервису разделен](../../../security/standard-ai/all.md#mcp-gateway-target-service-access-separated)
|
[cspm.ai.public-mcp-tools](../../rules-reference/cspm.md#public-mcp-tools)
[cspm.ai.public-mcp](../../rules-reference/cspm.md#public-mcp)
||
|| `AI-TRAIN1` | [Разработка, обучение и продуктивное выполнение разделены](../../../security/standard-ai/all.md#dev-training-prod-execution-separated) | [cspm.ai.datasphere-sa-privileges](../../rules-reference/cspm.md#datasphere-sa-privileges) ||
|| `AI-INFRA-ISOL3` | [Исполнение кода, команд и динамических запросов ограничено](../../../security/standard-ai/all.md#code-commands-dynamic-queries-restricted) | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| `AI-IAM4` | [Вызов Yandex AI Studio использует документированный способ аутентификации](../../../security/standard-ai/all.md#ai-studio-call-uses-documented-auth)
|
[cspm.ai.api-key-scopes](../../rules-reference/cspm.md#api-key-scopes)
[cspm.ai.api-key-rotation](../../rules-reference/cspm.md#api-key-rotation)
||
|| `AI-IAM5` | [Эффективные права пересматриваются по расписанию и после изменений](../../../security/standard-ai/all.md#effective-rights-reviewed-on-schedule-and-change) | [cspm.ai.system-groups](../../rules-reference/cspm.md#system-groups) ||
|| `AI-IAM-COMPROMISE1` | [Полномочия сессии определяются доверенной делегацией](../../../security/standard-ai/all.md#session-authority-defined-by-trusted-delegation) | [cspm.ai.public-mcp-tools](../../rules-reference/cspm.md#public-mcp-tools) ||
|| `AI-IAM-LEASTPRIV1` | [Рабочие идентичности имеют минимальные эффективные права](../../../security/standard-ai/all.md#workload-identities-minimal-effective-rights)
|
[cspm.ai.datasphere-sa-privileges](../../rules-reference/cspm.md#datasphere-sa-privileges)
[cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles)
[cspm.ai.public-mcp](../../rules-reference/cspm.md#public-mcp)
||
|| `AI-IAM-LEASTPRIV3` | [Каждый инструмент имеет отдельную минимальную идентичность](../../../security/standard-ai/all.md#each-tool-has-separate-minimal-identity)
|
[cspm.ai.mcp-sa-duplicate](../../rules-reference/cspm.md#mcp-sa-duplicate)
[cspm.ai.mcp-sa-privileges](../../rules-reference/cspm.md#mcp-sa-privileges)
||
|| `AI-SECRET1` | [Секрет имеет владельца и управляемый жизненный цикл](../../../security/standard-ai/all.md#secret-has-owner-managed-lifecycle)
|
[cspm.ai.tool-secrets](../../rules-reference/cspm.md#tool-secrets)
[cspm.ai.api-key-rotation](../../rules-reference/cspm.md#api-key-rotation)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
[cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
||
|| `AI-CRYPT1` | [Шифрование выбирается по возможностям конкретного сервиса](../../../security/standard-ai/all.md#encryption-chosen-by-service-capabilities)
|
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
||
|| `AI-NET2` | [Межкомпонентные соединения ограничены фактической топологией](../../../security/standard-ai/all.md#intercomponent-connections-limited-by-topology)
|
[cspm.access.public-access](../../rules-reference/cspm.md#public-access)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#k8s-network-firewall-scope)
[cspm.k8s.api-security](../../rules-reference/cspm.md#api-security)
[cspm.network.check-outgoing-internet-connection](../../rules-reference/cspm.md#check-outgoing-internet-connection)
[cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall)
||
|| `AI-NET5` | [Хранилища моделей и данных не имеют неучтенного публичного доступа](../../../security/standard-ai/all.md#model-data-stores-no-unaccounted-public-access)
|
[cspm.access.public-access](../../rules-reference/cspm.md#public-access)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy)
[cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access)
||
|| `AI-NET7` | [Публичный HTTP(S)-периметр имеет явную схему защиты](../../../security/standard-ai/all.md#public-http-perimeter-explicit-protection) | [cspm.ai.public-mcp](../../rules-reference/cspm.md#public-mcp) ||
|#