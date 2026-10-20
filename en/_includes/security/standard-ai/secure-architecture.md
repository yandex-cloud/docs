{% include [content](secure-architecture/secure-architecture-intro-body.md) %}

## Architecture and changes {#architecture-changes}

### Architecture and risks are documented prior to release {#architecture-risks-fixed-before-release}

{% include [content](secure-architecture/architecture-risks-fixed-before-release-body.md) %}

## Input, context, and output {#input-context-output}

### Untrusted input is verified prior to model ingestion {#untrusted-input-validated-before-model-use}

{% include [content](secure-architecture/untrusted-input-validated-before-model-use-body.md) %}

### Guardrails have defined categories and fault-tolerant behavior {#moderation-rules-defined-categories-failover}

{% include [content](secure-architecture/moderation-rules-defined-categories-failover-body.md) %}

### Model output is verified prior to rendering and execution {#model-output-validated-before-render-exec}

{% include [content](secure-architecture/model-output-validated-before-render-exec-body.md) %}

### System guidelines and policies must only be modified via a trusted path {#system-prompts-policies-changed-trusted-path}

{% include [content](secure-architecture/system-prompts-policies-changed-trusted-path-body.md) %}

### External or retrieved context gains no implicit trust {#external-retrieved-context-no-implicit-trust}

{% include [content](secure-architecture/external-retrieved-context-no-implicit-trust-body.md) %}

## External connections and public perimeter {#external-connections}

### External model API calls are routed through a managed boundary {#external-model-api-calls-managed-boundary}

{% include [content](secure-architecture/external-model-api-calls-managed-boundary-body.md) %}

### Public HTTP(S) perimeter has an explicit protection scheme {#public-http-perimeter-explicit-protection}

{% include [content](secure-architecture/public-http-perimeter-explicit-protection-body.md) %}
