# Backups in {{ datalens-name }}

{{ datalens-short-name }} provides:
- Daily automatic backups of data uploaded to a [materialization DB](dataset/settings.md#materializaton). Data is stored for a week.
- Daily automatic backups of metadata (connections, datasets, charts, dashboards). Backups are stored for a week.

To retrieve a backup or restore data, [contact support]({{ link-console-support }}).

The user of the {{ datalens-short-name }} instance is responsible for storing source data for the connection (such as CSV files) and for backing up external {{ datalens-short-name }} data.
