# Workbook API

## wb_read

Getting the workbook configuration.


### Request

| Field | Type | Description |
------|-----|----------
| `workbook_id` | **str** * |
### Response

| Field | Type | Description |
------|-----|----------
| `workbook` | **WorkBook** * |
| `workbook`.`datasets` | **list** * |
| `workbook`.`datasets[]` | **DatasetInstance** |
| `workbook`.`datasets[]`.`name` | **str** * |
| `workbook`.`datasets[]`.`dataset` | [Dataset](Dataset.md) * |
| `workbook`.`charts` | **list** * |
| `workbook`.`charts[]` | **ChartInstance** |
| `workbook`.`charts[]`.`name` | **str** * |
| `workbook`.`charts[]`.`chart` | [Chart](Chart.md) * |
| `workbook`.`dashboards` | **list** * |
| `workbook`.`dashboards[]` | **DashInstance** |
| `workbook`.`dashboards[]`.`name` | **str** * |
| `workbook`.`dashboards[]`.`dashboard` | [Dashboard](Dashboard.md) * |
### Examples

#### Example: Empty workbook

##### Request

```yaml
kind: wb_read
workbook_id: examples/API/example_1
```


##### Response

```yaml
kind: wb_read
workbook:
  datasets: []
  charts: []
  dashboards: []
```


## wb_create

Create workbook. The folders for navigation and connection, that are listed in the request, will be created. Presently, you can only create connections.


### Request

| Field | Type | Description |
------|-----|----------
| `workbook_id` | **str** * |
| `workbook` | **WorkbookConnectionsOnly** |
| `workbook`.`connections` | **list** * |
| `workbook`.`connections[]` | **ConnectionInstance** |
| `workbook`.`connections[]`.`name` | **str** * |
| `workbook`.`connections[]`.`connection` | [Connection](Connection.md) * |
| `connection_secrets` | **list** | Secrets used in connections (passwords/tokens). The mapping between secrets and connections is established by their names. This field isn't required for secretless connections (for example, for CHYT with user authentication). |
| `connection_secrets[]` | **ConnectionSecret** | Secrets used in connections (passwords/tokens). The mapping between secrets and connections is established by their names. This field isn't required for secretless connections (for example, for CHYT with user authentication). |
| `connection_secrets[]`.`conn_name` | **str** * |
| `connection_secrets[]`.`secret` | [Secret](Secret.md) * |
### Response

| Field | Type | Description |
------|-----|----------
| `workbook_id` | **str** * |
| `created_entries_info` | **list** * |
| `created_entries_info[]` | **EntryInfo** |
| `created_entries_info[]`.`kind` | **enum/str[`connection` / `dataset` / `chart` / `dashboard`]** * |
| `created_entries_info[]`.`name` | **str** * |
| `created_entries_info[]`.`id` | **str** * |
### Examples

#### Example: Empty workbook

##### Request

```yaml
kind: wb_create
workbook_id: the_bottomless_abyss/temporary_wb_1
workbook: null
connection_secrets: []
```


##### Response

```yaml
kind: wb_create
workbook_id: the_bottomless_abyss/temporary_wb_1
created_entries_info: []
```


#### Example: workbook with CHYT connection

##### Request

```yaml
kind: wb_create
workbook_id: the_bottomless_abyss/temporary_wb_1
workbook:
  connections:
  - name: main_connection
    connection:
      kind: ch_over_yt
      raw_sql_level: 'off'
      cache_ttl_sec: null
      cluster: hahn
      clique_alias: '*ch_datalens'
connection_secrets:
- conn_name: main_connection
  secret:
    kind: plain
```


##### Response

```yaml
kind: wb_create
workbook_id: the_bottomless_abyss/temporary_wb_1
created_entries_info:
- kind: connection
  name: main_connection
  id: as123m34
```


## wb_modify

Applying a workbook configuration.  The current state of each item from the workbook is matched against the config from the request. The workbook items missing from the request will be deleted.

The item's properties edited in the UI and not supported by the API, won't change. You can change this behavior by enabling `force_rewrite`. Then all the objects will be overridden regardless of the changes made in the UI.


### Request

