To test {{ objstorage-full-name }} integration with Nextcloud in a fault-tolerant configuration:

1. Open your local computer browser and enter your domain name in the address bar, e.g.:

    ```text
    https://example.com
    ```
1. Get authenticated in Nextcloud using the login and password created when configuring the solution.
1. In the left pane of the top menu, select ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. In the left-hand menu, select **External storage** and then **AmazonS3**.
1. Make sure you see the file uploaded in the previous step.
1. Download the file you uploaded earlier. Do this by clicking ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and selecting ![arrow-down](../../../_assets/console-icons/arrow-down.svg) **Download** in the line with the filename.
1. Delete the file. Do this by clicking ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and selecting ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Delete file** in the line with the filename.
1. In {{ objstorage-full-name }}, [make sure](../../../storage/operations/objects/list.md) the file was deleted from the bucket.