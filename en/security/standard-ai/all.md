---
title: Security standard for implementing and operating AI systems in {{ yandex-cloud }}, version {{ security-standard-ai-current-version }}
description: This document contains all sections of the security standard for artificial intelligence systems deployed, fully or partially, within {{ yandex-cloud }}, and assists in selecting information security measures to apply when developing and operating AI systems.
---

# Security standard for implementing and operating AI systems in {{ yandex-cloud }}, version {{ security-standard-ai-current-version }}

<!-- The full-version headings are set here; the text blocks are shared with individual pages. If you change the section structure, update both tables of contents. -->

## Introduction {#intro}

### Purpose and scope {#scope}

{% include [content](../../_includes/security/standard-ai/intro/scope-body.md) %}

### Responsibility {#responsibility}

{% include [content](../../_includes/security/standard-ai/intro/responsibility-body.md) %}

### How to apply this standard {#how-to-apply}

{% include [content](../../_includes/security/standard-ai/intro/how-to-apply-body.md) %}

### Exceptions {#exceptions}

{% include [content](../../_includes/security/standard-ai/intro/exceptions-body.md) %}

### IDs {#identifiers}

{% include [content](../../_includes/security/standard-ai/intro/identifiers-body.md) %}

### Evidence {#evidence}

{% include [content](../../_includes/security/standard-ai/intro/evidence-body.md) %}

## Secure architecture and development of AI applications {#secure-architecture}

{% include [content](../../_includes/security/standard-ai/secure-architecture/secure-architecture-intro-body.md) %}

### Architecture and changes {#architecture-changes}

#### Architecture and risks are documented prior to release {#architecture-risks-fixed-before-release}

{% include [content](../../_includes/security/standard-ai/secure-architecture/architecture-risks-fixed-before-release-body.md) %}

### Input, context, and output {#input-context-output}

#### Untrusted input is verified before being used by the model {#untrusted-input-validated-before-model-use}

{% include [content](../../_includes/security/standard-ai/secure-architecture/untrusted-input-validated-before-model-use-body.md) %}

#### Guardrails have defined categories and fault-tolerant behavior {#moderation-rules-defined-categories-failover}

{% include [content](../../_includes/security/standard-ai/secure-architecture/moderation-rules-defined-categories-failover-body.md) %}

#### Model output gets verified prior to its rendering and execution {#model-output-validated-before-render-exec}

{% include [content](../../_includes/security/standard-ai/secure-architecture/model-output-validated-before-render-exec-body.md) %}

#### System guidelines and policies must only be modified via a trusted path {#system-prompts-policies-changed-trusted-path}

{% include [content](../../_includes/security/standard-ai/secure-architecture/system-prompts-policies-changed-trusted-path-body.md) %}

#### External or retrieved context gains no implicit trust {#external-retrieved-context-no-implicit-trust}

{% include [content](../../_includes/security/standard-ai/secure-architecture/external-retrieved-context-no-implicit-trust-body.md) %}

### External connections and public perimeter {#external-connections}

#### External model API calls pass through a managed boundary {#external-model-api-calls-managed-boundary}

{% include [content](../../_includes/security/standard-ai/secure-architecture/external-model-api-calls-managed-boundary-body.md) %}

#### Public HTTP(S) perimeter has an explicit protection scheme {#public-http-perimeter-explicit-protection}

{% include [content](../../_includes/security/standard-ai/secure-architecture/public-http-perimeter-explicit-protection-body.md) %}

## Data, training, models, and releases {#data-training-models}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-training-models-intro-body.md) %}

### Data intake and preprocessing {#data-intake}

#### Each dataset has an owner, provenance, and allowed purpose {#dataset-has-owner-origin-allowed-purpose}

{% include [content](../../_includes/security/standard-ai/data-training-models/dataset-has-owner-origin-allowed-purpose-body.md) %}

#### RAG loader is restricted to an approved source and destination {#rag-loader-restricted-approved-source-destination}

{% include [content](../../_includes/security/standard-ai/data-training-models/rag-loader-restricted-approved-source-destination-body.md) %}

#### Data stages are separated {#data-stages-separated}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-stages-separated-body.md) %}

#### Data was classified and minimized prior to being forwarded for AI processing {#data-classified-minimized-before-ai}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-classified-minimized-before-ai-body.md) %}