| Field | Type | Description |
------|-----|----------
| `workbook_id` | **str** * |
| `workbook` | **WorkBook** * |
| `workbook`.`datasets` | **list** * |
| `workbook`.`datasets[]` | **DatasetInstance** |
| `workbook`.`datasets[]`.`name` | **str** * |
| `workbook`.`datasets[]`.`dataset` | [Dataset](Dataset.md) * |
| `workbook`.`charts` | **list** * |
| `workbook`.`charts[]` | **ChartInstance** |
| `workbook`.`charts[]`.`name` | **str** * |
| `workbook`.`charts[]`.`chart` | [Chart](Chart.md) * |
| `workbook`.`dashboards` | **list** * |
| `workbook`.`dashboards[]` | **DashInstance** |
| `workbook`.`dashboards[]`.`name` | **str** * |
| `workbook`.`dashboards[]`.`dashboard` | [Dashboard](Dashboard.md) * |
| `force_rewrite` | **bool** |
### Response

| Field | Type | Description |
------|-----|----------
| `executed_plan` | **ModificationPlan** * |
| `executed_plan`.`operations` | **list** * |
| `executed_plan`.`operations[]` | **EntryOperation** |
| `executed_plan`.`operations[]`.`entry_name` | **str** * |
| `executed_plan`.`operations[]`.`entry_kind` | **enum/str[`connection` / `dataset` / `chart` / `dashboard`]** * |
| `executed_plan`.`operations[]`.`operation_kind` | **enum/str[`create` / `modify` / `delete`]** * |
| `workbook` | **WorkBook** * |
| `workbook`.`datasets` | **list** * |
| `workbook`.`datasets[]` | **DatasetInstance** |
| `workbook`.`datasets[]`.`name` | **str** * |
| `workbook`.`datasets[]`.`dataset` | [Dataset](Dataset.md) * |
| `workbook`.`charts` | **list** * |
| `workbook`.`charts[]` | **ChartInstance** |
| `workbook`.`charts[]`.`name` | **str** * |
| `workbook`.`charts[]`.`chart` | [Chart](Chart.md) * |
| `workbook`.`dashboards` | **list** * |
| `workbook`.`dashboards[]` | **DashInstance** |
| `workbook`.`dashboards[]`.`name` | **str** * |
| `workbook`.`dashboards[]`.`dashboard` | [Dashboard](Dashboard.md) * |
### Examples

#### Example: 1

##### Request

