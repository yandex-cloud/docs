In the window that opens, select ![app-dark-icon](../../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** in the left-hand panel under **Administration** and specify the {{ objstorage-name }} integration settings under **External storage** in the window that opens:

1. In the **External storage** section, select `Amazon S3`.
1. In the **Authentication** section, select `Access key`.
1. In the **Configuration** section:

    * In the **Bucket** field, enter the name of the bucket you created earlier, e.g., `my-nextcloud-bucket`.
    * In the **Hostname** field, specify `{{ s3-storage-host }}`.
    * In the **Port** field, specify `443`.
    * In the **Access key** field, paste the static access key ID you got earlier.
    * In the **Secret key** field, paste the static access key's secret key you got earlier.
1. Under **Available for**, enable **All people**.
1. On the right side of the section you are editing, click the ![check](../../../_assets/console-icons/check.svg) icon to save your changes.

    Enter your Nextcloud administrator password in the pop-up window to confirm the operation.