### The setting for access from DataLens is not active if not needed {#db-datalens-access}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.db-datalens-access ||
|#

#### Description

**How this rule works:** The rule automatically checks whether the "Access from DataLens" option is enabled on managed database clusters. It flags all clusters where this option is active. The rule does not verify whether the DataLens integration is actively used or whether it is needed for a legitimate business purpose.

Do not enable access to databases containing critical data from the management console, [DataLens](https://yandex.cloud/en/docs/datalens), or other services unless you have to. Access from DataLens may be required for data analysis and visualization. For such access, the Yandex Cloud service network is used, with authentication and TLS encryption. You can enable and disable access from DataLens or other services in the cluster settings or when creating it in the advanced settings section.

**Risks if the rule is not followed:** Enabling DataLens access to databases with critical data unnecessarily expands the attack surface. If a DataLens account or dashboard is compromised, an attacker can query sensitive data directly from the database. Unnecessary integrations also complicate access auditing and increase the number of paths through which data can be exfiltrated.

#### Instructions and solutions

1. In the [management console](https://console.yandex.cloud/), select the cloud or folder where you want to disable access from DataLens.
2. In the list of services, select the service(s) where the managed databases are located.
3. In the object settings, go to the **Additional settings** tab.
4. In the object's parameters, disable the **Access from DataLens** option.