```yaml
kind: wb_modify
workbook_id: the_bottomless_abyss/temporary_wb_1
workbook:
  datasets:
  - name: superstore_sales
    dataset:
      fields:
      - id: category
        title: Category
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Category
          avatar_id: null
      - id: city
        title: City
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: City
          avatar_id: null
      - id: country
        title: Country
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Country
          avatar_id: null
      - id: customer_id
        title: Customer ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Customer ID
          avatar_id: null
      - id: customer_name
        title: Customer Name
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Customer Name
          avatar_id: null
      - id: discount
        title: Discount
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Discount
          avatar_id: null
      - id: order_date
        title: Order Date
        description: null
        hidden: false
        cast: date
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order Date
          avatar_id: null
      - id: order_date_str
        title: Order Date Str
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order Date Str
          avatar_id: null
      - id: order_id
        title: Order ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order ID
          avatar_id: null
      - id: postal_code
        title: Postal Code
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Postal Code
          avatar_id: null
      - id: product_id
        title: Product ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Product ID
          avatar_id: null
      - id: product_name
        title: Product Name
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Product Name
          avatar_id: null
      - id: profit
        title: Profit
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Profit
          avatar_id: null
      - id: quantity
        title: Quantity
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Quantity
          avatar_id: null
      - id: region
        title: Region
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Region
          avatar_id: null
      - id: row_id
        title: Row ID
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Row ID
          avatar_id: null
      - id: sales
        title: Sales
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Sales
          avatar_id: null
      - id: segment
        title: Segment
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Segment
          avatar_id: null
      - id: ship_date
        title: Ship Date
        description: null
        hidden: false
        cast: date
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Date
          avatar_id: null
      - id: ship_date_str
        title: Ship Date Str
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Date Str
          avatar_id: null
      - id: ship_mode
        title: Ship Mode
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Mode
          avatar_id: null
      - id: state
        title: State
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: State
          avatar_id: null
      - id: sub-category
        title: Sub-Category
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Sub-Category
          avatar_id: null
      avatars: null
      sources:
      - id: main
        title: Sample Superstore
        connection_ref: main_connection
        spec:
          kind: sql_table
          db_name: null
          table_name: //home/yandexbi/samples/sample_superstore
  charts:
  - name: total_sales_indicator
    chart:
      datasets:
      - superstore_sales
      ad_hoc_fields:
      - field:
          id: sum_sales
          title: The sum_sales
          description: null
          hidden: false
          cast: float
          aggregation: null
          calc_spec:
            kind: formula
            formula: SUM([Sales])
        dataset_name: null
      visualization:
        kind: indicator
        field:
          source:
            kind: ref
            id: sum_sales
            dataset_name: null
  - name: sales_per_region
    chart:
      datasets:
      - superstore_sales
      ad_hoc_fields:
      - field:
          id: sales_sum
          title: The sales_sum
          description: null
          hidden: false
          cast: float
          aggregation: sum
          calc_spec:
            kind: direct
            field_name: Sales
            avatar_id: null
        dataset_name: null
      visualization:
        kind: column
        x:
        - source:
            kind: ref
            id: region
            dataset_name: null
        y:
        - source:
            kind: ref
            id: sales_sum
            dataset_name: null
        sort:
        - source:
            kind: ref
            id: region
            dataset_name: null
          direction: ASC
        colors: []
  dashboards:
  - name: main_dash
    dashboard:
      tabs:
      - id: default
        title: Default
        items:
        - id: tiid_chart_0
          element:
            kind: widget_container
            hide_title: true
            tabs:
            - id: wtid_total_sales_indicator
              chart_name: total_sales_indicator
              title: null
            default_widget_id: null
          placement:
            x: 0
            y: 2
            h: 2
            w: 2
        - id: tiid_chart_1
          element:
            kind: widget_container
            hide_title: true
            tabs:
            - id: wtid_sales_per_region
              chart_name: sales_per_region
              title: null
            default_widget_id: null
          placement:
            x: 2
            y: 2
            h: 2
            w: 2
force_rewrite: null
```


##### Response

