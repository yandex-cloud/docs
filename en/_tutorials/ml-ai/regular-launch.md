You can set up regular run scenarios in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) using the API by triggering notebook cell execution in [{{ sf-full-name }}](../../functions/index.yaml).

In this tutorial, you will collect information about the most discussed stocks on [Reddit](https://tradestie.com/api/v1/apps/reddit), analyze the sentiment of the discussion, and set up regular data updates.

Information is collected and analyzed in {{ ml-platform-name }}. Regular cell execution is triggered by a timer created in {{ sf-name }}.

To set up regular runs of {{ jlab }} Notebook:

1. [Prepare your infrastructure](#infra).
1. [Create a notebook](#create-notebook).
1. [Upload and process data](#load-data).
1. [Create a {{ sf-name }}](#create-function).
1. [Create a timer](#create-timer)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of implementing regular runs includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for the number of [{{ sf-name }}](../../functions/pricing.md) function calls.

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

To access a {{ ml-platform-name }} project from a {{ sf-name }} function, you need a service account with the `{{ roles-datasphere-project-editor }}` and `{{ roles-functions-invoker }}` roles.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `reddit-user`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `{{ roles-datasphere-project-editor }}` and `{{ roles-functions-invoker }}` roles to the service account.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to a project {#sa-to-project}

To enable the service account to run a {{ ml-platform-name }} project, add it to the list of project members.

{% list tabs group=instructions %}

- Management console {#console}

    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    1. Select the `reddit-user` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

### Configure the project {#setup-project}

To reduce {{ ml-platform-name }} usage costs, configure the time to release the VM attached to the project.

1. {% include [include](../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.common.general }}**, click ![pencil](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. To configure **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}**, select `{{ ui-key.yc-ui-datasphere.common.custom }}` and specify 5 minutes.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Create a notebook {#create-notebook}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait for the loading to complete.
1. In the top panel, click **File** and select **New** → **Notebook**.
1. Select a kernel and click **Select**.
1. Right-click the notebook and select **Rename**. Enter the name: `test_classifier.ipynb`.

## Upload and process data {#load-data}

To upload information on the most discussed stocks on Reddit and the sentiment of the discussion, paste the code to the `test_classifier.ipynb` notebook cells. You will use it to select the top three most discussed stocks and save them to a CSV file in project storage.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Import the libraries:

    ```python
    import pandas as pd
    import requests
    import os.path
    ```

1. Initialize the variables:

    ```python
    REQUEST_URL = "https://tradestie.com/api/v1/apps/reddit"
    FILE_NAME = "/home/jupyter/datasphere/project/stock_sentiments_data.csv"
    TICKERS = ['NVDA', 'TSLA', 'AAPL']
    ```

1. Create a function that sends a request to the Tradestie API and returns a response as `pandas.DataFrame`:

    ```python
    def load_data():
        response = requests.get(REQUEST_URL)
        stocks = pd.DataFrame(response.json())
        stocks = stocks[stocks['ticker'].isin(TICKERS)]
        stocks.drop('sentiment', inplace=True, axis=1)
        return stocks
    ```

1. Set a condition that defines a file to write stock information to:

    ```python
    if os.path.isfile(FILE_NAME):
        stocks = pd.read_csv(FILE_NAME)
    else:
        stocks = load_data()
        stocks['count'] = 1
        stocks.to_csv(FILE_NAME, index=False)
    ```

1. Upload the updated stock data:

    ```python
    stocks_update = load_data()
    ```

1. Compare the updated and existing data:

    ```python
    stocks = stocks.merge(stocks_update, how='left', on = 'ticker')
    stocks['no_of_comments_y'] = stocks['no_of_comments_y'].fillna(stocks['no_of_comments_x'])
    stocks['sentiment_score_y'] = stocks['sentiment_score_y'].fillna(stocks['sentiment_score_y'])
    ```

1. Update the arithmetic average count and sentiment scores:

    ```python
    stocks['count'] += 1
    stocks['no_of_comments_x'] += (stocks['no_of_comments_y'] - stocks['no_of_comments_x'])/stocks['count']
    stocks['sentiment_score_x'] += (stocks['sentiment_score_y'] - stocks['sentiment_score_x'])/stocks['count']
    stocks = stocks[['no_of_comments_x', 'sentiment_score_x', 'ticker', 'count']]
    stocks.columns = ['no_of_comments', 'sentiment_score', 'ticker', 'count']
    print(stocks)
    ```

1. Save the results to a file:

    ```python
    stocks.to_csv(FILE_NAME, index=False)
    ```

## Create a {{ sf-name }} {#create-function}

To start computations without opening {{ jlab }}Lab, you need a {{ sf-name }} that will trigger computations in a notebook via the API.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter a name for the function, e.g., `my-function`.
    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-function }}**.

{% endlist %}

### Create a {{ sf-name }} version {#create-function-ver}

[Versions](../../functions/concepts/function.md#version) contain the function code, run parameters, and all required dependencies.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function to create a version of.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the `Python` runtime environment. Do not select the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
    1. Choose the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}** method.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** and specify a file name, e.g., `index`.
    1. Enter the function code by inserting your project ID and the absolute path to the project notebook:

        ```python
        import requests
    
        def handler(event, context):

            url = 'https://datasphere.{{ api-host }}/datasphere/v2/projects/<project_ID>:execute'
            body = {"notebookId": "/home/jupyter/datasphere/project/test_classifier.ipynb"}
            headers = {"Content-Type" : "application/json",
                       "Authorization": "Bearer {}".format(context.token['access_token'])}
            resp = requests.post(url, json = body, headers=headers)

            return {
            'body': resp.json(),
            }
        ```

       Where:
       * `<project_ID>`: ID of the {{ ml-platform-name }} project displayed on the project page under its name.
       * `notebookId`: Absolute path to the project notebook.

    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, set the version parameters:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
       * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `reddit-user`.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Create a timer {#create-timer}

To run a function every 15 minutes, you will need a [timer](../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a timer.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**, set the function invocation schedule to `{{ ui-key.yacloud.common.button_cron-15min }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

       * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}](../../functions/concepts/function.md#tag).
       * `reddit-user` {{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }} used to call the function.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

From now on, the `stock_sentiments_data.csv` file will be updated every 15 minutes. You can find it next to the notebook.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete](../../functions/operations/function/function-delete) the function.
* [Delete](../../functions/operations/trigger/trigger-delete) the trigger.
* [Delete](../../datasphere/operations/projects/delete) the project.
