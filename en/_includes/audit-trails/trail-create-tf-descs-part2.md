* `filtering_policy`: The settings of the filtering policy that determines which events to collect and include in the audit logs. The policy consists of filters pertaining to different levels of events. It contains the `management_events_filter` and `data_events_filters` objects.
    * `management_events_filter`: Management event filter.
    * `resource_scopes`: [Log collection scope](../../audit-trails/concepts/trail.md#collecting-area). You can combine several scopes belonging to the same organization in one `resource_scopes` parameter. For example, you can collect logs from one entire cloud and only from particular folders in another cloud. Service account permissions must allow collecting logs from the specified scopes.
        * `resource_id`: ID of the resource for whose resources audit logs will be collected. Based on the audit log collection scope, specify the organization [ID](../../organization/operations/organization-get-id.md) or the cloud [ID](../../resource-manager/operations/cloud/get-id.md) in this parameter.
        * `resource_type`: Scope type according to the specified ID:
          * `organization-manager.organization`: Organization
          * `resource-manager.cloud`: Cloud
          * `resource-manager.folder`: Folder
    * `data_events_filters`: Data event filters. You can configure several filters of this type: one for each service. A filter for one service has the following structure:
        * `service`: ID of the [service](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events) in which the trail will process events.
            The possible values are as follows:
            * `dns`
            * `kms`
            * `lockbox`
            * `mdb.mongodb`
            * `mdb.mysql`
            * `mdb.postgresql`
            * `storage`
        * `resource_scopes`: Places to collect data events from. You can configure this parameter the same way as the management event filter.
        * `included_events`: Collect only specified events. This is an optional parameter. If not specified, all events will be collected. To collect all events except the specified ones, replace `included_events` with `excluded_events`. These parameters are mutually exclusive.
            You can get a full list of events from the [data event reference](../../audit-trails/concepts/events-data-plane.md).

