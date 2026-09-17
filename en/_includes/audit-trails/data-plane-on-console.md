Under **{{ ui-key.yacloud.audit-trails.label_data-plane-collection-new }}**:

{% include [events-by-default](./events-by-default.md) %}

1. Enable log collection.
1. Select the [services](../../audit-trails/concepts/events-data-plane.md) to collect audit logs for.
1. Configure the event collection scope and filter for each service:

    1. Click ![chevron-down](../../_assets/console-icons/chevron-down.svg) to the right of the service name.
    1. Select a resource: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    1. Depending on the resource you selected, select specific clouds or folders to collect events from:

        * For the `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` collection scope, select one or more clouds to collect events from in the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list.

            Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

        * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` collection scope, select one or more folders to collect events from in the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list.

            Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.

    1. Select the [event](../../audit-trails/concepts/events-data-plane.md) filter:

          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_all }}`: To collect all events within the service.
          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_include }}`: To collect only selected events. Then proceed to select the events.
          * `{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_exclude }}`: To collect all events except for the selected ones. Then proceed to select the events.