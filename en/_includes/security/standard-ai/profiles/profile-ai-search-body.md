{#profile-ai-search-applicability}

**Scope and status**

The profile is applied if the RAG uses files and {{ ai-studio-name }} Vector Store. Web Search is recorded by a separate external branch; {{ ai-search-name }} properties are not transferred to a random vector store.

{#profile-ai-search-flow}

**Flow and trust boundaries**

`approved source → loader → file → Vector Store → application search → allowed fragments → model context`. The admissibility boundary is before the file publishing; and the document authorization boundary is before the model fragment transfer.

{#profile-ai-search-authentication}

**Workload identity and authentication**

Ingestion and search identities are separated if keeping them together is not justified. Each one uses an IAM token or API key as per the requirements of the specific API and runtime environment profile.

{#profile-ai-search-roles}

**Roles and scope**

`ai.assistants.editor` manages files and Vector Store; `ai.assistants.viewer` allows reading them and performing search. For subsequent text generation, `ai.languageModels.user` is used; for Responses, `ai.assistants.editor` together with `ai.languageModels.user`. A single operation example and its API key scope is not a universal combination; relevant semantics are taken from the [{{ ai-studio-name }} access model]({{ link-docs-ai }}ai-studio/security/).

{#profile-ai-search-network}

**Network**

The managed {{ ai-studio-name }} endpoint is used; a loader with {{ vpc-short-name }} does not create a separate Vector Store network boundary. For Web Search, the permitted domains and external boundary are recorded. No undocumented private endpoint is declared.

{#profile-ai-search-secrets}

**Secrets and credentials**

Loader and search environment credentials are delivered by their runtime environment profiles. The corpus card stores the ID and scopes of the key, but not the value. The data source secret is separated from search credentials.

{#profile-ai-search-configuration}

**Configuration objects**

Source and version, file identifiers and Vector Store, grouping and tokenization settings, file attributes, ingestion and search identities, lifecycle state, and relation to a release. For a description of the features and metadata, see [Vector Store]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore.html).

{#profile-ai-search-telemetry}

**Telemetry and blind spots**

[{{ ai-studio-name }} event catalog]({{ link-docs-ai }}ai-studio/at-ref.html) publishes `searchindex.CreateSearchIndex`, `searchindex.UploadFilesToSearchIndex`, `searchindex.DeleteFilesFromSearchIndex`, and `searchindex.DeleteSearchIndex`. No separate index change event or event of every search query are declared in this list; the application writes end user permissions and search tracing with source IDs and an authorization decision.

{#profile-ai-search-checks}

**Positive and negative checks**

1. Upload a permitted object. Test rejection of a non-permitted source and refusal to write to another user’s Vector Store.
1. Perform search on behalf of two subjects, substitute the filter attribute, and confirm the absence of the hidden fragment in the model context.
1. Delete the test file and make sure the output stops.

{#profile-ai-search-inputs}

**What you need for profile implementation**

* Architecture: corpus, ingestion and search identities, and document access model.
* Policy: rules of acceptance, grouping, reindexing, and lifespan.
* Legal approach: admissibility of sources, data categories, and Web Search. Authorization via a filter is used only after its exact application semantics is confirmed; otherwise, separate Vector Store instances or authorization before search are used.