#### Data quality and independence of assessment are verified prior to release {#data-quality-independent-assessment-before-release}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-quality-independent-assessment-before-release-body.md) %}

#### Data and/or RAG corpus changes are controlled {#data-and-rag-corpus-changes-controlled}

{% include [content](../../_includes/security/standard-ai/data-training-models/data-and-rag-corpus-changes-controlled-body.md) %}

#### Synthetic data is accounted for separately {#synthetic-data-accounted-separately}

{% include [content](../../_includes/security/standard-ai/data-training-models/synthetic-data-accounted-separately-body.md) %}

### Training and model artifacts {#training-artifacts}

#### Development, training, and production execution are separated {#dev-training-prod-execution-separated}

{% include [content](../../_includes/security/standard-ai/data-training-models/dev-training-prod-execution-separated-body.md) %}

#### Model package has verifiable provenance {#model-artifact-verifiable-provenance}

{% include [content](../../_includes/security/standard-ai/data-training-models/model-artifact-verifiable-provenance-body.md) %}

#### Model format and loader do not allow arbitrary execution {#model-format-loader-no-arbitrary-exec}

{% include [content](../../_includes/security/standard-ai/data-training-models/model-format-loader-no-arbitrary-exec-body.md) %}

### Release, rollback, and revocation {#release-rollback}

#### Only the exact verified version is admitted into the production environment {#exact-verified-version-admitted-to-prod}

{% include [content](../../_includes/security/standard-ai/data-training-models/exact-verified-version-admitted-to-prod-body.md) %}

#### Version replacement, rollback, and revocation are managed explicitly {#version-managed-explicitly}

{% include [content](../../_includes/security/standard-ai/data-training-models/version-managed-explicitly-body.md) %}

## {{ iam-short-name }}, network, encryption, secrets, and audit {#iam-network-crypto-secrets-audit}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/iam-network-crypto-secrets-audit-intro-body.md) %}

### Permissions and access {#rights-access}

#### Intercomponent connections are limited by the actual topology {#intercomponent-connections-limited-by-topology}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/intercomponent-connections-limited-by-topology-body.md) %}

#### Workload identities have minimal effective permissions {#workload-identities-minimal-effective-rights}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/workload-identities-minimal-effective-rights-body.md) %}

#### {{ ai-studio-name }} call uses a documented authentication method {#ai-studio-call-uses-documented-auth}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/ai-studio-call-uses-documented-auth-body.md) %}

#### Effective permissions are reviewed on a schedule and after changes {#effective-rights-reviewed-on-schedule-and-change}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/effective-rights-reviewed-on-schedule-and-change-body.md) %}

#### Privileged user accounts use MFA {#privileged-users-use-mfa}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/privileged-users-use-mfa-body.md) %}

#### Runtime administrative bypass channels are disabled by default {#runtime-administrative-bypass-channels-disabled}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/runtime-administrative-bypass-channels-disabled-body.md) %}

### Storages and cryptographic protection {#storage-crypto}

#### Model and data storages have no unaccounted for public access {#model-data-stores-no-unaccounted-public-access}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/model-data-stores-no-unaccounted-public-access-body.md) %}

#### Encryption is chosen based on the capabilities of the specific service {#encryption-chosen-by-service-capabilities}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/encryption-chosen-by-service-capabilities-body.md) %}

### Secrets {#secrets}

#### A secret has an owner and a managed lifecycle {#secret-has-owner-managed-lifecycle}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/secret-has-owner-managed-lifecycle-body.md) %}

### Audit and log content {#audit-logs}

#### Each significant operation has an event source specified {#material-operation-has-event-source}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/material-operation-has-event-source-body.md) %}

#### Logs do not collect sensitive content without a purpose {#logs-no-sensitive-content-without-purpose}

{% include [content](../../_includes/security/standard-ai/iam-network-crypto-secrets-audit/logs-no-sensitive-content-without-purpose-body.md) %}

## Runtime, RAG stores, and decommissioning {#runtime-rag-decom}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/runtime-rag-decom-intro-body.md) %}

### Runtime isolation {#runtime-isolation}

#### Independent workloads and tenants are isolated {#independent-workloads-tenants-isolated}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/independent-workloads-tenants-isolated-body.md) %}

