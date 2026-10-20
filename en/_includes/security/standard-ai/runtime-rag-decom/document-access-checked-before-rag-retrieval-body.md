{#ai-rag-acl2-id}

Requirement ID: `AI-RAG-ACL2`

{#ai-rag-acl2-requirement}

**Requirement**

If RAG contains documents from various access scopes, the application must form a search query based on verified user identity and permissions and apply document authorization prior to putting the found fragment into the model context. A check only after the response is generated does not fulfill the requirement: the model has already received the hidden content.

The user and tenant access scope must be saved in the agent path. The tenant ID and filter are not received from the query without a binding to checked attributes on the server side.

After the search, the IDs of returned documents are checked again before building the context. The version policy and IDs of returned documents are logged, not the hidden content.

For {{ mos-name }}, cloud roles manage the service resource, but they do not by themselves implement document authorization of the end user. If the architecture uses internal roles and {{ OS }} filters, their supported semantics and negative tests are recorded separately. The capabilities of {{ yandex-cloud }} roles are described in [this {{ mos-name }} guide](../../../../managed-opensearch/security/index.md).

For {{ ydb-short-name }}, roles for the database are not a ready row-based authorization either; client authentication is described in [this {{ ydb-short-name }} guide](../../../../ydb/api-ref/authentication.md).

For another storage, the owner must document an access model of their own.

{#ai-rag-acl2-implementation}

**Implementation**

{{ ai-search-name }} implements Vector Store metadata and supports filtering by file attributes in the search API; however, this is not a ready-to-go document authorization.

If the required access scope cannot be reliably expressed and protected with a filter, the service uses either separate Vector Store instances or application-based authorization before the fragment is included into the context. The filter becomes a part of the control circuit only when the app forms it from confirmed permissions and rejects substitution. For more, see the articles on [Vector Store]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore.html) and [search parameters]({{ link-docs-ai }}ai-studio/api/Vector-stores/searchVectorStore.html).

{#ai-rag-acl2-check}

**Check**

1. Create documents of at least two access scopes.
1. Run a permitted search from each subject to their own documents and attempt to receive another user’s document or row.
1. Check not only the output, but also the actual context of the model query.

The requirement is fulfilled if authorization applies before the model is called, and the hidden document or row are not present in the search results and in the actual context of the unauthorized subject’s query. Substitution of the tenant or metadata filter must be rejected. The evidence is the manifest of the model query’s actual context that confirms the absence of hidden content.

{#ai-rag-acl2-artifacts}

**Artifact**

* Permitted search.
* Attempt to get another user's document.
* Model context.
* Policy version.
* Actual request context manifest.
