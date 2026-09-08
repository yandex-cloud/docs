* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](../../../organization/concepts/ad-sync/index.md#dc-setup) with permissions to replicate folder data:

    * `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller.
    * `username`: `sAMAccountName` of the {{ microsoft-idp.ad-short }} domain user with data replication permissions [assigned](../../../organization/concepts/ad-sync/index.md#dc-setup).
    * `password`: {{ microsoft-idp.ad-short }} domain user password.