#### No state is preserved between independent tasks by default {#no-state-preserved-between-independent-tasks}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/no-state-preserved-between-independent-tasks-body.md) %}

#### Execution of code, commands, and dynamic queries is restricted {#code-commands-dynamic-queries-restricted}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/code-commands-dynamic-queries-restricted-body.md) %}

### RAG authorization {#rag-authorization}

#### Document-related permissions are verified before the chunk goes to the model {#document-access-checked-before-rag-retrieval}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/document-access-checked-before-rag-retrieval-body.md) %}

### Decommissioning {#decommissioning}

#### Component is decommissioned fully {#component-decommissioned-fully}

{% include [content](../../_includes/security/standard-ai/runtime-rag-decom/component-decommissioned-fully-body.md) %}

## Monitoring and incident response {#monitoring-incident-response}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/monitoring-incident-response-intro-body.md) %}

### Signals and alerts {#signals-alerts}

#### Atypical use of APIs and resources is detected {#atypical-api-resource-usage-detected}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/atypical-api-resource-usage-detected-body.md) %}

### End-to-end application trace {#end-to-end-trace}

#### Model and agent request is traced without excess content {#model-agent-request-traced-no-excess-content}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/model-agent-request-traced-no-excess-content-body.md) %}

#### Each agent loop iteration is linked to a task and an action {#agent-loop-iteration-linked-to-task-action}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/agent-loop-iteration-linked-to-task-action-body.md) %}

### Preservation of investigation materials {#forensic-preservation}

#### Dialog content archive has approved scope and controlled access {#dialog-archive-approved-scope-controlled-access}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/dialog-archive-approved-scope-controlled-access-body.md) %}

#### Investigation materials are protected from tampering {#forensic-materials-protected-from-tampering}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/forensic-materials-protected-from-tampering-body.md) %}

### Response procedure {#response-procedure}

{% include [content](../../_includes/security/standard-ai/monitoring-incident-response/response-procedure-body.md) %}

## Agents, tools, MCP, and agent RAG {#agents-tools-mcp}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agents-tools-mcp-intro-body.md) %}

### Capabilities and autonomy {#capabilities-autonomy}

#### Agent capabilities and external consequences are enumerated {#agent-capabilities-external-effects-enumerated}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agent-capabilities-external-effects-enumerated-body.md) %}

#### Autonomous execution has limits and stop conditions {#autonomous-execution-limits-stop-conditions}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/autonomous-execution-limits-stop-conditions-body.md) %}

#### Agent's goal and authority originate only from trusted sources {#agent-goal-authority-from-trusted-sources}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/agent-goal-authority-from-trusted-sources-body.md) %}

### Tool identity and human confirmation {#tool-identity-hitl}

#### Each tool uses a separate account with minimal privileges {#each-tool-has-separate-minimal-identity}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/each-tool-has-separate-minimal-identity-body.md) %}

#### Session authority is defined by a trusted delegation {#session-authority-defined-by-trusted-delegation}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/session-authority-defined-by-trusted-delegation-body.md) %}

#### Actions with significant consequences are confirmed by a human {#material-consequence-actions-confirmed-by-human}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/material-consequence-actions-confirmed-by-human-body.md) %}

### MCP Gateway and target service {#mcp-gateway-target}

#### MCP Gateway and target service access is separated {#mcp-gateway-target-service-access-separated}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/mcp-gateway-target-service-access-separated-body.md) %}

### Inter-agent messages and agent RAG {#interagent-rag}

#### The other agent's message is checked as untrusted {#other-agent-message-checked-as-untrusted}

{% include [content](../../_includes/security/standard-ai/agents-tools-mcp/other-agent-message-checked-as-untrusted-body.md) %}

## Supply chain {#supply-chain}

{% include [content](../../_includes/security/standard-ai/supply-chain/supply-chain-intro-body.md) %}

### Third-party datasets {#third-party-datasets}

#### Third-party dataset provenance and integrity are verified {#third-party-dataset-provenance-integrity-verified}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-dataset-provenance-integrity-verified-body.md) %}

#### Third-party dataset content goes through an intake check {#third-party-dataset-content-intake-check}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-dataset-content-intake-check-body.md) %}

### Third-party models {#third-party-models}

#### Third-party model format, loader, and behavior are checked prior to admission {#third-party-model-format-loader-behavior-checked}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-model-format-loader-behavior-checked-body.md) %}

