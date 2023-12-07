# Versions

Versioning is usually used for development issues. It helps you to group issues that belong to the same product version. Version values can be configured on the queue page.

To assign a version to an issue, fill in the **{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }}** or **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}** field on the issue page.

The **{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }}** field indicates the version of the product or package that contains the bug.

The **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}** field is used to plan your work. You can use this field to classify your issues between product versions or releases.

## Creating a version {#create-version}

To create a new version:

1. Open the queue page.

1. In the top-right corner of the page, select ![](../../_assets/horizontal-ellipsis.svg) **Queue actions** → ![](../../_assets/tracker/svg/versions.svg) **Versions**.

1. Click **Create version**.

1. Enter the version **Name**.

1. If you need it, specify the start and end dates and add the version description. These fields are informative.

1. Click **Create**.

## Switching versions {#edit-version}

To change the existing version:

1. Open the queue page.

1. In the top-right corner of the page, select ![](../../_assets/horizontal-ellipsis.svg) **Queue actions** → ![](../../_assets/tracker/svg/versions.svg) **Versions**.

1. Hover the cursor over the version.

1. Select ![](../../_assets/tracker/svg/settings-old.svg) → **Edit**.

1. Make your changes and click **Save**.

## Version statuses {#version-statuses}

An any version can have one of the following statuses:

- **Open**: Usually used for labeling versions that have not yet been worked on.

- **Release**: This product version is approved for release.

- **Archived**: This version is no longer supported.

By default, the **Versions** tab only shows open versions. You can change the display mode by using quick filters on the version list.

Make sure to update your version statuses so that you and your colleagues always have the current picture.

To change a version's status:

1. Open the queue page.

1. In the top-right corner of the page, select ![](../../_assets/horizontal-ellipsis.svg) **Queue actions** → ![](../../_assets/tracker/svg/versions.svg) **Versions**.

1. Hover the cursor over the version.

1. Click the ![](../../_assets/tracker/svg/settings-old.svg) icon and select a new status.

## Subscribing to a version {#subscribe-version}

If you want to get notified about changes in issues linked to a specific version, you can subscribe to such a version:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, select ![](../../_assets/horizontal-ellipsis.svg) **Queue actions** → ![](../../_assets/tracker/svg/versions.svg) **Versions**.

1. Hover the cursor over the version.

1. Select ![](../../_assets/tracker/svg/settings-old.svg) → **Subscribe**.

If you did everything right, you'll see the following icon next to the version number: ![](../../_assets/tracker/subscribtion.png)

## Viewing issues for a version {#section_l31_brz_xz}

You can view a list of issues that belong to a specific version:

1. Open the queue page.

1. In the top-right corner of the page, select ![](../../_assets/horizontal-ellipsis.svg) **Queue actions** → ![](../../_assets/tracker/svg/versions.svg) **Versions**.

1. Click the version number.
