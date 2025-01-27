---
title: Dashboard versioning
description: 'Dashboard versioning is the ability to store the history of dashboard configuration changes using versions. A list of versions is available to users with the lowest level of access to the dashboard: **View**.'
---

# Versioning

Dashboard versioning is the ability to store the history of dashboard configuration changes using versions. A list of versions is available to users with the lowest level of access to the dashboard: **View**.

To go to the list of versions, click the ![image](../../_assets/console-icons/ellipsis.svg) icon at the top of the screen and select **Change history**.

![image](../../_assets/datalens/concepts/version-list.png)

To select a version from the list, click it. The version number will be displayed in the `revId` parameter in the dashboard address string. Click a link with the version number in the `revId` parameter to open the relevant version of the dashboard.

## Version types {#version-types}

All versions fall into the following types:

* **Current**: The most recent saved version of a dashboard. It is displayed for all users that open the dashboard for viewing from the navigation bar. Only one version of a dashboard can be current.
  
  ![image](../../_assets/datalens/concepts/current-version.png)
  
* **Draft**: A version with unsaved dashboard changes. Common users do not see changes being made to a draft. This enables you to hide dashboard edits until a version update. A dashboard can only have one draft.

  ![image](../../_assets/datalens/concepts/draft-version.png)

* **Outdated**: This is a version that is neither current nor a draft.

  ![image](../../_assets/datalens/concepts/old-version.png)

## Creating a new version {#version-create}

A new version is automatically created when you click **Save** in dashboard edit mode. Dashboard configuration changes that result in a new version:

* Changing dashboard settings accessible by clicking ![image](../../_assets/console-icons/gear.svg) at the top of the screen.
* Adding, renaming, or deleting dashboard tabs.
* Editing links.
* Adding and removing widgets.
* Editing widgets, such as [Title](#title) and [Text](#text).
* Editing widget tabs.
* Editing selector settings.

## Limitations {#restrictions}

* The change history only contains a list of dashboard versions and includes: version type, save date and time, and the author of the edits.
* Dashboard versions do not include:

  * Access permission changes (this operation is separate from editing the dashboard itself).
  * Chart setting changes, that is, changes made from the Wizard, QL Chart, or Editor.
  * Changes to dataset settings made from the dataset interface.
  * Changes to connection settings made using the interface for editing connection parameters.
  * Data changes to the source (rows added, updated, or deleted in the data source).

* Versions do not display a list of changes. You can only view the saved status of the dashboard configuration.
