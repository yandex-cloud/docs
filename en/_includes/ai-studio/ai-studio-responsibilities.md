# Zones of control between the {{ ai-studio-name }} users and {{ yandex-cloud }}

{{ ai-studio-name }} users should be aware of how responsibilities are shared between [{{ ai-studio-name }}](#cloud-responsibilities) and the [{{ yandex-cloud }} customer](#customer-responsibilities). Understanding these control zones makes you an adept user of cloud resources and helps ensure security when using ML models, agents, and AI tools.

## {{ yandex-cloud }} control zone {#cloud-responsibilities}

* **Physical security**: Protection of data centers, server hardware, and physical infrastructure.

* **Platform infrastructure**: Platform fault tolerance, network security, and protection of hypervisors and infrastructure components.

* **{{ ai-studio-name }} services and components**: Security and availability of [Model Gallery]({{ link-docs-ai }}ai-studio/concepts/generation/), [Agent Atelier]({{ link-docs-ai }}ai-studio/concepts/agents/), [MCP Hub]({{ link-docs-ai }}ai-studio/concepts/mcp-hub), and the [API]({{ link-docs-ai }}ai-studio/concepts/api).

* **ML models and their use**: Ensuring the availability, updates, and support of the models offered by the service.

* **Data-at-rest encryption**: Encrypting all user data by default using {{ yandex-cloud }} keys.

* **Data-in-transit encryption**: Support for TLS with [cipher suites](https://en.wikipedia.org/wiki/Cipher_suite) that ensure [PCI DSS](https://en.wikipedia.org/wiki/Payment_Card_Industry_Data_Security_Standard) compliance for all APIs.

* **Encryption key management**: [{{ kms-full-name }}](*kms_service_info) infrastructure with support for the AES-GCM authenticated encryption standard and 128-, 192-, or 256-bit keys.

* **Secret management**: Providing [{{ lockbox-full-name }}](*lockbox_service_info) for secure storage.

* **Availability and integrity of customer data**: Storage security, data replication, monitoring, and logging.

* **Access management**: Authentication mechanisms, [{{ iam-full-name }}](*iam_service_info) infrastructure, and service roles (`ai.playground.user`, `ai.languageModels.user`, `ai.assistants.editor`, and more).

* **Roles for {{ ai-studio-name }}**: Providing [granular](*granularity_definition) roles, such as `auditor`, `viewer`, `editor`, and `admin`, for agents, [datasets]({{ link-docs-ai }}ai-studio/concepts/resources/dataset), models, and MCP servers.

* **Audit logs**: [{{ at-full-name }}](*audit-trails_service_info) for collecting platform-level events and exporting them to [{{ objstorage-full-name }}](*storage_service_info) or [{{ cloud-logging-full-name }}](*logging_service_info).

* **Network security**: [{{ sws-full-name }}](*sws_service_info) for protection against L7 attacks and [DDoS Protection](*ddos_protection).

* **DDoS protection**: DDoS Protection infrastructure and traffic filtering.

* **Scanning for vulnerabilities**: Providing a [vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md) for container images.

* **Tools for building agents and apps**: Providing an API, [SDK]({{ link-docs-ai }}ai-studio/sdk/), [Agent Atelier]({{ link-docs-ai }}ai-studio/concepts/agents/) tools, and [{{ ai-studio-name }} UI]({{ link-console-ai }}).

* **Model fine-tuning**: Model fine-tuning infrastructure ([Tuning API]({{ link-docs-ai }}ai-studio/concepts/tuning)) and training environment.

* **Components for integration with external systems**: [{{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/) and [{{ search-api-full-name }}](*search-api_service_info).

* **Infrastructure monitoring**: Monitoring the platform infrastructure and its components.

* **Compliance and certification**: Compliance with ISO 27001/27017/27018/27701/42001, 152-FZ (FSTEC Order No. 21, UZ-1).

* **API protection**: Platform API security, [request rate limiting](../../api-gateway/concepts/extensions/rate-limit.md), and request authentication.

* **Prompt and output security**: Providing a response moderation component.

* **Incident management**: Detecting and responding to infrastructure incidents.

## {{ yandex-cloud }} customer control zone {#customer-responsibilities}

* **ML models and their use**: Using ML models to solve user tasks.

* **Data-at-rest encryption**: Enabling encryption with customer [{{ kms-full-name }}](*kms_service_info) keys for critical data and managing key rotation.

* **Data-in-transit encryption**: Using only secure connections and validating certificates.

* **Encryption key management**: Creating and rotating customer keys, and setting a rotation period aligned with the customer's information security policy.

* **Secret management**: Storing tokens, API keys, and secrets in [{{ lockbox-full-name }}](*lockbox_service_info), keeping secrets out of code and metadata.

* **Access management**: Assigning roles under the principle of least privilege, managing user accounts, and regularly auditing access permissions.

* **Customer data**: Classifying data, controlling access, protecting confidential information, and ensuring regulatory compliance.

* **Audit logs**: Enabling [{{ at-full-name }}](*audit-trails_service_info) at the organization level, analyzing logs in [{{ yandex-siem-full-name }}](*siem_service_info), and configuring security event monitoring.

* **Network security**: Configuring [security groups](../../vpc/concepts/security-groups.md), segmenting the network, and using [bastion hosts](*bastion_host).

* **DDoS protection**: Protecting critical services against DDoS attacks using proprietary solutions or {{ yandex-cloud }} tools, such as [{{ ddos-protection-full-name }}](*ddos_protection).

* **Virus protection**: Deploying antivirus solutions on virtual machines and in applications in the customer's cloud.

* **Scanning for vulnerabilities**: [Enabling](../../container-registry/operations/scanning-docker-image.md) a scan-on-push policy and periodically scanning images at least once a week in the production environment.

* **Agent and application development**: Developing an [agent]({{ link-docs-ai }}ai-studio/concepts/agents) logic, configuring [workflows]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/workflow), testing prompts, and integrating them into business processes.

* **Model fine-tuning**: Preparing [datasets]({{ link-docs-ai }}ai-studio/concepts/resources/dataset), selecting fine-tuning parameters, validating results, and securing training data.

* **Integration with external systems**: Setting up connections to enterprise systems, securing integrations, and managing external tools.

* **Infrastructure monitoring**: Application-level monitoring, agent activity logging, and resource usage analysis.

* **Backup**: Setting up backups for applications, user data, and agent configurations.

* **Compliance and certification**: Ensuring compliance with industry regulations, auditing data usage, and documenting processes.

* **API protection**: Securely storing API keys, monitoring quota usage, and validating input data.

* **Prompt and output security**: Filtering sensitive data in prompts, validating model responses, and preventing information leakage through agents.

* **Incident management**: Developing an application-level incident response plan and notifying users of suspicious activity.

{% include [responsibilities-support](../../_includes/overview/responsibilities-support.md) %}

[*kms_service_info]: {% include [kms-service-info-popup](../../_popups/kms/kms-service-info.md) %}

[*lockbox_service_info]: {% include [lockbox-service-info-popup](../../_popups/lockbox/lockbox-service-info.md) %}

[*iam_service_info]: {% include [iam-service-info-popup](../../_popups/iam/iam-service-info.md) %}

[*granularity_definition]: {% include [granularity-in-access-management-definition](../../_popups/granularity-in-access-management-definition.md) %}

[*audit-trails_service_info]: {% include [audit-trails-service-info-popup](../../_popups/audit-trails/audit-trails-service-info.md) %}

[*storage_service_info]: {% include [storage-service-info-popup](../../_popups/storage/storage-service-info.md) %}

[*logging_service_info]: {% include [logging-service-info-popup](../../_popups/logging/logging-service-info.md) %}

[*sws_service_info]: {% include [sws-service-info-popup](../../_popups/sws/sws-service-info.md) %}

[*search-api_service_info]: {% include [search-api-service-info-popup](../../_popups/search-api/search-api-service-info.md) %}

[*siem_service_info]: {% include [siem-service-info-popup](../../_popups/siem/siem-service-info.md) %}

[*bastion_host]: {% include [bastion-host-popup](../../_popups/bastion-host.md) %}

[*ddos_protection]: {% include [ddos-protection-info-popup](../../_popups/vpc/ddos-protection-info.md) %}
