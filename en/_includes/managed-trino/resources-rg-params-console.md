1. Optionally, select a parent group.
1. Specify a name for the resource group.

   A group name can be a template that uses variable placeholders in `${<variable_name>}` format. A template name may contain the following types of variables:
   * Built-in variables. `USER` for username, `SOURCE` for query source.
   * User-defined variables. These are declared in selector rule properties: **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user_3spf1 }}** and **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_source_5knZL }}**.

   When routing queries, {{ mtr-name }} will create group instances with dynamically generated names.

1. In the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_max-queued_aj14k }}** field, set the maximum number of queries per queue (must be higher than `1`). Once this limit is reached, new queries will be rejected with an error.
1. Optionally, set a soft limit on the number of running queries in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-concurrency-limit_j5KQC }}** field. Once the limit is reached, the group will run new queries only if sibling groups are unable to accept queries or are above their soft limits. Otherwise, new queries will be queued.
1. In the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-concurrency-limit_hjuBf }}** field, set the maximum number of running queries (must be higher than `1`). Once this limit is reached, new queries will be queued.
1. Optionally, set the maximum amount of memory available to the group in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-memory-limit_1mATZ }}** field. Once this limit is reached, new queries will be queued.
1. Optionally, set a soft limit on CPU time in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-cpu-limit_aUwE5 }}** field. Once this limit is reached, the maximum number of running queries will be reduced until the end of the current CPU quota calculation period. This value cannot be greater than **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}**. To set **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-cpu-limit_aUwE5 }}**, you also need to set **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}**.
1. Optionally, set a hard limit on CPU time in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}** field. Once this limit is reached, new queries will be queued. To set **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}**, you also need to set **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}**.
1. Optionally, set a [query scheduling policy](../../managed-trino/concepts/resource-groups.md#policy) in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_scheduling-policy_5vhLX }}** field. The possible values are `fair`, `weighted`, `weighted_fair`, or `query_priority`. The default value is `none` (the `fair` policy applies).
1. Optionally, set the group weight used in the `weighted` and `weighted_fair` scheduling policies in the **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_scheduling-weight_fP1ue }}** field.

Learn more about group trees in [{#T}](../../managed-trino/concepts/resource-groups.md).
