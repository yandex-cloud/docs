{#ai-comply3-id}

Requirement ID: `AI-COMPLY3`

{#ai-comply3-risk}

**Risk**

Sending personal data or any other confidential information to an external model, API, SaaS tool, or third-party provider without a compliance review may lead to a violation of legal requirements, contractual obligations, and organization policies.

{#ai-comply3-requirement}

**Requirement**

Before sending data, the organization must document the following for each external recipient:

* Recipient, their jurisdiction, and allowed subcontractors.
* Purpose, categories, composition, and maximum allowed amount of data.
* Allowed endpoints, domain names, IP addresses, and the sending workload identity.
* Data processing, storage, and backup region, if defined by the provider.
* Terms for data processing delegation, cross-border transfer, retention, deletion, and processing termination.
* Validity period of the decision and events requiring its review.

An application or centralized AI gateway must only send approved data to a trusted endpoint. Changing a recipient, endpoint, processing region, included fields, provider terms, or subcontractor requires a new check.

{#ai-comply3-implementation}

**Implementation**

[{{ vpc-short-name }} route tables](../../../../vpc/concepts/routing.md) allow routing subnet traffic through a specified `next hop` but do not confirm transfer legitimacy and do not support content filtering or recipient control at the application layer.

{#ai-comply3-recommendation}

**Recommendation**

Implement a centralized AI integration layer to handle workload authentication, recipient whitelisting, field minimization, PII masking, request metadata logging, and blocking of unapproved directions. Do not write the full contents of regulated requests and responses into technical logs without a reason and extra security measures in place.

{#ai-comply3-check}

**Check**

1. Cross-reference the approved registry of external recipients with the configurations of applications, DNS, TLS connections, {{ vpc-short-name }} routes, and outgoing network traces.
1. Run a test allowed transfer of data to an approved endpoint.
1. Try to send a restricted field or route a request to an unapproved endpoint.
1. The unauthorized transfer must be stopped before the data leaves the trusted perimeter.
1. The request redirect attempt to an unapproved address must be blocked, and the denied call must not appear in the outgoing traffic log or provider traces.

{#ai-comply3-artifacts}

**Artifact**

* Data transfer evaluation.
* Registry of recipients and endpoints.
* Contractual documents or references to them.
* AI gateway configuration.
* Network policies.
* Block logs and test results.
* Secret ID.
* Provider evidence.
