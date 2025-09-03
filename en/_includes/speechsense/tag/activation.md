## Activating or deactivating a tag {#activate-tag}

Once created, the tag is activated by default. If you do not want the tag to apply to dialogs, deactivate it. You can activate it again later.

To activate or deactivate a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab.
1. In the line with the tag you need, enable **{{ ui-key.yc-ui-talkanalytics.tags.tag-using-key-value }}** to activate the tag. Disable to deactivate the tag.

These changes affect dialogs as follows:

* If you activate a tag, it will apply to dialogs loaded after the activation as well as existing dialogs that are under 60 days old.
* If you deactivate a tag, it will remain on already uploaded dialogs, but will not apply to the new ones.
