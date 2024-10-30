# Resolving issues when loading a CSV file into a dataset as a data source


## Issue description {#issue-description}

* When trying to upload a CSV file as a data source for the dataset, you see the "Failed to upload file" message or the `ERR.FILE.PARSE_FAILED` error.

## Solution {#issue-resolution}

1. Check the encoding of data in your CSV file. Currently, we support `UTF-8`, `UTF-16`, `Windows-1251`, and `UTF-8-sig` encodings.
2. Check the correctness of column separators in the file (as well as their presence throughout the content from beginning to end). At the moment, we support `comma`, `semicolon`, and `tab` as column separators.

3. Try uploading the file again by doing the following:

   * Disable ad blockers in your browser
   * Go to the DataLens dataset page in incognito mode
   * Use a different browser.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help solve the issue, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Link to the problematic dataset
2. [HAR-file](https://cloud.yandex.ru/docs/support/create-har) built when attempting to add a joined table to the dataset
3. CSV file that you are trying to upload to the dataset as a data source.

{% note alert %}

Before sending the CSV file to technical support, do not forget to clean it of sensitive content

{% endnote %}
