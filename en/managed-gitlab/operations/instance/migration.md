# Migrating from {{ GL }} to {{ mgl-name }}

Before you begin, see [how to run migration](../../concepts/migration.md) from a custom {{ GL }} installation to {{ mgl-name }}.

{% note info %}

The migration feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To migrate data to your cloud:

1. [Create a {{ mgl-name }} instance](instance-create.md).
1. Apply the same configuration to your {{ mgl-name }} instance as in your custom installation, such as [OmniAuth]({{ gl.docs }}/ee/integration/omniauth.html) or [group access restrictions]({{ gl.docs }}/ee/user/group/access_and_permissions.html). Entities such as users, groups, and pipelines are migrated later when using your custom installation backup.
1. Find out the {{ GL }} version of your custom installation. For correct migration, the custom installation version must match the {{ mgl-name }} version.

   1. Open your custom {{ GL }} installation.
   1. In the left-hand menu, click **Help**.

      A pop-up window will display the {{ GL }} version.

1. Test the migration:

   1. [Back up]({{ gl.docs }}/ee/administration/backup_restore/backup_gitlab.html#simple-back-up-procedure) your custom installation and configuration files.
   1. [Provide the support team]({{ link-console-support }}) with the backup and {{ GL }} version of your custom installation. The support team will restore the instance from your backup in {{ mgl-name }}.
   1. Once support confirms the instance restoration in {{ mgl-name }}, [open it](instance-list.md#get) and make sure:

      * It contains all settings, data, and projects you need.
      * You can push commits and update branches.

1. Perform the production migration:

   1. Notify support of your planned migration date.
   1. On the day before the migration, [switch your custom {{ GL }} installation]({{ gl.docs }}/ee/administration/read_only_gitlab.html) to read-only mode.
   1. Back up your custom installation and configuration files.
   1. Provide this backup to the support team.
   1. On the specified migration date, the support team will restore your instance from the provided backup in {{ mgl-name }}.

1. Optionally, configure the instance domain name:

   1. If you used a [custom domain name]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/) for your custom installation and want to keep it, provide that domain name to the support team. They will configure it for your {{ mgl-name }} instance.
   1. In your custom installation, [configure]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/#for-subdomains) a `CNAME` DNS record to forward users from the {{ mgl-name }} [instance domain](../../concepts/index.md#config) to your custom domain.