#### Third-party model goes through a formal acceptance procedure {#third-party-model-formal-acceptance-procedure}

{% include [content](../../_includes/security/standard-ai/supply-chain/third-party-model-formal-acceptance-procedure-body.md) %}

### Software component vulnerabilities {#dependency-vulns}

#### Dependency and container image vulnerabilities are managed {#dependency-container-image-vulns-managed}

{% include [content](../../_includes/security/standard-ai/supply-chain/dependency-container-image-vulns-managed-body.md) %}

### Reproducible release composition {#reproducible-release}

#### The composition of software and AI components of the release is known {#release-software-ai-components-known}

{% include [content](../../_includes/security/standard-ai/supply-chain/release-software-ai-components-known-body.md) %}

### Supplier risk change {#supplier-risk-change}

#### Change to a component or external service triggers re-assessment {#component-external-service-change-triggers-reassessment}

{% include [content](../../_includes/security/standard-ai/supply-chain/component-external-service-change-triggers-reassessment-body.md) %}

## {{ yandex-cloud }} implementation profiles {#profiles}

{% include [content](../../_includes/security/standard-ai/profiles/profiles-intro-body.md) %}

### Managed inference via {{ ai-studio-name }} {#profile-ai-studio}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ai-studio-body.md) %}

### {{ ai-search-name }}-powered RAG {#profile-ai-search}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ai-search-body.md) %}

### Own storage-powered RAG {#profile-own-storage}

{% include [content](../../_includes/security/standard-ai/profiles/profile-own-storage-body.md) %}

#### {{ mos-name }} {#profile-mos}

{% include [content](../../_includes/security/standard-ai/profiles/profile-mos-body.md) %}

#### {{ ydb-short-name }} {#profile-ydb}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ydb-body.md) %}

### Agent with MCP Gateway and tools {#profile-mcp-agent}

{% include [content](../../_includes/security/standard-ai/profiles/profile-mcp-agent-body.md) %}

### Training and experiments in {{ ml-platform-name }} {#profile-ml-platform}

{% include [content](../../_includes/security/standard-ai/profiles/profile-ml-platform-body.md) %}

### Runtime in {{ managed-k8s-name }} {#profile-k8s}

{% include [content](../../_includes/security/standard-ai/profiles/profile-k8s-body.md) %}

### Runtime in {{ serverless-containers-name }} or {{ sf-name }} {#profile-serverless}

{% include [content](../../_includes/security/standard-ai/profiles/profile-serverless-body.md) %}

#### {{ serverless-containers-name }} {#profile-serverless-containers}

{% include [content](../../_includes/security/standard-ai/profiles/profile-serverless-containers-body.md) %}

#### {{ sf-name }} {#profile-sf}

{% include [content](../../_includes/security/standard-ai/profiles/profile-sf-body.md) %}

### Runtime on {{ compute-name }} with a self-hosted model {#profile-compute}

{% include [content](../../_includes/security/standard-ai/profiles/profile-compute-body.md) %}

### Calling an external model API from {{ yandex-cloud }} {#profile-external-api}

{% include [content](../../_includes/security/standard-ai/profiles/profile-external-api-body.md) %}

### Boundaries of shared security tools {#shared-tools-boundaries}

{% include [content](../../_includes/security/standard-ai/profiles/shared-tools-boundaries-body.md) %}

## Compliance and processing of personal and regulated data {#compliance-pii}

{% include [content](../../_includes/security/standard-ai/compliance-pii/compliance-pii-intro-body.md) %}

### Legal approach and placement {#legal-placement}

#### Approved processing admissibility {#approved-processing-admissibility}

{% include [content](../../_includes/security/standard-ai/compliance-pii/approved-processing-admissibility-body.md) %}

#### Placement restrictions are implemented in the architecture {#placement-restrictions-enforced-in-architecture}

{% include [content](../../_includes/security/standard-ai/compliance-pii/placement-restrictions-enforced-in-architecture-body.md) %}

### External recipients and cross-border flows {#external-recipients}

#### Transfer to external recipients is allowed and limited {#external-recipient-transfer-allowed-limited}

{% include [content](../../_includes/security/standard-ai/compliance-pii/external-recipient-transfer-allowed-limited-body.md) %}

