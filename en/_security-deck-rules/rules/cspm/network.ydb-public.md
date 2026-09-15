### No public access to managed YDB {#ydb-public}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | network.ydb-public ||
|#

#### Description

{% note info %}

This rule does not apply to serverless databases.

{% endnote %}

Yandex Managed Service for YDB has two modes:

* **Dedicated** — a database deployed in your VPC. By default it is reachable only from the cloud network; a public endpoint can be enabled but is not required.
* **Serverless** — a database that is always available from the internet (the service handles routing and capacity for you). For serverless databases, the public endpoint is part of the service model and cannot be turned off.

For Dedicated databases, exposing the endpoint to the internet without a clear reason adds an unnecessary attack surface. For Serverless databases, the public endpoint should be considered when threat-modelling — access control rests entirely on database authentication and authorization.

See [Serverless and Dedicated modes](https://yandex.cloud/en/docs/ydb/concepts/serverless-and-dedicated) in the Managed Service for YDB documentation.

**Risks if the rule is not followed:** A publicly exposed Dedicated YDB endpoint can be targeted by brute-force attacks, vulnerability exploitation, or denial-of-service attacks directly from the internet. Without network-level restrictions, the database relies entirely on its own authentication mechanisms, which may be insufficient if credentials are weak or leaked.

#### Instructions and solutions

For Dedicated databases:

* Disable the public endpoint if it is not needed; access the database only from inside the VPC.
* If the public endpoint must stay enabled, treat the database the same way as a publicly reachable workload — restrict access at the database level and monitor authentication events.

For Serverless databases:

* Apply the principle of least privilege: grant each application or user only the database roles they really need.
* Use service accounts for application connections and store their credentials in [Lockbox](https://yandex.cloud/en/docs/lockbox/).
