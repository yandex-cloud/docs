{#profile-external-api-applicability}

**Scope and status**

This profile applies when a request leaves {{ yandex-cloud }} and goes to a model provider or AI API. {{ iam-short-name }} does not manage the provider account.

{#profile-external-api-flow}

**Flow and trust boundaries**

`runtime in {{ yandex-cloud }} → NAT/proxy/firewall → provider DNS/TLS endpoint → external API → response`. The data transfer boundary comes before the outbound request, and the response is treated as untrusted again.

{#profile-external-api-authentication}

**Workload identity and authentication**

A {{ yandex-cloud }} service account gets external credentials from an approved storage. The provider account, its roles and their revocation status are verified in the provider's system against approved contractual and technical documentation, not in {{ iam-short-name }}.

{#profile-external-api-roles}

**Roles and scope**

The runtime only requires specifying the {{ yandex-cloud }} roles for {{ lockbox-short-name }}, log, proxy, and other {{ yandex-cloud }} resources in use. External key permissions are documented separately for each operation and provider model.

{#profile-external-api-network}

**Network**

The {{ vpc-short-name }} route, NAT, proxy or firewall, DNS, and TLS endpoint being verified are recorded. [{{ vpc-short-name }} routing](../../../../vpc/concepts/routing.md) verifies the next hop, but not the list of allowed FQDNs or contents. The recipient restriction is implemented at the proxy, firewall, or application layer and verified by sending a negative test request.

{#profile-external-api-secrets}

**Secrets and credentials**

API keys, mTLS keys, or other credentials are stored in {{ lockbox-short-name }} or other approved dedicated storage. When using {{ lockbox-short-name }}, the documented delivery path for the selected runtime is taken from its profile. The owner, ID, and version of the secret are recorded, along with its expiration, rotation, and revocation status; the secret value is not recorded.

{#profile-external-api-configuration}

**Configuration objects**

Model provider and endpoint, DNS/TLS, proxy or firewall route, schema of transmitted fields, credential reference, timeout, retries, circuit breaker, quota, correlation ID, as well as declared processing region, retention period, and subcontractors.

{#profile-external-api-telemetry}

**Telemetry and blind spots**

Application and proxy logs, along with {{ monitoring-short-name }}, cover the observable client path. {{ at-name }} shows only related {{ yandex-cloud }} operations, such as accessing a secret or updating a route, but not provider-side request processing.

{#profile-external-api-checks}

**Positive and negative checks**

1. Send an allowed request with synthetic data.
1. Send a request to an unapproved host name and a call using revoked credentials. Make sure DNS/TLS rejects both.
1. Test the behavior under repeated failures or exceeded limits, and when submitting an extra field.
1. Correlate the application and proxy logs without attributing the external revocation to {{ iam-short-name }}.

{#profile-external-api-inputs}

**What you need for profile implementation**

* Architecture: provider, endpoint, runtime, route, and fallback path.
* Policy: list of allowed recipients, timeouts, retries, quotas, and logged fields.
* Legal approach: legal framework, personal data, retention period and storage location, cross-border transfers, and subcontractors.