#### Cross-border flow is allowed by a separate decision {#cross-border-flow-allowed-by-separate-decision}

{% include [content](../../_includes/security/standard-ai/compliance-pii/cross-border-flow-allowed-by-separate-decision-body.md) %}

### Anonymization, pseudonymization, and personal data masking {#deidentification-masking}

{% include [content](../../_includes/security/standard-ai/compliance-pii/deidentification-masking-body.md) %}

#### Protective transformation takes place before the trust boundary {#protective-transform-before-trust-boundary}

{% include [content](../../_includes/security/standard-ai/compliance-pii/protective-transform-before-trust-boundary-body.md) %}

#### Personal data detection tools match data and risk {#pii-detection-tools-match-data-and-risk}

{% include [content](../../_includes/security/standard-ai/compliance-pii/pii-detection-tools-match-data-and-risk-body.md) %}

#### Transformation is controlled and not bypassed on error {#transform-controlled-not-bypassed-on-error}

{% include [content](../../_includes/security/standard-ai/compliance-pii/transform-controlled-not-bypassed-on-error-body.md) %}

## Security check and testing {#security-testing}

{% include [content](../../_includes/security/standard-ai/security-testing/security-testing-intro-body.md) %}

### Check scope preparation {#test-preparation}

{% include [content](../../_includes/security/standard-ai/security-testing/test-preparation-body.md) %}

### Single requirement check procedure {#single-requirement-check}

{% include [content](../../_includes/security/standard-ai/security-testing/single-requirement-check-body.md) %}

### Configuration and {{ iam-short-name }} check {#config-iam-check}

{% include [content](../../_includes/security/standard-ai/security-testing/config-iam-check-body.md) %}

### Log and telemetry check {#logs-telemetry-check}

{% include [content](../../_includes/security/standard-ai/security-testing/logs-telemetry-check-body.md) %}

### Secure negative and application tests {#negative-app-tests}

{% include [content](../../_includes/security/standard-ai/security-testing/negative-app-tests-body.md) %}

### Red teaming {#red-teaming}

{% include [content](../../_includes/security/standard-ai/security-testing/red-teaming-body.md) %}

### Fix, exception, and re-check {#fix-exception-recheck}

{% include [content](../../_includes/security/standard-ai/security-testing/fix-exception-recheck-body.md) %}

## Standard implementation and monitoring metrics {#metrics}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-intro-body.md) %}

### Standard coverage and compliance {#metrics-coverage}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-coverage-body.md) %}

### Identification, access, and secret management {#metrics-iam-secrets}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-iam-secrets-body.md) %}

### Data and pipeline protection {#metrics-data-pipelines}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-data-pipelines-body.md) %}

### Security of models, agents, and RAG {#metrics-models-agents-rag}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-models-agents-rag-body.md) %}

### Vulnerability management and supply chain {#metrics-vulns-supply-chain}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-vulns-supply-chain-body.md) %}

### Monitoring, incidents, and observability {#metrics-monitoring-incidents}

{% include [content](../../_includes/security/standard-ai/metrics/metrics-monitoring-incidents-body.md) %}

## AI security for fintech organizations {#fintech}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-intro-body.md) %}

### External recommendation source {#fintech-source}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-source-body.md) %}

### Application status {#fintech-status}

{% include [content](../../_includes/security/standard-ai/fintech/fintech-status-body.md) %}

### Compliance statuses {#compliance-statuses}

{% include [content](../../_includes/security/standard-ai/fintech/compliance-statuses-body.md) %}

### Responsibility matrix {#responsibility-distribution}

{% include [content](../../_includes/security/standard-ai/fintech/responsibility-distribution-body.md) %}

### Compliance matrix {#compliance-matrix}

#### AI risk management {#matrix-ai-risks}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-ai-risks-body.md) %}

#### Data and privacy {#matrix-data-privacy}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-data-privacy-body.md) %}

#### Model, development, and supply {#matrix-model-supply}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-model-supply-body.md) %}

#### Testing and resilience {#matrix-testing-resilience}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-testing-resilience-body.md) %}

#### Operation and monitoring {#matrix-ops-monitoring}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-ops-monitoring-body.md) %}

#### Suppliers and open-source software (OSS) management {#matrix-suppliers-oss}

{% include [content](../../_includes/security/standard-ai/fintech/matrix-suppliers-oss-body.md) %}
