# Cannot update data

`ERR.FILE.CANNOT_UPDATE_DATA`

You may get this error when trying to update table data from a connection to a [file](../../operations/connection/create-file.md), [Yandex Documents](../../operations/connection/create-yadocs.md), or [Google Sheets](../../operations/connection/create-google-sheets.md). It occurs after a failed auto-update attempt or during background processing of the uploaded data.

To fix this error:

* Refresh the page in a few minutes and try again.
* Re-upload the data: in the connection next to the table name, click ![image](../../../_assets/console-icons/ellipsis.svg) → **Replace** and select a file or provide a link to the table.

If the error persists, contact {{ yandex-cloud }} [support]({{ link-console-support }}). In your message, specify the ID of the dataset and/or connection in which the error occurs.