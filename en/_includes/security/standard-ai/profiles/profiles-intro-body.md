This profile links requirements to a specific request path and {{ yandex-cloud }} objects. Profiles do not introduce new requirements; they present resources, settings, and evidence for the requirements from these sections:

* [{#T}](../../../../security/standard-ai/secure-architecture.md)
* [{#T}](../../../../security/standard-ai/data-training-models.md)
* [{#T}](../../../../security/standard-ai/iam-network-crypto-secrets-audit.md)
* [{#T}](../../../../security/standard-ai/runtime-rag-decom.md)
* [{#T}](../../../../security/standard-ai/monitoring-incident-response.md)
* [{#T}](../../../../security/standard-ai/agents-tools-mcp.md)
* [{#T}](../../../../security/standard-ai/supply-chain.md)
* [{#T}](../../../../security/standard-ai/compliance-pii.md)

Multiple profiles can be used simultaneously within a single system: for example, an application in [{{ managed-k8s-name }}](../../../../managed-kubernetes/index.yaml) invokes [{{ ai-studio-name }}]({{ link-docs-ai }}), employes [{{ ai-search-name }}]({{ link-docs-ai }}ai-studio/concepts/search/), and accesses tools via the MCP Gateway. A reviewer consolidates profiles based on the actual architecture without transferring properties from one service to another.

The following table links each requirement to applicable {{ yandex-cloud }} profiles and specifies exactly what to verify and which artifact to use to confirm the result. For requirements not linked to a specific service, a general verification principle is stated; lack of a profile does not negate the requirement itself.

The profile numbers in the table are examples of implementation, not a limitation on applicability. The applicability of a requirement is determined by architectural conditions: controls for regulated data apply to any profile handling such data; image checks apply to all container runtime environments; and public perimeter protection applies to any profile with a public HTTP(S) access.

#||
|| **Requirement ID** | **Applicable profiles** | **What to check** | **Artifact** ||
|| `AI-SDLC1` | All profiles | Architecture description, trust boundaries, relationship between risks and measures | Architecture description, data flow diagram, mapping to actual resources, inventory version differences, test records, sign-off document ||
|| `AI-APP-WAF1` | Any profile with a public HTTP(S) access, e.g.:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Application-level input validation prior to model invocation; {{ api-gw-name }} + {{ sws-name }} with public access | Rejection records, OpenAPI specification configuration and hash, {{ sws-name }} profile ID, test requests and their results, subsequent call absence confirmation ||
|| `AI-CONTENT1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio) | Guardrails as a configuration object, `ai.guardrails.editor` role, `incomplete`/`content_filter` status | Rule version and exported configuration, model instance and guardrail IDs, blocking test, management event or application record ||
|| `AI-CONTENT2` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Deterministic output validator, rejection of prohibited action | Model test responses, rejection records, validator code, schema hash and policy version, confirmation that there is no call for the target system. ||
|| `AI-CORE5` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Separate storage of system instructions, versions, and read/write subjects | Active configuration version, release notes, Spoofing test result, instruction artifact hash, deployment event, current version log ||
|| `AI-APP-INJECT1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent)
| Separation of data and instructions, fail-safety, connection to the source | Test document with instructions, policy decision trace, search result IDs, quarantine or reindexing record ||
|| `AI-NET3` | [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api) | Approved endpoints, service identity, route, timeouts, log | Proxy and firewall configuration, allowed and denied call record, secret ID, call correlation log ||
|| `AI-NET7` | Any profile with a public HTTP(S) access, e.g.:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Domain, route, authentication, limits, backend connection | OpenAPI specification, unauthenticated requests, backend bypass test, {{ sws-name }} specification and profile IDs, bindings, HTTP test results ||
|| `AI-DATA1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
| Registry of source, owner, target, and link to model or index | Registry record, tracing up to object and version, card version, object version or hash, approver ||
|| `AI-RAG-INGEST1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
| Loader separation, staging area, target index | Successful upload of an approved object, rejection of an unapproved source, loader version, acceptance and rejection events, reindexing record ||
|| `AI-DATA3` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Stage separation, write permissions, progression rules | Bucket/prefix access policies, record test from the production environment, stage schema, input and output versions, transition log ||
|| `AI-DATA4` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api)
| Classification, minimization, reversibility, keys or mapping table | Field schema, post-transformation selection, rejection of prohibited fields, field mapping by destination, record of copy deletion ||
|| `AI-DATA5` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
| Input versions, metrics, thresholds, data splitting | Saved report with version, criteria, and result, code version for checks and tests, dataset hashes, independent reviewer ||
|| `AI-DATA6` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
| Checksums, trusted identity, admission procedure | Version-to-source mapping, check bypass test, release manifest with hashes, change event, recovery test ||
|| `AI-DATA7` | [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform) | Generator registration, share, separate valuation | Synthetic portion record, Share and control sample report, generator version, unlabeled data rejection test result ||
|| `AI-TRAIN1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Separation of projects, identities, storages, and network paths | Contour mapping, unauthorized secret read and production write test, hashes of job input and output objects ||
|| `AI-MODEL1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Source, version, checksum, admission status | Provenance record, mapping to a running instance, model card, hashes, and versions of objects in storage ||
|| `AI-MODEL2` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Format, loader, isolated execution, checksum | Isolated execution result, activity monitoring, format and loader versions, isolated environment configuration, admission decision ||
|| `AI-REL1` | All profiles | Exact versions of data, models, instructions, configurations, and images | Release decision, comparison with production revision, release manifest hash, deployment event ||
|| `AI-REL2` | All profiles | Compatibility, replacement procedure, rollback criteria, revocation method | Replacement and rollback test, initiator log, revoked version unavailability, rollback target IDs, return approval ||
|| `AI-NET2` | All profiles | Allowed inbound, outbound, and inter-component connections | Flow diagram, security group rules, allowed and denied connection, connection results from allowed and denied sources ||
|| `AI-IAM-MFA1` | All profiles | Enhanced authentication for privileged users | List of privileged roles and groups, export of effective permissions, confirmation of MFA status or federation policy, exception duration ||
|| `AI-INFRA-CONSOLE1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-compute) and any profiles with VM components | Serial console disabled by default, emergency activation only upon exception | VM configuration or serial console policies, access denial, emergency access request and duration (if applicable), activation and deactivation events, OS logs or compensating logs ||
|| `AI-IAM-LEASTPRIV1` | All profiles | Distinct work identity, minimum role, scope of assignment | Effective direct and inherited permissions, role-to-operation mapping, `subject → operation → resource → role or scope → binding level` matrix, masked key scopes ||
|| `AI-IAM4` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent)
| IAM token or API key, role, scopes, duration or revision | Key metadata (excluding the value), owner and API mapping, service account bindings, key lifecycle in {{ at-name }}, results of allowed and denied calls ||
|| `AI-IAM5` | All profiles | Review frequency, scope of direct, group, and inherited permissions | Dated revision record, decisions on excessive permissions, origin of permissions, exception period, repeated negative test ||
|| `AI-NET5` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Storage visibility, precise IDs, subjects, network path | Effective bindings, ACLs, read tests from authorized and unauthorized subject, public access and network configuration ||
|| `AI-CRYPT1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Encryption mode, key, key permissions, read test using the native environment | Encryption configuration, permitted read and unauthorized access denial, key ID and bindings, recovery rehearsal ||
|| `AI-SECRET1` | All profiles | Owner, ID, version, consumers, delivery, timeframe, replacement and revocation | Mapping a secret to a consumer, revocation and replacement test, {{ iam-short-name }} and {{ kms-short-name }} bindings, value retrieval event in {{ at-name }}, rotation record ||
|| `AI-AUDIT1` | All profiles | List of operations, event source, trail scope, filters | Trail configuration, safe test action and found record, event map, trail specification, missing event test ||
|| `AI-AUDIT2` | All profiles | Deletion or transformation of secrets and personal data prior to writing | Logging schema, record selection, storage purpose confirmation, test events with synthetic markers, log reader bindings ||
|| `AI-INFRA6` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Separation of identities, network paths, state, and permissions | Test of cross-tenant access to file, secret, cache, and endpoint, topology and map of resources and tenants ||
|| `AI-INFRA-ISOL2` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Creation and cleanup of a temporary state, process or instance boundary | Synthetic marker, unavailability after task completion, state map with lifespans, cleanup event ||
|| `AI-INFRA-ISOL3` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Separate environment, minimal identity, limits, network control | Permitted operation, boundary tests, process termination, list of permitted operations, confirmation of absence of side effects ||
|| `AI-RAG-ACL2` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
| Document authorization prior to the transfer of a model fragment | Authorized search, attempt to get another user's document, model context, policy version, actual request context manifest ||
|| `AI-DECOM1` | All profiles | Complete inventory of active and reserved assets, output method | Inventory version, completion report, call test using the same method, pre- and post-inventory, result of search for residual objects ||
|| `AI-MON-ANOMALY2` | All profiles | Signals, source, window, channel, action | Alert configuration, delivery test, logging of the responsible party's action, dashboard and alert IDs, event timeline, incident response ticket ||
|| `AI-MON-TRACE1` | All profiles | Correlation ID, identity, model version, policy decision, tool | End-to-end trace from input to result, no secrets, mapping of platform and application IDs ||
|| `AI-MON-TRACE2` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Task and session IDs, step, tool, result | Trace of a multi-step workflow with a successful and rejected call, task state machine version, acknowledgment record, target system event ||
|| `AI-FORENSIC2` | All profiles | Composition, purpose, timeframe, location, owner, target audience | Saved session, test of permitted and prohibited reading, case scope, result of deletion or deletion prohibition ||
|| `AI-FORENSIC3` | All profiles | Separation from active administrators, segregation of permissions, integrity | Log permissions, only copy modification test, bucket, policy, ACL, versioning, lock, and encryption configuration, object version and hash ||
|| `AI-AGENT1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | List of tools, data, and recipients, maximum consequences | Feature registry, configuration mapping, registry version, test events ||
|| `AI-AGENT2` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Limits, control point, safe state, stop conditions | Cyclic response, recurring error, and limit exhaustion test, policy version and counter configuration, final reason for stopping ||
|| `AI-AGENT-GOAL1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Trusted source of target, separation of facts, proposals, and instructions | Test of target expansion via user, RAG, or tool, target version and delegation, confirmation of lack of call to the target system ||
|| `AI-IAM-LEASTPRIV3` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Separate tool identity, minimal permissions, backend verification | Backend, service account, and role mapping, spoofing test, tool matrix, secret IDs ||
|| `AI-IAM-COMPROMISE1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | User, session, and tenant validation, delegation context | User/tenant spoofing and session revocation test, delegation record, token metadata (excluding secrets), revocation event ||
|| `AI-AGENT-HITL1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Actions with significant consequences, display of the target and parameters | Unconfirmed action test, post-confirmation parameter change, confirmation ID and hash, target system event ||
|| `AI-MCP1` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Invocation, management, bindings, service account, target service | Gateway configuration, allowed and denied call, backend bypass, GET result and gateway bindings, complete tool specification, public access status, API key scope ||
|| `AI-APP-INJECT2` | [{#T}](../../../../security/standard-ai/profiles.md#profile-mcp-agent) | Verifiable sender, schema version, expiration, replay protection | Tests involving incorrect schemas, expired validity, duplicates, sender spoofing, sender identity and binding, schema and policy versions ||
|| `AI-SUPPLY1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Source, author, date, version, conditions, checksum | Acceptance record, repeated retrieval and checksum comparison, source and internal hashes, quarantine test ||
|| `AI-DATA-CHECK1` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-search)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-own-storage)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
| Automatic and manual checks, quarantine, manual resolution | Test error set, link between the report and the input version, validator versions, confirmation of the object's absence from the index ||
|| `AI-SUPPLY2` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Source, checksums, format, loader, isolated execution | Package with the source, action monitoring during ingestion, configuration of the initial check environment ||
|| `AI-SUPPLY3` |
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| Application, source verification, integrity, behavioral tests, decision | Acceptance record, checksum spoofing test, acceptance package and its hash, confirmation or exclusion ||
|| `AI-SUPPLY4` | All container runtimes:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| List of dependencies, vulnerability information, fix date | Image digest, latest scan results, release test, dependency report, redeployment event ||
|| `AI-SUPPLY5` | All container runtimes:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-k8s)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-compute)
| SBOM or manifest, composition, checksums | Saved manifest, comparison with actual objects, manifest hash, component cards ||
|| `AI-SUPPLY6` | All profiles | Notification channels, procedure for identifying affected releases | Test notification, search for systems, restriction decision, affected release manifests, ticket ||
|| `AI-COMPLY1` | All profiles | Approved solution, coverage of all data types and recipients | Legal and compliance approach, scenario register, data flow diagram, flow IDs, trace example ||
|| `AI-COMPLY2` | All profiles | Lifecycle map, components, regions, copies, recipients | Flow map, component registry, resource inventory, unregistered copy test, resource exports, migration or deletion record ||
|| `AI-COMPLY3` | [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api) | Recipient, jurisdiction, endpoint, size, terms, timeframe | Recipient registry, gateway configuration, prohibited transmission test, secret ID, provider evidence, redirection test ||
|| `AI-COMPLY4` | [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api) | Decision by authorized representatives, comparison with resources and routes | Legal and compliance assessment, flow registry, architectural chart, solution IDs, unknown edge failure ||
|| `AI-COMPLY-PII1` | Any profile with a flow of adjustable data, e.g.:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api)
| Detection and transformation up to the boundary, reversibility, safe behavior | Transformation policies, confidence boundary test, reverse transformation permissions, transformation type and version, residual field and unavailability tests ||
|| `AI-COMPLY-PII4` | Any profile with a flow of adjustable data, e.g.:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api)
| Detection tools, versioning, test kits, monitoring | {{ dspm-name }}/DLP configuration, rule versions, quality assessment results, set management rules, detector versions ||
|| `AI-COMPLY-PII3` | Any profile with protective transformation of regulated data, e.g.:
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ai-studio)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-ml-platform)
* [{#T}](../../../../security/standard-ai/profiles.md#profile-external-api)
| Minimal privileges, separation of duties, logging without personal data | IAM policies, transformation logs, fault-tolerance tests, event schema, unavailability and bypass tests ||
|#
