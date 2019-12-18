# Key version control

You can make key versions primary (the primary key version is used for encryption and decryption by default) and destroy them. To create a new key version, [rotate](key.md#rotate) the key.

## Make a version primary {#make-primary}

To make a version primary:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes.
1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Make primary** from the menu.

The next encryption or decryption request omitting the key version will use the new primary version.

## Destroy a key version {#delete}

You can't destroy a version immediately: you can only schedule its destruction (for the next day at least).

{% note alert %}

On the scheduled date, the key version is permanently destroyed: if you still have data encrypted with this key version, you can no longer decrypt it.

{% endnote %}

To destroy a version:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes.
1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Schedule destruction** from the menu.

The version switches to the `Scheduled For Destruction` status. The day that destruction is scheduled for is shown in the **Destruction date** column.

## Cancel version destruction {#cancel-delete}

If you scheduled the destruction of a key version, you can cancel it before the scheduled date:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes.
1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Cancel destruction** from the menu.

The version reverts to the `Active` status.