```yaml
kind: wb_modify
executed_plan:
  operations:
  - entry_name: superstore_sales
    entry_kind: dataset
    operation_kind: modify
  - entry_name: total_sales_indicator
    entry_kind: chart
    operation_kind: create
  - entry_name: sales_per_region
    entry_kind: chart
    operation_kind: create
  - entry_name: main_dash
    entry_kind: dashboard
    operation_kind: create
  - entry_name: some_entry_that_not_presented_in_rq
    entry_kind: chart
    operation_kind: delete
workbook:
  datasets:
  - name: superstore_sales
    dataset:
      fields:
      - id: category
        title: Category
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Category
          avatar_id: main
      - id: city
        title: City
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: City
          avatar_id: main
      - id: country
        title: Country
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Country
          avatar_id: main
      - id: customer_id
        title: Customer ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Customer ID
          avatar_id: main
      - id: customer_name
        title: Customer Name
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Customer Name
          avatar_id: main
      - id: discount
        title: Discount
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Discount
          avatar_id: main
      - id: order_date
        title: Order Date
        description: null
        hidden: false
        cast: date
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order Date
          avatar_id: main
      - id: order_date_str
        title: Order Date Str
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order Date Str
          avatar_id: main
      - id: order_id
        title: Order ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Order ID
          avatar_id: main
      - id: postal_code
        title: Postal Code
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Postal Code
          avatar_id: main
      - id: product_id
        title: Product ID
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Product ID
          avatar_id: main
      - id: product_name
        title: Product Name
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Product Name
          avatar_id: main
      - id: profit
        title: Profit
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Profit
          avatar_id: main
      - id: quantity
        title: Quantity
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Quantity
          avatar_id: main
      - id: region
        title: Region
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Region
          avatar_id: main
      - id: row_id
        title: Row ID
        description: null
        hidden: false
        cast: integer
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Row ID
          avatar_id: main
      - id: sales
        title: Sales
        description: null
        hidden: false
        cast: float
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Sales
          avatar_id: main
      - id: segment
        title: Segment
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Segment
          avatar_id: main
      - id: ship_date
        title: Ship Date
        description: null
        hidden: false
        cast: date
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Date
          avatar_id: main
      - id: ship_date_str
        title: Ship Date Str
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Date Str
          avatar_id: main
      - id: ship_mode
        title: Ship Mode
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Ship Mode
          avatar_id: main
      - id: state
        title: State
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: State
          avatar_id: main
      - id: sub-category
        title: Sub-Category
        description: null
        hidden: false
        cast: string
        aggregation: none
        calc_spec:
          kind: direct
          field_name: Sub-Category
          avatar_id: main
      avatars:
        definitions:
        - id: main
          source_id: main
          title: Sample Superstore
        root: main
        joins: []
      sources:
      - id: main
        title: Sample Superstore
        connection_ref: main_connection
        spec:
          kind: sql_table
          db_name: null
          table_name: //home/yandexbi/samples/sample_superstore
  charts:
  - name: total_sales_indicator
    chart:
      datasets:
      - superstore_sales
      ad_hoc_fields:
      - field:
          id: sum_sales
          title: The sum_sales
          description: null
          hidden: false
          cast: float
          aggregation: none
          calc_spec:
            kind: formula
            formula: SUM([Sales])
        dataset_name: superstore_sales
      visualization:
        kind: indicator
        field:
          source:
            kind: ref
            id: sum_sales
            dataset_name: superstore_sales
  - name: sales_per_region
    chart:
      datasets:
      - superstore_sales
      ad_hoc_fields:
      - field:
          id: sales_sum
          title: The sales_sum
          description: null
          hidden: false
          cast: float
          aggregation: sum
          calc_spec:
            kind: direct
            field_name: Sales
            avatar_id: main
        dataset_name: superstore_sales
      visualization:
        kind: column
        x:
        - source:
            kind: ref
            id: region
            dataset_name: superstore_sales
        y:
        - source:
            kind: ref
            id: sales_sum
            dataset_name: superstore_sales
        sort:
        - source:
            kind: ref
            id: region
            dataset_name: superstore_sales
          direction: ASC
        colors: []
  dashboards:
  - name: main_dash
    dashboard:
      tabs:
      - id: default
        title: Default
        items:
        - id: tiid_chart_0
          element:
            kind: widget_container
            hide_title: true
            tabs:
            - id: wtid_total_sales_indicator
              chart_name: total_sales_indicator
              title: null
            default_widget_id: null
          placement:
            x: 0
            y: 2
            h: 2
            w: 2
        - id: tiid_chart_1
          element:
            kind: widget_container
            hide_title: true
            tabs:
            - id: wtid_sales_per_region
              chart_name: sales_per_region
              title: null
            default_widget_id: null
          placement:
            x: 2
            y: 2
            h: 2
            w: 2
```


## connection_create

Create a connection in an existing workbook.


### Request

| Field | Type | Description |
------|-----|----------
| `workbook_id` | **str** * |
| `connection` | **ConnectionInstance** * |
| `connection`.`name` | **str** * |
| `connection`.`connection` | [Connection](Connection.md) * |
| `secret` | [Secret](Secret.md) * |
### Response

| Field | Type | Description |
------|-----|----------
| `connection_info` | **EntryInfo** * |
| `connection_info`.`kind` | **enum/str[`connection` / `dataset` / `chart` / `dashboard`]** * |
| `connection_info`.`name` | **str** * |
| `connection_info`.`id` | **str** * |
### Examples

#### Example: CHYT

##### Request

```yaml
kind: connection_create
workbook_id: the_bottomless_abyss/temporary_wb_1
connection:
  name: main_connection
  connection:
    kind: ch_over_yt
    raw_sql_level: 'off'
    cache_ttl_sec: null
    cluster: hahn
    clique_alias: '*ch_datalens'
secret:
  kind: plain
```


##### Response

```yaml
kind: connection_create
connection_info:
  kind: connection
  name: main_connection
  id: as123m34
```


#### Example: CHYT User Auth

##### Request

```yaml
kind: connection_create
workbook_id: the_bottomless_abyss/temporary_wb_1
connection:
  name: main_connection
  connection:
    kind: ch_over_yt_user_auth
    raw_sql_level: 'off'
    cache_ttl_sec: null
    cluster: hahn
    clique_alias: '*ch_datalens'
secret: null
```


##### Response

```yaml
kind: connection_create
connection_info:
  kind: connection
  name: main_connection
  id: as123m34
```


