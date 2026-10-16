* `filtering_policy`: Settings of the filtering policy that determines which events to collect and include in the audit logs. The policy consists of filters pertaining to different levels of events. It contains the `management_events_filter` and `data_events_filter` sections.

    * `management_events_filter`: Management event filter.

        * `resource_scope`: [Log collection scope](../../audit-trails/concepts/trail.md#collecting-area). You can specify multiple `resource_scope` sections for scopes belonging to the same organization. For example, you can collect logs from one entire cloud and only from particular folders in another cloud. Service account permissions must allow collecting logs from the specified scopes.

            * `resource_id`: ID of the collection scope ([organization](../../organization/operations/organization-get-id.md), [cloud](../../resource-manager/operations/cloud/get-id.md), or [folder](../../resource-manager/operations/folder/get-id.md)).
            * `resource_type`: Scope type according to the specified ID:

                * `organization-manager.organization`: [Organization](../../organization/concepts/organization.md).
                * `resource-manager.cloud`: [Cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
                * `resource-manager.folder`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `data_events_filter`: Data event filter. You can configure several filters of this type, one filter per service. A filter for one service has the following structure:

        * `service`: Name of the service in which the trail will process events. You can get it from the [data event reference](../../audit-trails/concepts/events-data-plane.md).
        * `resource_scope`: Places to collect data events from. You can configure this section the same way as the management event filter.
        * `included_events`: Full names of events to collect. You can replace it with `excluded_events` (full names of events to exclude). These parameters are mutually exclusive. If both are not set, selection is not limited to event names.

            Use the full name from the `event_type` field of the audit log. For example, `yandex.cloud.audit.iam.CreateIamToken` corresponds to the `CreateIamToken` event from the [reference](../../audit-trails/concepts/events-data-plane.md).
        * `include_rule` and `exclude_rule`: Optional [rules with conditions based on field values](../../audit-trails/concepts/trail.md#field-filters). These apply together with event selection by names.
