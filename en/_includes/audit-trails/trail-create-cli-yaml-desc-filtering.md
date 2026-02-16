* `filtering_policy`: Settings of the filtering policy that determines which events to collect and include in the audit logs. The policy consists of filters pertaining to different levels of events.

    {% note warning %}

    You must configure at least one filter for the policy; otherwise, you will not be able to create a trail.

    {% endnote %}

    Available filters:

    * `management_events_filter`: Management event filter.

        {#filter-cli}

        Specify the [log collection scope](../../audit-trails/concepts/trail.md#collecting-area) in the `resource_scopes` parameter:

        * `id`: Organization, cloud, or folder ID.
        * `type`: Scope type according to the specified ID:

            * `organization-manager.organization`: [Organization](../../organization/concepts/organization.md).
            * `resource-manager.cloud`: [Cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
            * `resource-manager.folder`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

        You can combine several scopes belonging to the same organization in one `resource_scopes` parameter. For example, you can collect logs from one entire cloud and only from particular folders in another cloud:

        ```yaml
        resource_scopes:
        # Collecting logs from all of cloud 1
        - id: <ID_of_cloud_1>
            type: resource-manager.cloud
        # Collecting logs from folder 1 of cloud 2
        - id: <folder_1_ID>
            type: resource-manager.folder
        # Collecting logs from folder 2 of cloud 2
        - id: <folder_2_ID>
            type: resource-manager.folder
        ```

        Service account permissions must allow collecting logs from the specified scopes.

    * `data_events_filters`: Data event filters. You can configure several filters of this type, one filter per service.

        A filter for one service has the following structure:

        * `service`: Service name. You can get it from the [data event reference](../../audit-trails/concepts/events-data-plane.md).

        * `resource_scopes`: Places to collect data events from. You can configure this parameter the same way as the management event filter.

        * `*_events`: Data event filters.

            * `included_events.event_types`: Collect only specified events.
            * `excluded_events.event_types`: Collect all events other than the specified ones.

            You can get a list of events from the [data event reference](../../audit-trails/concepts/events-data-plane.md).

            {% note warning %}

            The `included_events` and `excluded_events` filters are mutually exclusive, so only one of them should be set up. If neither filter is set up, all events will be collected.

            {% endnote %}