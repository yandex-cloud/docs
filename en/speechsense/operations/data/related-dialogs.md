# Viewing related dialogs

From a [related dialog](../../concepts/dialogs.md#related-dialogs), you can go to the related dialogs page and view information about each dialog. From the related dialogs page, you can return to viewing an individual dialog.

## Navigating to related dialogs {#list}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. On the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, [find](manage-dialogs.md#filters-dialogs) the dialog you need.
1. Navigate to related dialogs using one of these methods:

    * In the list of dialogs, click the link in the field with the task number.

        If a dialog has related dialogs, the related dialogs page will open. If a dialog has no related dialogs, the single dialog view page will open.

    * [Go](manage-dialogs.md#view-dialog) to the dialog and click ![image](../../../_assets/console-icons/link.svg) to the right of its header.

        If there is no such button, it means that there are no related dialogs for the dialog you opened.

## Viewing information about a related dialog {#view}

1. Navigate to related dialogs.
1. To view metadata about the required dialog, such as its the start date or direction, click the **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}** section.
1. To view the metadata of a client, agent, or bot, click the relevant section.
1. To view information about a dialog, select the one you need.

    Within a single dialog, you can search by text and view the dialog tags.

1. To view the semantic analysis of a dialog, click the **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}** tab.

## Navigating to the individual dialog view

To switch from the related dialogs page to the single dialog view page, click ![image](../../../_assets/console-icons/arrow-up-right-from-square.svg) for the dialog at hand on either the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** or **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}** tab.
