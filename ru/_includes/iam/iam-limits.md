#### Квоты {#iam-quotas}

#|
|| Вид ограничения | Значение ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessBindings.count }} в облаке^1^
`iam.accessBindings.count` | 1 000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessBindings.count }} в организации^1^
`iam.accessBindings.count` | 2 000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.oidcWLIFederations.count }}
`iam.oidcWLIFederations.count` | 50 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.saFederatedCredentials.count }}
`iam.saFederatedCredentials.count` | 200 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.serviceAccounts.count }} в одном облаке
`iam.serviceAccounts.count` | 100 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.apiKeys.count }}  в одном облаке
`iam.apiKeys.count` | 1 000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.authorizedKeys.count }}  в одном облаке
`iam.authorizedKeys.count` | 1 000 ||
|| {{ ui-key.yacloud_quotas.quotas.iam.accessKeys.count }}  в одном облаке
`iam.accessKeys.count` | 1 000 ||
|#

^1^ Квота учитывает не только привязки на само облако или организацию, но и все привязки на вложенные в них ресурсы, поэтому квота организации всегда не меньше квоты облака.


#### Лимиты {#iam-limits}

Лимиты для сервиса {{ iam-name }} не определены.
