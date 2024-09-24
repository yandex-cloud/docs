# Deleting a tag

To delete a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role in the project.

## Deleting a main tag {#delete-tag}

When you delete a main tag, all its dependent tags will also be deleted. {{ speechsense-name }} will warn you if there are any dependent tags for the tag you are deleting.

To delete a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
1. In the line with the tag, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Confirm tag deletion.

## Deleting a dependent tag {#delete-dependent-tag}

To delete a dependent tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab and select the main tag you need to delete. The drop-down list will show its dependent tags.
1. In the line with the tag, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Confirm tag deletion.
