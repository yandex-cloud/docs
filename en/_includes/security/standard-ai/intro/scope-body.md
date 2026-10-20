This standard establishes security requirements and recommendations for artificial intelligence systems deployed fully or partially in {{ yandex-cloud }}. It targets security architects, information security specialists, developers, ML and DevSecOps engineers, service owners, SOC analysts, and compliance officers.

This standard applies to the following scenarios:

* Calling [{{ ai-studio-full-name }}]({{ link-docs-ai }})'s API and models.
* RAG based on [{{ ai-search-name }}]({{ link-docs-ai }}ai-studio/concepts/search/) or on a storage system selected by the organization.
* Agents, MCP Gateway, MCP servers, and other tools.
* Model training, experiments, and deployment in [{{ ml-platform-full-name }}](../../../../datasphere/index.yaml).
* Using AI components in [{{ managed-k8s-full-name }}](../../../../managed-kubernetes/index.yaml), [{{ serverless-containers-full-name }}](../../../../serverless-containers/index.yaml), [{{ sf-full-name }}](../../../../functions/index.yaml), and [{{ compute-full-name }}](../../../../compute/index.yaml).
* Using self-hosted models.
* Calling external model APIs from {{ yandex-cloud }}.
* Processing data, model artifacts, system instructions, secrets, and logs throughout the lifecycle.

This standard complements the [{{ yandex-cloud }} infrastructure security standard](../../../../security/standard/all.md). The general requirements for cloud accounts, networks, virtual environments, encryption, and audit logs remain in effect. This document establishes additional responsibilities arising from model call, untrusted context, RAG, autonomous actions, model artifacts, and AI application-specific telemetry.

The standard can serve as a basis for developing internal organization policies. Not all requirements may apply to a specific system; additional measures not covered by this document may also be required.
