* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [gMSA account](*gmsa_account) with [permissions](../../../organization/concepts/ad-sync/index.md#dc-setup) to replicate folder data:

    * `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller.
    * `use_windows_identity: true`: Enforces authentication in {{ microsoft-idp.ad-short }} using a gMSA account for the synchronization agent.

        {% include [runas-gmsa-account-notice](../runas-gmsa-account-notice.md) %}