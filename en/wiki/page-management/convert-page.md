# Converting a page to the new editor

If you had a chance to try out the features of the [new {{ wiki-name }} editor](../wysiwyg-edit.md) and want to use it exclusively, you can convert {{ wiki-name }} pages created in the old editor to the new one.

## What you should know before converting a page {#restrictions}

{% note warning %}

Once a page is converted to the new editor, you cannot revert it to the old one.

{% endnote %}

- [Dynamic blocks](../actions.md) will not be migrated to the new editor: after converting a page, you will need to fix them manually using the [{{ yfm }} markup]({{ yfm-link }}).
- The [history of page changes](../history.md) made before its conversion is available in read-only mode: you will not be able to roll back to these versions. This is because the versions preceding the conversion were created using the old editor. Page versions after conversion can be restored.

## How to convert a page {#how-to}

1. Open the desired {{ wiki-name }} page.
1. In the top-right corner of the {{ wiki-name }} page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/convert-page.svg) **Convert to new editor**.
1. On the preview page, check how the converted page will look in the new editor. To compare page versions in the old and new editors, click **Compare to source**. This opens the original page in a new window.
1. If everything is correct and you are ready to convert the page, click **Convert**.


