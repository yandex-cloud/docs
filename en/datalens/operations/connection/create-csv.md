# Creating a connection to a CSV file

{% note warning %}

You can only upload a CSV file once. To reupload an updated CSV file, create a new connection.

{% endnote %}

To create a connection to a CSV file:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page]({{ link-datalens-main }}/connections).

{% endif %}

1. Click **Create connection**.

1. Select the **CSV** connection.

1. Click **Select CSV file** and specify the CSV file or drag it to the screen. Information about the added file is displayed in the lower part of the dialog box.

    {% note info %}

    The CSV file size may not exceed 200 MB.

    {% endnote %}

1. Click **Upload**.

1. Select the file upload parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Encoding**. Specify the data encoding of the file. Available values: `utf-8`, `windows-1251`, and `utf-8-sig`.
    - **Delimiter**. Specify the delimiter that is used in the CSV file. Available values: `;`, `,`, and `\t`.
    - **Title**. Select the title option. If you choose **Present**, then {{ datalens-short-name }} uses the first row of data as the heading.

1. Click **Connect**. The connection appears in the list with the `materializing` status. This means that data from the CSV file to {{ datalens-short-name }} storage is still uploading.
To create a dataset based on a connection to the CSV file, wait until the connection status changes to `materialized`.

