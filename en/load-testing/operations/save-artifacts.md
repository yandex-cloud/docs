---
title: Saving test artifacts to {{ objstorage-name }}
description: Follow this guide to save test artifacts to {{ objstorage-name }}.
---

# Saving test artifacts to {{ objstorage-name }}

Configure the saving of test artifacts to {{ objstorage-full-name }}. You can use artifacts to analyze test results and identify issues during testing.

{% note info %}

You can only configure how to save your artifacts prior to testing.

{% endnote %}

## Setting up your infrastructure {#infrastructure-prepare}

1. Create a [bucket](../../storage/concepts/bucket.md) in the folder with the [test agent](../concepts/agent.md).
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.uploader` role to the service account used to [create the test agent](create-agent.md).

## Running a test {#run-test}

You can create a new test:

{% list tabs %}

- Management console

  1. [Create a new test](../quickstart.md#run-test) and enable **{{ ui-key.yacloud.load-testing.field_export-enable }}** under **{{ ui-key.yacloud.load-testing.section_export }}**.
  1. In the **{{ ui-key.yacloud.load-testing.field_export-bucket }}** field, select the bucket to save test artifacts to. 
  1. In the **{{ ui-key.yacloud.load-testing.field_export-filter-include }}** field, specify which files to save, using a [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)) mask.
  1. Optionally, in the **{{ ui-key.yacloud.load-testing.field_export-filter-exclude }}** field, specify which files to exclude, using a glob expression mask.
  1. Optionally, enable **{{ ui-key.yacloud.load-testing.field_export-is-archive }}** to save all files to a single archive.

{% endlist %}

You can also restart the existing test:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Select the test. In the top-right corner, click **{{ ui-key.yacloud.load-testing.restart }}**.
  1. Under **{{ ui-key.yacloud.load-testing.section_export }}**, enable **{{ ui-key.yacloud.load-testing.field_export-enable }}**.
  1. In the **{{ ui-key.yacloud.load-testing.field_export-bucket }}** field, select the bucket to save test artifacts to. 
  1. In the **{{ ui-key.yacloud.load-testing.field_export-filter-include }}** field, specify which files to save, using a [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)) mask.
  1. Optionally, in the **{{ ui-key.yacloud.load-testing.field_export-filter-exclude }}** field, specify which files to exclude, using a glob expression mask.
  1. Optionally, enable **{{ ui-key.yacloud.load-testing.field_export-is-archive }}** to save all files to a single archive.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The test agent stores test artifacts in the `/var/lib/ulta/tests` directory.