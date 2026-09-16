{% include [content](iam-network-crypto-secrets-audit/iam-network-crypto-secrets-audit-intro-body.md) %}

## Права и доступ {#rights-access}

### Межкомпонентные соединения ограничены фактической топологией {#intercomponent-connections-limited-by-topology}

{% include [content](iam-network-crypto-secrets-audit/intercomponent-connections-limited-by-topology-body.md) %}

### Рабочие идентичности имеют минимальные эффективные права {#workload-identities-minimal-effective-rights}

{% include [content](iam-network-crypto-secrets-audit/workload-identities-minimal-effective-rights-body.md) %}

### Вызов {{ ai-studio-name }} использует документированный способ аутентификации {#ai-studio-call-uses-documented-auth}

{% include [content](iam-network-crypto-secrets-audit/ai-studio-call-uses-documented-auth-body.md) %}

### Эффективные права пересматриваются по расписанию и после изменений {#effective-rights-reviewed-on-schedule-and-change}

{% include [content](iam-network-crypto-secrets-audit/effective-rights-reviewed-on-schedule-and-change-body.md) %}

### Учетные записи привилегированных пользователей используют MFA {#privileged-users-use-mfa}

{% include [content](iam-network-crypto-secrets-audit/privileged-users-use-mfa-body.md) %}

### Обходные административные каналы среды исполнения отключены по умолчанию {#runtime-administrative-bypass-channels-disabled}

{% include [content](iam-network-crypto-secrets-audit/runtime-administrative-bypass-channels-disabled-body.md) %}

## Хранилища и криптографическая защита {#storage-crypto}

### Хранилища моделей и данных не имеют неучтенного публичного доступа {#model-data-stores-no-unaccounted-public-access}

{% include [content](iam-network-crypto-secrets-audit/model-data-stores-no-unaccounted-public-access-body.md) %}

### Шифрование выбирается по возможностям конкретного сервиса {#encryption-chosen-by-service-capabilities}

{% include [content](iam-network-crypto-secrets-audit/encryption-chosen-by-service-capabilities-body.md) %}

## Секреты {#secrets}

### Секрет имеет владельца и управляемый жизненный цикл {#secret-has-owner-managed-lifecycle}

{% include [content](iam-network-crypto-secrets-audit/secret-has-owner-managed-lifecycle-body.md) %}

## Аудит и содержимое журналов {#audit-logs}

### Для каждой существенной операции указан источник события {#material-operation-has-event-source}

{% include [content](iam-network-crypto-secrets-audit/material-operation-has-event-source-body.md) %}

### Журналы не собирают чувствительное содержимое без цели {#logs-no-sensitive-content-without-purpose}

{% include [content](iam-network-crypto-secrets-audit/logs-no-sensitive-content-without-purpose-body.md) %}
