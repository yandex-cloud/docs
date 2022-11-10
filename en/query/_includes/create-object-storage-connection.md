1. Go to the {{ yq-full-name }} interface, open the "Connections" section, and click "Create".
2. In the window that opens, specify a name for a connection to {{ objstorage-full-name }} in the `Name` field.
3. In the drop-down list of the `Type` field, select `Object Storage`.
4. In the `Bucket auth` field, select `Public` or `Private`. `Public` means that the source bucket is not protected through authorization. `Private` means that the bucket should be accessed using the data specified in the `Service account` field.
5. In the `Service account` field, select the service account to be used for data reads or create a new one by granting it the [`storage.viewer`](../../storage/security/index.md) rights.
6. Click `Create` to create a connection.