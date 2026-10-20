{#ai-sdlc1-id}

Requirement ID: `AI-SDLC1`

{#ai-sdlc1-requirement}

**Requirement**

Prior to the first production release and after any major update, the system’s owner must document all components, trust boundaries, data, subjects, model calls, tools, external connections, and the potential impact of errors or malicious behavior. This description must map each major risk to a specific boundary, measure, or check method.

For each mapping, you must state the source subject and resource, target resource or API, data class, protocol, authentication method, network path, event source, and owner.

Make sure to explicitly define these checkpoints: `pre_model` before calling a model, `retrieval` during data retrieval; `pre_action` before applying the tool, `post_model` after the model responds, and `pre_egress` before a request leaves the secure zone.

{#ai-sdlc1-implementation}

**Implementation**

An update is considered major if it introduces a new model or provider, data type, RAG source, tool, external recipient, public endpoint, role, or code execution method. The organization must define a procedure to review these updates and assign employees responsible for the approval. This requirement applies to every production system and every major update. The system-wide `N/A` result is not allowed. Before any work begins, you must agree on the conditions for revising the description and the approving party.

{#ai-sdlc1-manual-check}

**Manual check**

1. Map the documented architecture to your deployed resources, routes, and accounts.
1. Select one allowed and one blocked data flow for each boundary.

You are compliant if all the production components are documented, and every boundary has a defined owner and a measure to check. An unmapped component or data flow means failure. You must either update your description and applicable requirements to include such an asset, or remove it from the production environment. After that, repeat the allowed and blocked flow checks.

{#ai-sdlc1-artifacts}

**Artifact**

* Architecture description.
* Data flow diagram.
* Mapping to actual resources.
* Test results.
* Documented approval.
