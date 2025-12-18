# Fixing issues when loading a CSV file into a dataset as a data source



## Issue description {#issue-description}

When trying to upload a CSV file as a data source for the dataset, you get the `Failed to upload file` message or the `ERR.FILE.PARSE_FAILED` error.

## Solution {#issue-resolution}

1. Check your CSV file encoding: we support UTF-8, UTF-16, Windows-1251, and UTF-8-sig.
1. Check that column separators are correct and in place throughout the file. The available values are a comma (`,`), semicolon (`;`), and tab character.
1. Try uploading the file again by following these steps:

    * Disable ad blockers in your browser.
    * Go to the {{ datalens-name }} dataset page in incognito mode.
    * Use a different browser.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the dataset in question.
1. [HAR-file](../../../support/create-har.md) built when attempting to add a joined table to the dataset.
1. CSV file that you are trying to upload to the dataset as a data source.

{% note alert %}

Before sending your CSV file to our support, make sure to remove all sensitive information from it.

{% endnote %}
