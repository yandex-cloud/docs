{#ai-supply6-id}

Requirement ID: `AI-SUPPLY6`

{#ai-supply6-requirement}

**Requirement**

The owner must identify official channels and public sources for provider security notifications. They must monitor and act on alerts regarding compromises, critical vulnerabilities, revocations, terms-of-service updates, or unavailability of a model, data, library, image, or external API. This procedure must enable you to pinpoint affected releases, restrict usage, replace a component, and repeat relevant checks.

{#ai-supply6-implementation}

**Implementation**

For an external service, updates to the API, model, processing region, retention terms, and telemetry must be tracked. {{ yandex-cloud }} does not manage permissions and lifecycles for external providers unless a specific integration is explicitly documented. [{{ sd-name }}](../../../../security-deck/index.yaml) and [{{ ycdr-name }}](../../../../ycdr/index.yaml) only process incoming signals within a configured environment and do not replace provider monitoring.

{#ai-supply6-manual-check}

**Manual check**

Take a test notification about a revoked version and trace the response: search of affected systems, restriction decision, replacement, and repeating the check. The registry must allow you to do this by the exact version, not just the product name. Simulating an update to a version, notification, or endpoint should trigger a new check and prevent silent production drift. The system must never run an unknown version without notice.

{#ai-supply6-artifacts}

**Artifact**

* Test notification.
* Search for systems.
* Restriction decision.
* Affected release manifests.
* Ticket.
