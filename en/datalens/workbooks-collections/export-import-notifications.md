---
title: Errors and warnings during export and import
description: This page lists errors and warnings during export and import and their descriptions.
---

# Errors and warnings during export and import

During [export and import of workbooks](./export-and-import.md), you may get operation-specific warnings and error messages.

## During export {#export-notifications}

#### In connections, the password and token field values are not exported. After import, you need to check and replace them as needed {#export-passwords}

When exporting, the values of password and token fields in connections are replaced with temporary values. Therefore, when importing, you will need to check this data for correctness and update it if needed.

#### RLS is not guaranteed to work correctly in exported datasets {#export-rls}

Check RLS for correct operation and reconfigure it if needed.

#### Workbook configuration is disrupted {#export-config-error}

Critical error. In {{ datalens-short-name }}, each entity has required fields with prescribed formats. The error indicates missing required fields or wrong data type. Fix the configuration or try re-exporting the workbook.

#### Workbook contains objects with incorrect type {#export-object-type-error}

It is likely that the workbook configuration was edited and some objects got wrong types. For example, the `Chart` type was set for a dashboard. Fix the configuration or try re-exporting the workbook.

#### {{ datalens-short-name }} installation does not support the workbook configuration {#export-installation-error}

The chart or dashboard version is not compatible with the {{ datalens-short-name }} installation you are importing into. For example, you export from a new {{ datalens-short-name }} cloud version into an obsolete {{ datalens-short-name }} open source version.

#### Workbook contains objects linked to non-existent objects {#export-bad-links}

The exported workbook has charts or dashboards linked with objects that are not in the workbook. The export is not interrupted in this case. When importing, check the object links and set the correct ones if needed.

#### Operation was interrupted due to an unknown error {#export-critical-error}

A critical error was detected which caused the current operation to be interrupted. Try re-exporting the workbook.

#### Objects of this type are not available for export and import {#export-object-type}

Some object types are not available for import and export, see the [Restrictions](./export-and-import.md#restrictions) section for details.

#### Some connection types are not supported in the current {{ datalens-short-name }} version {#export-connection-type}

The error may occur when exporting connections between different {{ datalens-short-name }} installations, connections with incorrect type, or connections that are no longer supported.

#### Failed to export the dataset {#export-dataset-error}

An unknown error occurred when attempting to export the dataset. For example, datasets with missing connections are not available for export. Check the dataset settings and try re-exporting the workbook.

#### Failed to export the connection {#export-connection-error}

An unknown error occurred when attempting to export the connection. Try re-exporting the workbook.

#### Unknown error {#export-unknown-error}

Error code and severity are unknown. Try re-exporting the workbook.

## During import {#import-notifications}

#### Check the connection settings and re-enter passwords and tokens if needed {#import-passwords}

In connections, password and token field values are not exported. Note that the configuration file may have been modified and updated with current values. Therefore, after the import is complete, check the data for correctness and update it if needed.

#### Make sure that RLS works correctly in the datasets {#import-rls}

Check RLS for correct operation and reconfigure it if needed.

#### There are objects in the workbook that are not supported in your {{ datalens-short-name }} installation {#import-object-not-supported}

For example, when importing a workbook containing a report or chart in Editor into an open source {{ datalens-short-name }} installation where they are not available.


#### Connection setup is not complete, change or re-save the connection settings {#import-connection}

When importing connections using a {{ connection-manager-name }} service account or connection, {{ datalens-short-name }} cannot complete configuring the new connection. After importing, re-save such connections without changing the settings.


#### Workbook configuration is disrupted {#import-config-error}

Critical error. In {{ datalens-short-name }}, each entity has required fields with prescribed formats. The error indicates missing required fields or wrong data type. Fix the configuration or try re-exporting the workbook.

#### Workbook contains objects with incorrect type {#import-object-type-error}

It is likely that the workbook configuration was edited and some objects got wrong types. For example, the `Chart` type was set for a dashboard. Fix the configuration or try re-exporting the workbook.

#### {{ datalens-short-name }} installation does not support the workbook configuration {#import-installation-error}

The chart or dashboard version is not compatible with the {{ datalens-short-name }} installation you are importing into. For example, you export from a new {{ datalens-short-name }} cloud version into an obsolete {{ datalens-short-name }} open source version.

#### Workbook contains objects linked to non-existent objects {#import-bad-links}

The imported workbook has charts or dashboards linked with objects that are not in the workbook. Check the object links and set the correct ones if needed.

#### Operation was interrupted due to an unknown error {#import-unknown-error} {#import-critical-error}

A critical error was detected which caused the current operation to be interrupted. Try re-importing the workbook.

#### Objects of this type are not available for export and import {#import-object-type}

Some object types are not available for import and export, see the [Restrictions](./export-and-import.md#restrictions) section for details.

#### Some connection types are not supported in the current {{ datalens-short-name }} version {#import-connection-type}

The error may occur when importing connections between different {{ datalens-short-name }} installations, connections with incorrect type, or connections that are no longer supported.

#### Failed to import the dataset {#import-dataset-error}

An unknown error occurred when attempting to import the dataset. For example, datasets with missing connections are not available for import. Check the dataset settings and try re-importing the workbook.

#### Failed to import the connection {#import-connection-error}

An unknown error occurred when attempting to import the connection. Try re-importing the workbook.

#### Unknown error {#import-unknown-error}

Error code and severity are unknown. Try re-importing the workbook.
