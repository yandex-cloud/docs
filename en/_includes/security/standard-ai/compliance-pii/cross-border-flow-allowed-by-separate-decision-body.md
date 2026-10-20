{#ai-comply4-id}

Requirement ID: `AI-COMPLY4`

{#ai-comply4-applicability}

**Scope**

The requirement applies if data, a backup, log, model request, model results, or any other component of the workflow may cross a boundary defined by applicable law or an internal placement policy.

{#ai-comply4-risk}

**Risk**

Cross-border transfer carried out without complying with applicable procedures, notifications, or contractual or organizational requirements may result in a law violation and regulatory action.

{#ai-comply4-requirement}

**Requirement**

Prior to the initiation of a cross-border flow, authorized representatives of the organization responsible for legal matters or compliance must determine and approve the following:

* Occurrence of a cross-border transfer in a specific scenario.
* Countries, recipients, subcontractors, and end points.
* Categories, composition, target, and legal basis of the transfer.
* Applicable prohibitions, restrictions, approvals, notifications, and contractual terms.
* Requirements for protection, retention periods, deletion, and implementation of subject permissions.
* The decision's validity period and the events requiring its re-evaluation.

The technical team must follow the authorized representatives' decision and align it with the resources, routes, and endpoint from `AI-COMPLY2` and `AI-COMPLY3`. The presence of TLS, the choice of region, or a contract not reviewed by authorized representatives does not in itself constitute confirmation of legal admissibility.

For each flow, the following are specified: sender and recipient, data fields and data class, source and target locations, transport, storage and onward transmission, and solution ID. Allowlists for recipients and destinations with a default-deny policy are applied during resource creation and to outbound traffic; unknown or modified endpoints, regions, or recipients are blocked.

An internal flow across the border does not, in itself, constitute a legal conclusion regarding a cross-border transfer.

{#ai-comply4-check}

**Check**

1. Select one outbound data flow and map the country, recipient, data categories, endpoint, subcontractors, and timeframe against the current solution.
1. Verify that changing the supplier region, destination, subcontractor, or data composition blocks the flow until a new decision is made, if the previous decision does not cover the change.
1. Make sure the cross-border flow details are aligned with the architecture map and the recipient registry.
1. If the processing location or subsequent recipient is unknown, the flow halts until reputable information is received; no assumptions are made.

{#ai-comply4-artifacts}

**Artifact**

* Legal and compliance assessment.
* Confirmation of required procedures.
* Register of cross-border flows.
* Architectural schema.
* Endpoint configuration and changelog.
* Registry of flows with solution IDs.
* Failure of an unknown line.
