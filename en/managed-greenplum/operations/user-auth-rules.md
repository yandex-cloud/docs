# User authentication rules

[User authentication](../concepts/user-authentication.md) rules determine which users and from which addresses are allowed to connect to a cluster, as well as which databases they can access.

You can:

* [{#T}](#add-rules).
* [{#T}](#edit-rules).
* [{#T}](#replace-rule).
* [{#T}](#delete-rule).

{% note warning %}

The rule priority depends on the order of lines: rules are read from top to bottom with the first suitable rule applied. If authentication based on the first suitable rule fails, other rules are not applied.

{% endnote %}

## Adding rules {#add-rules}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/mgp-auth-user.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
   1. Click ![image](../../_assets/mdb/mgp-auth-user-add-rule.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** and set its parameters:

      {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

   1. To add another rule, click ![image](../../_assets/mdb/mgp-auth-user-add-rule.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** once again.
   1. Click **{{ ui-key.yacloud.common.save }}**.

   {% note info %}

   The default rule is added automatically at the end of the list; it allows authentication for all users in any database and from any host using the `md5` method (password-based authentication).

   {% endnote %}

{% endlist %}

## Editing rules {#edit-rules}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/mgp-auth-user.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}** and update the rule parameters:

      {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Moving a rule {#replace-rule}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/mgp-auth-user.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
   1. Click ![image](../../_assets/mdb/mgp-auth-user-replace-rule.svg) for the required rule and move it up or down.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting a rule {#delete-rule}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/mgp-auth-user.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
   1. Click ![image](../../_assets/options.svg) for the required rule and select **{{ ui-key.yacloud.common.delete }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
