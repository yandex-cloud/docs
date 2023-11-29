# Working with dialogs

In the [dialog](../../concepts/dialogs.md), you can listen to an audio recording or view the transcript of the call between the agent and the customer. You can also obtain information about the dialog, such as whether the agent was able to assist the customer during the conversation.

## Viewing a list of dialogs {#list-dialogs}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.

By default, the **Dialogs** tab displays 20 most recent dialogs. To see the previous dialogs, click **Load more** at the end of the list.

To search for dialogs, you can use [filters](#filters-dialogs) and the [search bar](#find-dialogs).

## Finding dialogs using filters {#filters-dialogs}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. On the **Dialogs** tab, click ![image](../../../_assets/plus-sign.svg) **Add filter**.
1. Select the required filter and enter its value.
1. Click **Apply**.

If you add multiple filters, the dialogs that meet all the specified conditions will be found.

## Finding dialogs by text fragment {#find-dialogs}

Full-text search allows you to find dialogs containing a specific word or phrase. The better the dialog text matches the search query and the more frequently it occurs, the higher is the dialog placed in the search results.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. On the **Dialogs** tab, enter the desired text fragment in the search bar.
1. (Optional) To the right of the search bar, select the channel in which to perform the search: **Customer** or **Operator**, from the dropdown list.

## Viewing a dialog {#view-dialog}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. Find the required dialog using [filters](#filters-dialogs) and the [search bar](#find-dialogs).
1. Open the dialog in one of the following ways:

   * To open a dialog preview, click the dialog line.
   * To open the dialog in a new window, click ![image](../../../_assets/console-icons/arrow-up-right-from-square.svg) on the right in the dialog line.

For more information on dialogs, see [{#T}](../../concepts/dialogs.md).

## Example of searching dialogs by time period and text fragment {#example-find-dialogs-by-period-and-text}

Search criteria:

* For the period between `10/11/2023 and 16/11/2023`.
* Contains the customer's utterance: `good service`.

Follow these steps:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the appropriate project.
1. In the **Dialogs** tab, enter `good service` in the search bar.
1. To the right of the search bar, select the **Customer** channel from the drop-down list.
1. Click ![image](../../../_assets/plus-sign.svg) **Add filter**.
1. In the **Shared metadata** group, select the **Start date** filter. As the filter value, specify the `10/11/2023 - 16/11/2023` date range.
1. Click **Apply**.

The filtered dialogs will be displayed as a result.

Example of ranking dialogs depending on the found text fragments:

#|
|| **No.** | **Dialog date** | **Dialog fragment** ||
|| 1 | 16/11/2023 | Thank you for the `good service` ||
|| 2 | 13/11/2023 | `Good` equipment and `service` ||
|| 3 | 15/11/2023 | Full system `service` ||
|#
