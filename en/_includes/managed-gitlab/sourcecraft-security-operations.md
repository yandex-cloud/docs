[Integrating {{ mgl-name }} with {{ src-name }} Security](../../managed-gitlab/concepts/sourcecraft-security.md) enables automatic scanning of code from the repositories of a [{{ GL }} instance](../../managed-gitlab/concepts/index.md#instance) for secrets and vulnerabilities in both dependencies and the code itself. Repositories are mirrored to {{ src-name }}. Checks are performed on mirrored repositories, and the [{{ src-name }} Security]({{ link-src-docs }}/sourcecraft/security/security-overview) features are available for them in their entirety.

{% include [sourcecraft-security-notes](sourcecraft-security-notes.md) %}

## Enabling integration {#enable}

### Enable the {{ src-name }} Security add-on to for your organization {#enable-security}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. Navigate to the **{{ ui-key.sourcecraft.lib.organizations_5CjkW }}** list and select the {{ yandex-cloud }} organization containing the {{ GL }} instance.
  1. On the organization's page, under ![image](../../_assets/console-icons/shield-exclamation.svg) **{{ ui-key.sourcecraft.mainApp.route_security_4Dbxc }}**, open the ![image](../../_assets/console-icons/circles-4-square.svg) **{{ ui-key.sourcecraft.mainApp.route_security-overview_dQuX9 }}** section.
  1. Make sure the {{ src-name }} Security add-on is enabled. If a prompt to enable the **Security** add-on appears instead of scan results, enable it for the selected organization.

      If a trial period is available, click **{{ ui-key.sourcecraft.appsec.paywall-action-billing_e7ueS }}** and follow the instructions in the UI. If you do not have permission to connect the add-on, contact your organization's administrator.

{% endlist %}

### Enable integration in the {{ GL }} instance settings {#enable-instance}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your {{ GL }} instance.
  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select your instance and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top-right corner of the page.
  1. Under **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.section_title }}**, enable **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.field_enable }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Wait for the instance update to complete: its status will switch from **Updating** to **Running**, and in the **{{ ui-key.yacloud.common.overview }}** section, the **{{ ui-key.yacloud.gitlab.field_sourcecraft-integration }}** field will show **Enabled**.

{% endlist %}

{% note tip %}

You can also enable integration when creating the [{{ GL }} instance](../../managed-gitlab/operations/instance/instance-create.md#create). First, connect the {{ src-name }} Security add-on to the organization where the instance will be created.

{% endnote %}

### Wait for the repositories to be mirrored {#check-mirroring}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the organization for which you have enabled the {{ src-name }} Security add-on.
  1. Navigate to the organization's repository list and wait for the mirrored repositories of the {{ GL }} instance to appear.

      Their names are derived from the path of the source repository, e.g., `test-group/test-subgroup/example-repo` is transformed into `test-group-test-subgroup-example-repo`. Learn more about [address transformation](../../managed-gitlab/concepts/sourcecraft-security.md#repository-paths).

{% endlist %}

{% note info %}

Scans are triggered when commits are pushed to the default [branch]({{ link-src-docs }}/sourcecraft/concepts/#repos) of the {{ GL }} source repository. Wait for the code to synchronize and the checks to complete, then [view the results](#results) in {{ src-name }}.

{% endnote %}

## Disabling integration {#disable}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your {{ GL }} instance.
  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select your instance and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top-right corner of the page.
  1. Under **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.section_title }}**, disable **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.field_enable }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Wait for the instance update to complete. Under **{{ ui-key.yacloud.common.overview }}**, the **{{ ui-key.yacloud.gitlab.field_sourcecraft-integration }}** field will switch to **Disabled**.

{% endlist %}

## Viewing scan results {#results}

The results are available in the [{{ src-name }} vulnerability control center]({{ link-src-docs }}/sourcecraft/operations/security-dashboard). To grant developers access to them, [invite users to the organization]({{ link-src-docs }}/sourcecraft/security/invite) and [assign roles]({{ link-src-docs }}/sourcecraft/security/bind) for the relevant repositories or the organization.

### All repositories {#org}

Select the organization where the {{ GL }} instance is located. Its vulnerability control center displays results for all repositories of this organization that are accessible to you.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  {% include [security-dashboard-org](../sourcecraft/security-dashboard-org.md) %}

{% endlist %}

### Specific repository {#repo}

Select the mirrored {{ src-name }} repository matching the source {{ GL }} repository.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  {% include [security-dashboard-repo](../sourcecraft/security-dashboard-repo.md) %}

{% endlist %}

#### Useful links {#see-also}

* [Integrating {{ mgl-name }} with {{ src-name }} Security](../../managed-gitlab/concepts/sourcecraft-security.md).
* [Scanning secrets]({{ link-src-docs }}/sourcecraft/operations/secret-scan).
* [Analyzing dependencies]({{ link-src-docs }}/sourcecraft/operations/supply-chain).
* [License policy as code]({{ link-src-docs }}/sourcecraft/operations/license-policy).
* [Static application security testing]({{ link-src-docs }}/sourcecraft/operations/sast).
* [AI-powered vulnerability analysis and prioritization]({{ link-src-docs }}/sourcecraft/operations/ca-triage).
* [Scan history]({{ link-src-docs }}/sourcecraft/operations/security-scan-history).
* [Setting up a custom security analyzer]({{ link-src-docs }}/sourcecraft/tutorials/custom-security-analyzers).
