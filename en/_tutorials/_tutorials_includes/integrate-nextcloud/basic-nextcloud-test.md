To test {{ objstorage-full-name }} integration with Nextcloud on a single host:

1. Open your local computer browser and enter the public IPv4 address of the Nextcloud VM in the address bar:

    ```text
    http://<VM_public_IP_address>
    ```
1. Get authenticated in Nextcloud using the login and password created when configuring the solution in the previous step.
1. In the left pane of the top menu, select ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. In the left-hand menu, select **External storage** and then **AmazonS3**.
1. Click ![plus](../../../_assets/console-icons/plus.svg) **New** and select ![arrow-shape-up-from-line](../../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files** to upload a file from your local computer to the storage.
1. Select a file on your local computer and upload it to the storage.

    The uploaded file will now appear in the Nextcloud storage named `AmazonS3`.
1. In {{ objstorage-full-name }}, [make sure](../../../storage/operations/objects/list.md) the file was uploaded to the bucket.