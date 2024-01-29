# Migration from {{ GL }} to {{ mgl-name }}

Before starting, check the [procedure for running](../../concepts/migration.md) migration from a {{ GL }} custom installation to {{ mgl-name }}.

{% note info %}

The migration service is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To migrate data to the cloud:

1. [Create a {{ mgl-name }} instance](instance-create.md).
1. Add to the {{ mgl-name }} instance the same settings that are in the custom installation. For example, [OmniAuth]({{ gl.docs }}/ee/integration/omniauth.html) or [group access rights restrictions]({{ gl.docs }}/ee/user/group/access_and_permissions.html) if you used them. Such entities as users, groups, and pipelines will be migrated later when working with a backup of your custom installation.
1. Find out your custom installation's {{ GL }} version. For correct migration, the custom installation version must match the {{ mgl-name }} version.

   1. Open your {{ GL }} custom installation.
   1. In the menu on the left, click **Help**.

      A pop-up window will display the {{ GL }} version.

1. Test the migration:

   1. [Create a backup]({{ gl.docs }}/ee/administration/backup_restore/backup_gitlab.html#simple-back-up-procedure) of the custom installation and configuration files.
   1. [Provide to the technical support]({{ link-console-support }}) this backup and your custom installation's {{ GL }} version. The technical support will restore the instance from your backup in {{ mgl-name }}.
   1. After the support reports that the instance has been restored, [open it](instance-list.md#get) and make sure that in {{ mgl-name }}:

      * All necessary settings, data, and projects are present.
      * You can send commits and update branches.

1. Perform the production migration:

   1. Inform the technical support of your planned migration date.
   1. On the eve of the migration day, [place your {{ GL }} custom installation]({{ gl.docs }}/ee/administration/read_only_gitlab.html) into a read-only state.
   1. Back up your custom installation and configuration files.
   1. Provide this backup to the technical support.
   1. On the specified migration day, the technical support will restore your instance from the backup in {{ mgl-name }}.

1. (Optional) Configure your instance domain name:

   1. If you used a [custom domain name]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/) for your custom installation and want to keep it, please provide that domain name to the technical support. They will configure it for your {{ mgl-name }} instance.
   1. In your custom installation, [configure a `CNAME` DNS record]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/#for-subdomains) to redirect users from the {{ mgl-name }} [instance domain](../../concepts/index.md#config) to your custom domain.
