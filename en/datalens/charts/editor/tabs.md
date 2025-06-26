---
title: Editor tabs
description: In this article, you will learn about the Editor tabs.
---

# Tabs

{% include [business-note](../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Chart configuration is customized using JavaScript code you add on the editor tabs in the [interface](./index.md#interface).

The chart configuration code, as described on the tabs, is executed on the server. This page presents the code formats for each of the tabs.

The function code inside `Editor.wrapFn` is executed on the client in the user's browser. This imposes a number of limitations, see [Available methods](./methods.md#wrap) for more details.

The tabs are executed in a specific order.

## Meta {#meta}

Serves to describe service information about the list of related entities.

The **Meta** tab is used to add the object IDs of the sources used for the chart/selector. Object ID description is a required element. This information is used to find out what connections and datasets the chart is related to, for the related objects dialog, when copying a workbook, and when publishing to Public.

You can copy object IDs from the relevant object's menu or in navigation by clicking **Copy ID**. The ID will be saved to the clipboard.

As a key, you need to specify any alias name that will be assigned to this data source in the chart. Next, on the **Source** tab, you can get this alias name using [`Editor.getId(arg)`](./methods.md#get-id) and specify it as a source.

{% list tabs %}

- Format

  ```js
  {
      "links": {
          "<string>": "<string>",
          ...
      }
  }
  ```

- Example

  ```js
  {
      "links": {
          "myDatasetKeyName": "qvnkqzm0wstyf",
          "connectionKey": "ch96co0501xy1",
          "apiConnectionKey": "uzrou8sqm5zaj"
      } 
  }
  ```

{% endlist %}

## Params {#params}

This tab is for default chart/selector parameters. All chart/selector parameters must be described on the **Params** tab. The parameter values ​​are arrays of strings. If you only need to provide one value, you need to format it as an array consisting of one element.

{% list tabs %}

- Format

  ```js
  {
      "<string>": "<string>",
      ...
  }
  ```

- Example

  ```js
  module.exports = {
      count: ['10'],
      setting: ['value'],
  };
  ```

{% endlist %}

If you set other parameter values for such a chart on the dashboard or in the report in the widget settings, the **Params** tab values will be overridden. The values will also be overridden if you select values different from the default ones in the dashboard or report selector or apply cross-filtering by another chart. [Learn more about overriding parameters](../../dashboard/dashboard_parameters.md#params-applying)

You can get the values ​​of all current parameters on subsequent tabs using the [Editor.getParams()](./methods.md#get-params) method; you can also get the current value of any parameter by its name using [Editor.getParam(name)](./methods.md#get-param).

You can override the parameters using the chart's URL. Here is an example:

```text
&period=40&metric=2012&metric=2014
```

When such a URL comes on top of the default parameters, you get the following object:

```js
{
  period: 40,
  metric: ['2012', '2014'],
  id: ['1215', '1217', '979', '483']
}
```

When a dashboard or report is initially rendered, the parameters that link the JS selector to the charts on the dashboard or report remain static. If the parameter is dynamically calculated in the selector code, then the chart re-renders with the updated parameter value only when the selector changes next time.

### Special parameters {#special-parameters}

#### Relative date {#relativedate}

**Formats**:

* `__relative_<symbol><amount><unit>`
* `__relative_<symbol><amount><unit>_<casting_type><unit>`

- `<symbol>`: `+` or `-`
- `<unit>`:
  - `y`: Year
  - `Q`: Quarter
  - `M`: Month
  - `w`: Week
  - `d`: Day
  - `h`: Hour
  - `m`: Minute
  - `s`: Second
  - `ms`: Millisecond
- `<casting_type>`:
  - `s`: To the start
  - `e`: To the end

**Example**:

If the current time is `2020-03-24T23:30:39.874Z`, then
- `__relative_-7d`: Seven days back, ` 2020-03-17T00:00:00.000Z`
- `__relative_+30m`: 30 minutes later, ` 2020-03-25T00:00:39.874Z`
- `__relative_-0d`: Today, `2020-03-24T00:00:00.000Z`
- `__relative_-0h`: Now, `2020-03-24T23:30:39.874Z`
- `__relative_-3M_sQ`
  * Minus 3 months, `2019-12-24T00:00:00.000Z`
    * Cast to the start of the quarter: `2019-10-01T00:00:00.000Z`
- `__relative_+15s_em`
  * Plus 15 seconds: `2020-03-24T23:30:54.874Z`
    * Cast to the end of the minute: `2020-03-24T23:30:59.999Z`

**Note**: If no casting is specified, then for the units of one day and longer, the time is cast to the start of the day,
i.e., `00:00:00.000`, while casting to the current time is used for the units shorter than one day.

**Helper method**: [Editor.resolveRelative](./methods.md#resolve-relative)

#### Interval {#interval}

**Format**: `__interval_<start>_<end>`

`start`/`end`: [relative date](#relativedate) or ISO date.

**Example**:

If the current time is `2020-03-24T23:30:39.874Z`, then
- `__interval_2019-03-11T09:35:48_2019-12-28T09:35:48`
  * from `2019-03-11T09:35:48` to `2019-12-28T09:35:48`
- `__interval_2019-01-17T09:35:48___relative_+0d`
  * from `2019-01-17T09:35:48` to today (`2020-03-24T23:59:59.999Z`)
- `__interval___relative_-2w_sM___relative_+1d`
  * two weeks ago or more: `2020-03-10T00:00:00.000Z`
    * cast to the start of the month: `2020-03-01T00:00:00.000Z`
  * until tomorrow: `2020-03-25T23:59:59.999Z`

**Helper method**: [Editor.resolveInterval](./methods.md#resolve-interval)

### Limitations {#params-restrictions}

The following limitations apply when using parameters:

* You cannot use the following reserved keys:

  * `tab`
  * `state`
  * `mode`
  * `focus`
  * `grid`
  * `scale`
  * `tz`
  * `timezone`
  * `date`
  * `datetime`
  * `_action_params`
  * `_autoupdate`
  * `_opened_info`
  * `report_page`
  * `preview_mode`

  Parameters with these keys are ignored and not saved.

* Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, but the dashboard settings have no `product` parameter (not even with an empty value), this parameter will be ignored.
* Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.

## Sources {#sources}

This tab defines the structure for requesting the data to visualize.

You can request the data using:

* [Dataset](#sources-dataset)
* [Database connection via an SQL query](#sources-database)
* [Connection via API Connector](#sources-api-connector)

### Connecting to a data source via a dataset {#sources-dataset}

To use data from a dataset:


{% list tabs %}

- Format

  JSON object returned in the tab in the following format:

  ```json
  {
      datasetId: "<string>",
      data: {
          fields: [
              {
                  ref: {
                      title: "<string>",
                      type: "title"| "id",
                  },
              },
              ...
          ],
      }
  }
  ```

  Where:

  * `datasetId`: ID of the dataset described in the [Meta](#meta) tab and obtained using the [Editor.getId(arg)](./methods.md#get-id) method.
  * `fields`: Array of dataset column names:
    
    * `title`: Column name or ID.
    * `type`: Type of the column specified in title (select a column by its name or ID).

- Example 1

  ```js
  module.exports = {
      'myDatasetSource': {
          datasetId: Editor.getId('myDatasetKeyName'),
          data: {
              fields: [
                  {
                      ref: {
                          type: "title",
                          title: "PaymentType",
                      },
                  },
  		{
                      ref: {
                          type: "title",
                          title: "OrderYear",
                      },
                  },
  		{
                      ref: {
                          type: "title",
                          title: "OrderMonth",
                      },
                  },
              ],
          },
      },
  };
  ```


- Example 2

  For convenience, you can use the auxiliary service module to work with datasets. In which case Example 1 will look like this:

  ```js
  const {buildSource} = require('libs/dataset/v2');
  module.exports = {
      'myDatasetSource': buildSource({
          datasetId: Editor.getId('myDatasetKeyName'),
          columns: ['PaymentType', 'OrderYear', 'OrderMonth'],
      }),
  };
  ```

  Where:

  * `datasetId`: ID of the dataset described in the [Meta](#meta) tab and obtained using the [Editor.getId(arg)](./methods.md#get-id) method.
  * `columns`: Array of dataset column names.

  There will be an additional parameter where you can provide an array of dataset column IDs.

{% endlist %}

Example of getting only a list of fields from a dataset:

{% list tabs %}

- Sources tab

  ```js
  module.exports = {
    fields: {
        datasetId: Editor.getId('mySource'),
        path: 'fields'
    }
  };
  ```

{% endlist %}

#### See also {#see-also-dataset}

* [Quick start on creating a table with a dataset connection](./quickstart/from-dataset.md)

### Connecting to a data source via an SQL query {#sources-database}

To get data from a connection (via an SQL query):

{% list tabs %}

- Format

  ```json
  {
      qlConnectionId: "<string>",
      data: {
          sql_query: "<string>",
      },
  }
  ```

  Where:

  * `qlConnectionId`: ID of the connection described on the [Meta](#meta) tab and obtained using the [Editor.getId(arg)](./methods.md#get-id) method.
  * `sql_query`: Data query.
  
- Example

  ```js
  module.exports = {
      'myDataSource': {
          qlConnectionId: Editor.getId('connectionKey'),
          data: {
              sql_query: 'SELECT 1 + 1',
          },
      }
  }
  ```

{% endlist %}

#### See also {#see-also-database}

* [Quick start on creating a table with connection via an SQL query](./quickstart/from-database.md)

### Connecting to a data source via API Connector {#sources-api-connector}

To get data via API Connector:

{% list tabs %}

- Format

  ```json
  {
      apiConnectionId: "<string>",
      path: "<string>",
      method: "GET"|"POST",
      body: <object>,
  }
  ```

  Where:

  * `apiConnectionId`: ID of the API Connector type connection described on the [Meta](#meta) tab and obtained using the [Editor.getId(arg)](./methods.md#get-id) method.
  * `path`: API path after host.
  * `method`: Method supporting GET and POST.
  * `body`: Request body.

- Example

  ```js
  module.exports = {
      'myApiDataSource': {
          apiConnectionId: Editor.getId('apiConnectionKey'),
          path: '/html',
          method: 'GET',
      }
  }
  ```

{% endlist %}

#### See also {#see-also-api-connector}

* [Quick start on creating a table with a connection via API Connector](./quickstart/from-api-connector.md)

## Config {#config}

This tab is used to set visualization settings, e.g., cross-chart filtering settings.

Available for [Chart](./widgets/chart.md) and [Table](./widgets/table.md) visualization types. Possible contents depend on the specific visualization type.

## Prepare {#prepare}

This tab is responsible for data preprocessing prior to rendering and includes the following actions:

* Getting uploaded data from sources using the [Editor.getLoadedData()](./methods.md#get-loaded-data) method.

* Processing and conversion to required format (depends on visualization type).

* Writing the results to `module.exports`, from where they get into rendering.

Available for [Chart](./widgets/chart.md), [Advanced chart](./widgets/advanced.md), [Table](./widgets/table.md), [Markdown](./widgets/markdown.md) visualization types.

## Controls {#controls}

The declarative style describes the possible controls, i.e., the chart's control elements. Unlike [dashboard](../../concepts/dashboard.md) selectors and [report](../../reports/index.md) selectors, these control the current chart alone and are not saved after you refresh the page.

Available for all [visualization types](./widgets/index.md). The tab format details depend on the type of [controls](./widgets/controls.md).

