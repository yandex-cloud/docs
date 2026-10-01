#### {#catalog}

A metadata catalog is the main entity within {{ data-catalog-name }}. It acts both as a repository for aggregating and storing metadata ingested from various sources and as a workspace for its markup. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md).

#### {#ingestion}

An ingestion is a process that connects to the data storage or service specified in the source to populate metadata into a catalog. You can run an ingestion manually or on a schedule. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#metadata-upload).

#### {#source}

A source is a connection through which metadata is ingested. This connection stores information about the database or service metadata is ingested from as well as authentication credentials. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#metadata-upload).

#### {#data-store}

A data store is an entity that aggregates metadata from sources belonging to the same managed database cluster or custom database installation. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#data-store).

#### {#domain}

A domain is a high-level logical group used to organize metadata based on your business process needs, e.g., by departments or business units. For each domain, you can create a subdomain. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains).

#### {#subdomain}

A subdomain is a nested metadata unit within a domain used for more granular distribution of metadata. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains).

#### {#classification}

A classification is a group of tags used to mark up metadata. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags).

#### {#tag}

A tag is a label used to mark up metadata by type, e.g., sensitive data or table attributes. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags).

#### {#glossary}

A glossary is a dictionary of domain-specific terms and their definitions. It acts as a single source of truth for terminology used within a company. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms).

#### {#term}

A term is a concept used to mark up data by its semantic meaning based on an organization’s official definitions, e.g., _revenue_ or _expenses_. For more information, see [{#T}](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms).
