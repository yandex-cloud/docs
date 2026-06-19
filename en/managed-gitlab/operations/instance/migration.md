# Migrating from {{ GL }} to {{ mgl-name }}

You can migrate your projects to {{ mgl-name }} using the following methods:
* [{#T}](#self-migration): You export each project individually from the source {{ GL }} and import them into {{ mgl-name }} without involving support. This migrates the main entities: repositories, issues with comments, merge requests, labels, milestones, wiki, and CI/CD pipelines as archives. CI/CD variables, webhooks, pipeline triggers, artifacts, and job logs are not migrated.
* [{#T}](#support-migration): Support restores the {{ mgl-name }} instance from a backup of your custom installation. This migrates all data and settings, including projects, users, [groups]({{ gl.docs }}/user/group/), access permissions, and pipelines.

## Self-migration {#self-migration}

This method works well for migration of projects from any {{ GL }}, including {{ GL }}.com, a dedicated {{ GL }}.com instance, and self-managed installations.

1. Export your project from the source {{ GL }} instance:
    1. Open the project in the source {{ GL }}.
    1. In the left-hand menu, select **Settings** → **General**.
    1. Expand the **Advanced** section.
    1. Click **Export project**.
    1. Wait for an email containing the export archive link or refresh the settings page and click **Download export** under **Export project**.
1. [Create a {{ mgl-name }} instance](instance-create.md).
1. By default, {{ mgl-name }} instances restrict import from external sources. To enable it:
    1. Open the {{ GL }} admin panel.
    1. Go to **Admin Area** → **Settings** → **General**.
    1. Expand **Import and export settings**.
    1. Make sure the **GitLab export** source is enabled under **Allowed import sources**. If this source is not there, add it manually.
    1. Click **Save changes**.
1. Import a project to the {{ mgl-name }} instance:
    1. In the top-right corner, click ![image](../../../_assets/console-icons/plus.svg) **Create new...** and select **New project/repository**.
    1. Select **Import project**.
    1. Under **Import project from**, select **GitLab export**.
    1. Enter project name and URL, then select the export file you go in the previous step.
    1. Click **Import project**.
1. Migrate {{ GL }} projects one at a time.

For more information, see these {{ GL }} guides:
* [Import and export settings]({{ gl.docs }}/administration/settings/import_and_export_settings/)
* [Migrate {{ GL }} data by using file exports]({{ gl.docs }}/user/project/settings/import_export/)

## Support-assisted migration {#support-migration}

Before you begin, see [how to run migration](../../concepts/migration.md) from a custom {{ GL }} installation to {{ mgl-name }}.

{% note info %}

The migration feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To migrate data to a {{ mgl-name }} instance:
1. [Create a {{ mgl-name }} instance](instance-create.md).
1. Apply the same configuration to your {{ mgl-name }} instance as in your custom installation, such as [OmniAuth]({{ gl.docs }}/integration/omniauth) or [group access restrictions]({{ gl.docs }}/user/group/access_and_permissions). Entities such as users, groups, and pipelines are migrated later when using your custom installation backup.
1. Find out the {{ GL }} version of your custom installation. For correct migration, the custom installation version must match the {{ mgl-name }} version.

   1. Open your custom {{ GL }} installation.
   1. In the left-hand menu, click **Help**.

      A pop-up window will display the {{ GL }} version.

1. Test the migration:

   1. [Back up]({{ gl.docs }}/administration/backup_restore/backup_gitlab#simple-back-up-procedure) your custom installation and configuration files.
   1. [Provide the support team]({{ link-console-support }}) with the backup and {{ GL }} version of your custom installation. The support team will restore the instance from your backup in {{ mgl-name }}.
   1. Once support confirms the instance restoration in {{ mgl-name }}, [open it](instance-list.md#get) and make sure:

      * It contains all settings, data, and projects you need.
      * You can push commits and update branches.

1. Perform the production migration:

   1. Notify support of your planned migration date.
   1. On the day before the migration, [switch your custom {{ GL }} installation]({{ gl.docs }}/administration/read_only_gitlab) to `Read only` mode.
   1. Back up your custom installation and configuration files.
   1. Provide this backup to the support team.
   1. On the specified migration date, the support team will restore your instance from the provided backup in {{ mgl-name }}.

1. Optionally, configure the instance domain name:

   1. If you used a [custom domain name]({{ gl.docs }}/administration/dedicated/configure_instance/network_security/#custom-domains) for your custom installation and want to keep it, provide that domain name to the support team. They will configure it for your {{ mgl-name }} instance.
   1. In your custom installation, [configure]({{ gl.docs }}/omnibus/settings/dns/) a `CNAME` DNS record to forward users from the {{ mgl-name }} [instance domain](../../concepts/index.md#config) to your custom domain.

### See also {#see-also}

* [{#T}](../../concepts/migration.md)
* [{#T}](../../concepts/index.md)
* [{#T}](instance-create.md)
* [{#T}](instance-list.md)

### {{ GL }} guides {#gl-docs}

* [Import and export settings]({{ gl.docs }}/administration/settings/import_and_export_settings/)
* [Migrate {{ GL }} data by using file exports]({{ gl.docs }}/user/project/settings/import_export/)
* [Groups]({{ gl.docs }}/user/group/)
* [OmniAuth]({{ gl.docs }}/integration/omniauth)
* [Group access and permissions]({{ gl.docs }}/user/group/access_and_permissions)
* [Back up GitLab]({{ gl.docs }}/administration/backup_restore/backup_gitlab)
* [Place GitLab into a read-only state]({{ gl.docs }}/administration/read_only_gitlab)
* [GitLab Dedicated network access and security]({{ gl.docs }}/administration/dedicated/configure_instance/network_security/)
* [DNS settings]({{ gl.docs }}/omnibus/settings/dns/)
