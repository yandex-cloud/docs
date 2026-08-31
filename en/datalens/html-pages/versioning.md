---
title: HTML page versioning in {{ datalens-full-name }}
description: In this article, you will learn about HTML page versioning and version types in {{ datalens-short-name }}.
---

# Versioning

HTML page versioning means maintaining the history of your HTML page edits through versions.

To go to the list of versions, click ![image](../../_assets/console-icons/ellipsis.svg) at the top of the screen and select ![image](../../_assets/console-icons/clock.svg) **Change history**.

To select a version from the list, click it. The version number will be displayed in the `revId` parameter in the report address string. Click a link with the version number in the `revId` parameter to open the relevant version of the report.

## Version types {#version-types}

All versions fall into the following types:

1. **Actual**: The last saved version.

   This version is displayed:
   
   * When you go to an HTML page via a link.
   * When you go to an HTML page from navigation.
   * When you open an HTML page in a workbook.
   
   An HTML page can have only one actual version.

   With the **{{ permission-write }}** permission, the user can make any HTML page version actual.
  
   {% note warning %}
  
   When a version is actualized, a new HTML page version is created.

   {% endnote %}
  
1. **Outdated**: Version that is no longer actual.  
   When you open an outdated version, you see a panel at the top stating version type, creation date and time, and the version author's login. There are buttons in the right-hand panel:

   * **Make actual**: Turns an outdated version into the current one. The version actual at the time will become outdated.
   * **Open actual**: Opens the current version.

{% note tip %}

You can share any HTML page version by adding the `revId` parameter to the HTML page link, e.g., `?revId=zac5m4edoaqqr`.

{% endnote %}

## Creating a new version {#version-create}

A new version is automatically created:

* After you [upload a new HTML page version](./index.md#html-change).
* In outdated HTML page version view mode, after you click **Make actual**.

## Limits {#restrictions}

* You can only get the change history for the last three months.
* The change history contains only a list of HTML page versions and includes version type, save date and time, and the author of the edit.
* HTML page versions do not include changes to access permissions; this operation is performed separately from HTML page edits.
* Versions do not display the list of changes. You can only view the saved state of the HTML page.
