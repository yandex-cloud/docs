# API

{{ datalens-short-name }} provides the following APIs to the users:

* [Workbook API](workbooks/index.md) extends the functionality of the dashboard API and enables you to manage connections, datasets, charts, and dashboards. The Workbook API is in `beta`, so it's less stable compared to the Dashboard API. If you are missing some features in the Workbook API, [write](https://st.yandex-team.ru/createTicket?queue=dlfr) to the developers team.

   {% note info %}

   * To access the API from a developer computer, request network access to [upload.datalens.yandex-team.ru](https://upload.datalens.yandex-team.ru).
   * To access the API from your work laptop, network permissions are already configured so you don't need to request them.

   {% endnote %}

* [Data API](dashboards/data.md). Enables you to export the data and information needed to render the chart. You can't export the data alone over the API.
* [Comment API](dashboards/comments/index.md). Enables you to create, edit, and delete comments, comment channels, and retrieve a list of comment channels. 
* Object API. Enables you to work with [charts](dashboards/charts.md) and [dashboards](dashboards/dash/index.md). We recommend using the Workbook API because the Object API manipulates a lower level compared to the Workbook API.
* [Screenshot API](dashboards/scr.md). They enable you to create screenshots over the API.

For off-premise installation, the API is unavailable (within {{ yandex-cloud }}).
