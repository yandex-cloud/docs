Before verifying the requirements, a description of the actual or planned architecture is required. It must specify the following:

* Components, environments, and boundaries of trust.
* Entry points and callable model APIs.
* Clouds, folders, and resource IDs.
* Users, service accounts, API keys, and external entities.
* Data stores, RAG indexes, and storage locations for model artifacts.
* Paths of incoming, outgoing, and inter-component traffic.
* Agent tools, their backends, and target resources.
* Locations where personal and other regulated data are processed.
* Sources of audit, application, and operational logs.
* External data providers and recipients.

The word _must_ denotes a mandatory requirement. The word _recommended_ denotes a measure whose application depends on the risks and architecture. The word _may_ indicates a permissible implementation method, but not the only one.

The applicability condition is written in plain text within the requirement. If a condition is missing from the architecture, the reviewer records which component, flow, or data type is missing. Lacking evidence of implementation does not constitute proof of inapplicability.
