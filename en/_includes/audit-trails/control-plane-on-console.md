Under **{{ ui-key.yacloud.audit-trails.label_control-plane-collection-new }}**:

1. Enable log collection.
1. Select a resource: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
1. Depending on the resource you selected, select specific clouds or folders to collect events from:

    * For the `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` collection scope, select one or more clouds to collect events from in the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list.

        Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

    * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` collection scope, select one or more folders to collect events from in the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list.

        Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.