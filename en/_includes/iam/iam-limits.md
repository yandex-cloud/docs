#### Quotas {#iam-quotas}

#|
|| Type of limit | Value ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessBindings.count }} in cloud^1^
`iam.accessBindings.count` | 1,000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessBindings.count }} in organization^1^
`iam.accessBindings.count` | 2,000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.oidcWLIFederations.count }}
`iam.oidcWLIFederations.count` | 50 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.saFederatedCredentials.count }}
`iam.saFederatedCredentials.count` | 200 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.serviceAccounts.count }} per cloud
`iam.serviceAccounts.count` | 100 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.apiKeys.count }} per cloud
`iam.apiKeys.count` | 1,000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.authorizedKeys.count }} per cloud
`iam.authorizedKeys.count` | 1,000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessKeys.count }} per cloud
`iam.accessKeys.count` | 1,000 ||
|#

^1^ The quota considers not only the federated credentials for the cloud or organization itself but also all federated credentials for their enclosed resources; therefore, the organization quota can never be less than the cloud quota.


#### Limits {#iam-limits}

There are no limits for {{ iam-name }}.