#### Example: ClickHouse

##### Request

```yaml
kind: connection_create
workbook_id: the_bottomless_abyss/temporary_wb_1
connection:
  name: main_connection
  connection:
    kind: clickhouse
    raw_sql_level: subselect
    cache_ttl_sec: null
    host: example.com
    port: 443
    username: user
    secure: true
secret:
  kind: plain
```


##### Response

```yaml
kind: connection_create
connection_info:
  kind: connection
  name: main_connection
  id: as123m34
```


## advise_dataset_fields

Create a dataset configuration based on the data source schema. The request includes a dataset with an empty list of fields.

The response includes a dataset with all the fields from the data source. To retrieve a schema, use a connection from the `connection_ref` field. IDs of the fields will be generated based on the column names. It's expected that the user will override them.


### Request

| Field | Type | Description |
------|-----|----------
| `connection_ref` | [EntryRef](EntryRef.md) * |
| `partial_dataset` | [Dataset](Dataset.md) * |
### Response

| Field | Type | Description |
------|-----|----------
| `dataset` | [Dataset](Dataset.md) * |
### Examples

#### Example: 1

##### Request

```yaml
kind: advise_dataset_fields
connection_ref:
  kind: id_ref
  id: '%my_connection_id%'
partial_dataset:
  fields: []
  avatars: null
  sources:
  - id: main
    title: Sample Superstore
    connection_ref: '%this_name_will_not_be_taken_in_account%'
    spec:
      kind: sql_query
      sql: SELECT * FROM `//home/yandexbi/samples/sample_superstore`
```


##### Response

```yaml
kind: advise_dataset_fields
dataset:
  fields:
  - id: category
    title: Category
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Category
      avatar_id: main
  - id: city
    title: City
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: City
      avatar_id: main
  - id: country
    title: Country
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Country
      avatar_id: main
  - id: customer_id
    title: Customer ID
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Customer ID
      avatar_id: main
  - id: customer_name
    title: Customer Name
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Customer Name
      avatar_id: main
  - id: discount
    title: Discount
    description: null
    hidden: false
    cast: float
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Discount
      avatar_id: main
  - id: order_date
    title: Order Date
    description: null
    hidden: false
    cast: date
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Order Date
      avatar_id: main
  - id: order_date_str
    title: Order Date Str
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Order Date Str
      avatar_id: main
  - id: order_id
    title: Order ID
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Order ID
      avatar_id: main
  - id: postal_code
    title: Postal Code
    description: null
    hidden: false
    cast: integer
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Postal Code
      avatar_id: main
  - id: product_id
    title: Product ID
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Product ID
      avatar_id: main
  - id: product_name
    title: Product Name
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Product Name
      avatar_id: main
  - id: profit
    title: Profit
    description: null
    hidden: false
    cast: float
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Profit
      avatar_id: main
  - id: quantity
    title: Quantity
    description: null
    hidden: false
    cast: integer
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Quantity
      avatar_id: main
  - id: region
    title: Region
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Region
      avatar_id: main
  - id: row_id
    title: Row ID
    description: null
    hidden: false
    cast: integer
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Row ID
      avatar_id: main
  - id: sales
    title: Sales
    description: null
    hidden: false
    cast: float
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Sales
      avatar_id: main
  - id: segment
    title: Segment
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Segment
      avatar_id: main
  - id: ship_date
    title: Ship Date
    description: null
    hidden: false
    cast: date
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Ship Date
      avatar_id: main
  - id: ship_date_str
    title: Ship Date Str
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Ship Date Str
      avatar_id: main
  - id: ship_mode
    title: Ship Mode
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Ship Mode
      avatar_id: main
  - id: state
    title: State
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: State
      avatar_id: main
  - id: sub-category
    title: Sub-Category
    description: null
    hidden: false
    cast: string
    aggregation: none
    calc_spec:
      kind: direct
      field_name: Sub-Category
      avatar_id: main
  avatars:
    definitions:
    - id: main
      source_id: main
      title: Sample Superstore
    root: main
    joins: []
  sources:
  - id: main
    title: Sample Superstore
    connection_ref: main_connection
    spec:
      kind: sql_query
      sql: SELECT * FROM `//home/yandexbi/samples/sample_superstore`
```

