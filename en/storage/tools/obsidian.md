---
title: Remotely Save
description: Remotely Save is an Obsidian plugin that syncs your note vault with cloud storage solutions compatible with the Amazon S3 API, including {{ objstorage-name }}.
---

# Remotely Save

[Remotely Save](https://github.com/remotely-save/remotely-save) is an [Obsidian](https://obsidian.md/) plugin that syncs your note vault with cloud storage solutions compatible with the Amazon S3 API, including {{ objstorage-name }}.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

1. In Obsidian, open **Settings** → **Community plugins**.
1. Disable **Restricted mode** if enabled.
1. Click **Browse** and enter `Remotely Save` in the search bar.
1. Select the **Remotely Save** plugin and click **Install**.
1. To enable the plugin once it is installed, click **Enable**.

## Configuration {#configuration}

1. In Obsidian, open **Settings** → **Remotely Save**.
1. In the **Choose a remote service** field, select **S3 or compatible**.
1. Configure the connection as follows:
    * **Endpoint**: `https://{{ s3-storage-host }}`.
    * **Region**: `{{ region-id }}`.
    * **Access key ID**: Static key ID [you got previously](#before-you-begin).
    * **Secret Access Key**: Static key contents [you got previously](#before-you-begin).
    * **Bucket Name**: Name of the bucket [you created earlier](#before-you-begin).
1. Click **Check** to test the connection.
1. Close the settings window. The data will be saved automatically.
1. Restart Obsidian.

## Syncing {#sync}

To start synchronization, click the plugin icon in the Obsidian side panel or run the `Remotely Save: start sync` command via the command palette (`Ctrl+P`/`Cmd+P`).

Once synchronized, files from Obsidian will appear in the bucket as objects with keys in `folder/subfolder/note.md` format.

For more information about the plugin, refer to [Remotely Save guides](https://github.com/remotely-save/remotely-save).
