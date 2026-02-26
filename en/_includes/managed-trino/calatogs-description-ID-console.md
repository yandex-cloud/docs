Optionally, in the **{{ ui-key.yacloud.trino.label_rbac-catalog-access }}** field, specify the catalogs the rule applies to:
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-id }}**: Select catalog IDs. You can only select catalogs existing in the cluster.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}**: Select catalog names. You can only select catalogs existing in the cluster.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}**: Enter a regular expression. The rule applies to the catalogs whose names match the regular expression.
* **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}**: Rule applies to all catalogs in the cluster.
