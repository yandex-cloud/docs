{% include [content](secure-architecture/secure-architecture-intro-body.md) %}

## Архитектура и изменения {#architecture-changes}

### Архитектура и риски зафиксированы до выпуска {#architecture-risks-fixed-before-release}

{% include [content](secure-architecture/architecture-risks-fixed-before-release-body.md) %}

## Вход, контекст и вывод {#input-context-output}

### Недоверенный ввод проверяется до использования моделью {#untrusted-input-validated-before-model-use}

{% include [content](secure-architecture/untrusted-input-validated-before-model-use-body.md) %}

### Правила модерации имеют определенные категории и отказоустойчивое поведение {#moderation-rules-defined-categories-failover}

{% include [content](secure-architecture/moderation-rules-defined-categories-failover-body.md) %}

### Вывод модели проверяется до рендеринга и исполнения {#model-output-validated-before-render-exec}

{% include [content](secure-architecture/model-output-validated-before-render-exec-body.md) %}

### Системные инструкции и политики изменяются только доверенным путем {#system-prompts-policies-changed-trusted-path}

{% include [content](secure-architecture/system-prompts-policies-changed-trusted-path-body.md) %}

### Внешний и найденный контекст не получает доверия автоматически {#external-retrieved-context-no-implicit-trust}

{% include [content](secure-architecture/external-retrieved-context-no-implicit-trust-body.md) %}

## Внешние связи и публичный периметр {#external-connections}

### Вызовы внешнего модельного API проходят через управляемую границу {#external-model-api-calls-managed-boundary}

{% include [content](secure-architecture/external-model-api-calls-managed-boundary-body.md) %}

### Публичный HTTP(S)-периметр имеет явную схему защиты {#public-http-perimeter-explicit-protection}

{% include [content](secure-architecture/public-http-perimeter-explicit-protection-body.md) %}
