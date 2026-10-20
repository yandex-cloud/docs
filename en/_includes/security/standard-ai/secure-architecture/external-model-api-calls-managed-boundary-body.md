{#ai-net3-id}

Requirement ID: `AI-NET3`

{#ai-net3-requirement}

**Requirement**

If the AI system calls a model API outside {{ yandex-cloud }}, the owner must define the allowed endpoints, types of transmitted data, service account or another workload identity, secret storage location, route, timeouts, and logging. The application must exclude any unapproved recipient and must not transmit data lacking the required authorization. The list of recipients and transmitted data categories must be reviewed whenever the provider, model, processing region, contract, data schema, or network path changes.

The provider key must be stored within a dedicated storage in compliance with `AI-SECRET1`; however, its scope, expiration, and revocation must be verified in the provider system. The {{ iam-short-name }} policy does not create a private network path to an external provider; such a path may only be claimed when documented officially by the provider.

The {{ vpc-full-name }} route table and NAT gateway define the network path, but they do not by themselves filter the domain name, recipient, or request content. For the documented properties of the routes and next hop, see the [{{ vpc-short-name }} routing description](../../../../vpc/concepts/routing.md). Where recipient restrictions are required, the organization must implement them through an appropriate proxy, firewall, or application and verify the actual TLS endpoint.

{#ai-net3-check}

**Check**

1. Make one allowed call and one call to a non-whitelisted test endpoint.
1. Check the route, DNS/TLS destination, absence of the secret in the log, and the correlation between the application record and the external request.

Whether the data may be transmitted is verified separately according to [{#T}](../../../../security/standard-ai/compliance-pii.md). The denied call must not appear in the provider’s log; any credentials exposed during the check must be rotated and must not be reinstated.

{#ai-net3-artifacts}

**Artifact**

* Proxy and firewall configuration.
* Allowed and denied call record.
* Secret ID.
* Call correlation log.
