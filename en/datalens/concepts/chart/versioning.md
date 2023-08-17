# Versioning

Chart versioning is the ability to store the history of chart configuration changes using versions. A list of versions is available to users with the lowest level of **{{ permission-read }}** access to the chart.

{% note info %}

Currently, versioning is only supported for [dataset-based](#dataset-based-charts) charts.

{% endnote %}

To go to the list of versions, click the ![image](../../../_assets/datalens/horizontal-ellipsis.svg) icon at the top of the screen and select **Change history**.

![image](../../../_assets/datalens/concepts/version-list.png)

To select a version from the list, click it. The version number will be displayed as the value of the `revId` parameter in the chart address string. Clicking on a link with the version number in the `revId` parameter will open the relevant version of the chart directly.

## Version types {#version-types}

The following distinct versions are available:

* **Actual**. The most recently saved version of a chart. All users can see chart versions on dashboards, as well as when directly navigating to charts or opening them for editing from the dashboard context menu. Only one version of a chart can be actual.

   ![image](../../../_assets/datalens/concepts/current-version.png)

   If a user has **{{ permission-write }}** permissions, they can make any chart version actual.

   {% note warning %}

   When updating any version, except a draft, a new chart version is created.

   {% endnote %}

* **Draft**. A version with unsaved chart changes. The main users do not see changes being made to a draft. This enables you to hide chart edits until a version update. A chart can only have one draft.

   ![image](../../../_assets/datalens/concepts/draft-version.png)

   To create a draft after editing a chart, click the down arrow in the upper-right corner and select **Save as draft**.

* **Not actual**. A version that is neither actual nor a draft.

   ![image](../../../_assets/datalens/concepts/old-version.png)

{% note tip %}

You can share any chart version by adding the `revId` parameter to the chart link, e.g., `?revId=zac5m4edoaqqr`.

{% endnote %}

## Creating a new version {#version-create}

A new version is automatically created when you click **Save and make actual** in chart edit mode. Here are the chart configuration changes that result in a new version:

* Changing chart settings that can be accessed by clicking ![image](../../../_assets/datalens/gear.svg) at the top of the screen.
* Adding, renaming, or deleting chart fields.
* Adding or deleting fields in chart sections.

## Limitations {#restrictions}

* The change history only contains a list of chart versions and includes: version type, save date and time, and the author of the edits.
* Chart versions don't include changes to access permissions (this operation is performed separately from chart edits).
* Versions do not display a list of changes. You can only view the saved status of the chart configuration.

