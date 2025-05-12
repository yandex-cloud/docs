Event name | Description
--- | ---
`CreateCollection`               | Creating a [collection](../../../datalens/workbooks-collections/index.md)
`UpdateCollection`               | Updating a collection
`MoveCollections`                | Moving collections
`DeleteCollections`              | Deleting collections
`UpdateCollectionAccessBindings` | Updating access permissions for a collection
`CreateEntry`                    | Creating an object. Object (`Entry`) is a common term for [connections](../../../datalens/concepts/connection.md), [datasets](../../../datalens/dataset/index.md), [charts](../../../datalens/concepts/chart/index.md), [dashboards](../../../datalens/concepts/dashboard.md), [reports](../../../datalens/reports/index.md), and folders.
`UpdateEntry`                    | Updating an object
`RenameEntry`                    | Renaming an object
`CopyEntriesToWorkbook`          | Copying an object to a [workbook](../../../datalens/workbooks-collections/index.md)
`SwitchEntriesPublicationStatus` | Updating an object publication status
`DeleteEntry`                    | Deleting an object
`MoveEntry`                      | Moving an object
`CopyEntry`                      | Copying an object
`MigrateEntriesToWorkbook`       | Migrating objects to a workbook
`FolderEntryModifyPermissions`   | Updating access permissions for folder objects
`FolderEntryBatchModifyPermissions` | Bulk updating access permissions for folder objects
`CreateWorkbook`               | Creating a workbook
`UpdateWorkbook`               | Updating a workbook
`MoveWorkbooks`                | Moving workbooks
`DeleteWorkbooks`              | Deleting one or multiple workbooks
`CopyWorkbook`                 | Copying a workbook
`SwitchWorkbookFileExportProhibition` | Updating the restriction on file export from a workbook
`UpdateWorkbookAccessBindings` | Updating access permissions for a workbook
`CreateEmbeddingSecret` | Creating a key for an [embedding](../../../datalens/security/embedded-objects.md)
`DeleteEmbeddingSecret` | Deleting a key for an embedding
`CreateEmbed` | Creating an embedding
`UpdateEmbed` | Updating an embedding
`DeleteEmbed` | Deleting an embedding
`CreateColorPalette` | Creating a [color palette](../../../datalens/operations/chart/create-palette.md)
`UpdateColorPalette` | Updating a color palette
`DeleteColorPalette` | Deleting a color palette
`DisableFolders`                | [Disabling](../../../datalens/settings/disable-folder-navigation.md) folder navigation
`SwitchDataExportProhibition`   | Updating the data export restriction
`SwitchPublicationProhibition`  | Updating the prohibition to publish objects
`EnableBillingInstanceService`  | Receiving a notification from {{ billing-name }} that the [billing account](../../../billing/concepts/billing-account.md) linked to {{ datalens-name }} is active
`DisableBillingInstanceService` | Receiving a notification from {{ billing-name }} that the billing account linked to {{ datalens-name }} is inactive
`EnableTenantBilling`           | User enabled the Business plan
`DisableTenantBilling`          | User scheduled Business plan deactivation for the beginning of the next month
`CopyTemplate` | Deploying a product
