{#ai-app-inject1-id}

Requirement ID: `AI-APP-INJECT1`

{#ai-app-inject1-requirement}

**Requirement**

RAG chunks, web pages, files, emails, tool results, and other external data must be provided to the model as payload, not as trusted system instructions. For each chunk, the accessible source ID and the result of applied policy are saved.

The application must separate data from control instructions, process the retrieval or validation error in a fail-safe manner, and limit the consequences if an external context attempts to change the objective, disclose a secret, or initiate an action.

Labeling is assigned during the upload: immutable source and document IDs, owner, trust level or data class, and version. External content cannot select a tool, action, or recipient.

{{ ai-search-name }} does the uploading, chunking, vectorization, and searching for documents. The application must separate the found data from control instructions, and limit their impact. For the service capabilities, see [this {{ ai-search-name }} guide]({{ link-docs-ai }}ai-studio/concepts/search/index.html).

{#ai-app-inject1-check}

**Check**

Put into a test source a document with a known ID and an instruction to change a system policy or call a tool.

The requirement is met if the instruction is treated as data, changes no privileges, and does not lead to an action without a separate verification, and the trace links the result to the source and policy decision. The system may quote or paraphrase such content, but there must be no tool events or target system events.

Upon failure, quarantine the document or index version, disable the affected search source, fix the policy or parser, rebuild the index, and repeat the test.

{#ai-app-inject1-artifacts}

**Artifact**

* Test document with instructions.
* Policy decision trace.
* Search result IDs.
* Quarantine or reindexing record.
