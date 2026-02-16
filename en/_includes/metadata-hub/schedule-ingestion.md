* **{{ ui-key.data-catalog.console.form.cron.Cron.month.title }}**: Select the dates and the ingestion start and end time.
* **{{ ui-key.data-catalog.console.form.cron.Cron.week.title }}**: Select the days of the week and the ingestion start and end time.

   {% note info %}

   If scheduled for **{{ ui-key.data-catalog.console.form.cron.Cron.month.title }}** or **{{ ui-key.data-catalog.console.form.cron.Cron.week.title }}**, the ingestion will start at the specified time and stop as soon as new data has been ingested. If there are errors while ingesting, the ingestion will restart until the data has been ingested or until the specified time is over.

   {% endnote %}

* **{{ ui-key.data-catalog.console.form.cron.Cron.day.title }}**: Select time intervals for ingestion.
* **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}**: For manual start only.
