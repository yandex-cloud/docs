---
title: 'How to use LLMs to work with {{ ydb-full-name }} via an MCP server: Cursor IDE example'
description: You can connect to {{ ydb-short-name }} via an MCP server and use LLMs to manage the database. The avaiable features depend on the model you use.
---

# How to use LLMs to work with {{ ydb-full-name }} via an MCP server: Cursor IDE example

In this tutorial, you will learn how to work with a {{ ydb-short-name }} database using LLMs. This will allow you to manage your database using a human language to fix errors, optimize the DB, and analyze data.

As an example, we will take a cloud-based or local {{ ydb-short-name }} instance that you will connect to via a MCP server running on your machine. We will use the Cursor IDE to access the MCP server and integrate an LLM for natural language processing. You can easily write and send queries in your native language, and the model, along with the MCP server, will convert them into accurate SQL queries for YDB and assist with error correction and optimizations.

- [Terms](#terms)
- [Getting started](#before-start)
- [Preparing the environment](#prepare)
- [Working with YDB MCP](#ydb-mcp-examples)
- [Prompts for experimentation](#prompts)
- [Results](#results)
- [Deleting resources](#delete-resources)


## Terms {#terms}

**[Cursor](https://cursor.com/)**: IDE with native LLM integration.

**LLM**: Large language model, e.g, YandexGPT. It can generate text, but cannot connect to external systems, such as databases, on its own. To enable access to such systems, you need an MCP client, e.g., `Cursor`, that connects to an MCP server which, in turn, interacts with the database.  

**MCP (Model Context Protocol)**: Open protocol an MCP client uses to connect to an MCP server and enable LLM access to external systems. For more information on MCP, see this page.

**MCP client**: Software connecting an LLM with an MCP server and integrating MCP server tools in a dialog for the LLM to use. In this tutorial, we are using the `Cursor` IDE as an MCP client.  

**MCP server**: Standalone application that connects to an external system (in our case, {{ ydb-short-name }}) and enables access to specific tools. The MCP server itself does not have any complex logic; it only connects the LLM to external systems. The LLM decides how and which tools to use based on the prompt you provide. Different LLMs may have their distinct approaches to a task: one would generate a final YQL query right away, while another would iterate on versions and fix errors on the fly.

**ydb-mcp**: MCP server implemented by the {{ ydb-short-name }} team. 

For different operations, ydb-mcp offers different tools, e.g., `ydb_status` tests the connection, and `ydb_query` sends queries. These tools are similar to API functions: you feed them parameters and get a result.

It is the same with developers: with the same API, each one will have different code. In the case of LLMs, the result depends not only on the MCP server but also the model’s capabilities.

## Getting started {#before-start}


### Paid resources {#paid-resources}

1. [Cursor IDE](https://cursor.com/) account (you can use the trial version).
1. {{ ydb-short-name }} fee: Database operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).

{% note info %}

You can use this tutorial with other IDEs or models. Here, we selected Cursor as a ready-made solution to skip the setup step.

{% endnote %}

## Preparing the environment {#prepare}

1. Install the [Cursor IDE](https://cursor.com/).
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [Docker Engine (CE)](https://docs.docker.com/engine/install/) together with the [Docker Compose](https://docs.docker.com/compose/install/) plugin, which you will need to run the project.


### Clone and open the project {#copy-and-open-project}

1. Clone the project from the [ydb-mcp-demo-notes](https://github.com/ydb-platform/ydb-mcp-demo-notes) repository. If Git is not installed, download and unpack [main.zip](https://github.com/ydb-platform/ydb-mcp-demo-notes/archive/refs/heads/main.zip).
1. Open the project folder in the Cursor IDE: in the **File** menu, select **Open Folder** and specify the project folder.
1. Open the terminal (*View → Terminal* or **Ctrl/Cmd** + **Backtick**).
1. In the project folder, run the `docker compose build` command in the terminal to build the project’s containers.


### Create a database in {{ ydb-name }} {#create-db}

Create a database in [serverless mode](../../ydb/concepts/serverless-and-dedicated.md#serverless). This is a convenient option for a cloud environment. On a local machine, run a [docker container](https://ydb.tech/docs/en/quickstart) (Docker x86_64 tab):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select a folder to create a database in.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
     1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
     1. Specify a **{{ ui-key.yacloud.ydb.forms.label_field_name }}** for the database. Follow these naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

     1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
     1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
     1. Wait until the database starts. While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.
     1. Select the database you created.
     1. Under **{{ ui-key.yacloud.ydb.overview.section_connection }}**, find the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** and **{{ ui-key.yacloud.ydb.overview.label_path }}** fields and save their values. You will need them to configure a connection to the database.

   - YC CLI {#cli}

     You can create a {{ ydb-short-name }} database by calling the `yc` CLI utility.

     ```
     yc ydb database create test --serverless
     ```

   {% endlist %}


### Create an authorized key {#create-key}

If working with a local Docker container, skip this section.

 [Create](../../iam/operations/sa/create.md#create-sa) a service account and [assign](../../iam/operations/roles/grant.md#cloud-or-folder) it the `ydb.editor` role for your folder. In our example, we will use the LLM to update the database; if you do not need to do this, a more secure option is to assign the `ydb.viewer` role.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the service account you created.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Select the encryption algorithm.
  1. Enter a description for the [authorized key](../../iam/concepts/authorization/key.md) so you can easily find it in the management console.
  1. Save the key in the `authorized_key.json` file in the project folder:

     ```json
     {
       "service_account_id": "<sa-function_service_account_ID>",
       "key_algorithm": "RSA_2048",
       "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
       "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
     }
     ```

- CLI {#cli}

  In the project folder, run this command in the terminal:

  ```bash
  yc iam key create --service-account-name sa-function -o authorized_key.json
  ```

  For more information about the `yc iam key create` command, see this [CLI reference](../../cli/cli-ref/iam/cli-ref/key/create.md).

  If successful, the key will be saved to the `authorized_key.json` file.

{% endlist %}


{% note warning %}

The `authorized_key.json` file contains the key’s secret part that you can use to access databases in your folder. Keep it secure. In the demo project, it is already added to `.gitignore`.

{% endnote %}

### Specify settings database connection settings in ydb.env {#connection-settings-env}

If working with a local Docker container, skip this section.

1. Copy the `ydb-template.env` file to `ydb.env`.
1. Fill in the parameters for the connection to the database you created earlier:
    - `YDB_AUTH_MODE=service-account`: The key name (`authorized_key.json`) is built into the example; you do not needed to specify it.
    - `YDB_ENDPOINT` and `YDB_DATABASE`: Get values from the database info.


### Test the application {#check-app}

In the Cursor IDE terminal, from the project folder, run commands to test the application. After each step, make sure the commands complete without errors:

```
docker compose run --rm notes-app init
docker compose run --rm notes-app add "Test" "This is my first note in YDB-notes"
docker compose run --rm notes-app list
```


### Starting the MCP server {#mcp-start}

The parameters for starting the MCP server are already set in the `.cursor/mcp.json` file in the demo project. If you want to learn how and try running your own server, see [ydb-mcp tutorials](https://github.com/ydb-platform/ydb-mcp).

1. Open the **Cursor Settings** menu (do not confuse it with **VS Code Settings**).
1. Navigate to **MCP & Settings**.
1. Toggle on the switch next to **ydb**. If it is already on, toggle it off, then on again, so that the MCP server restarts with new settings.
1. After it starts, next to the **ydb** MCP server, you will see a list of tools and an icon indicating the server is running.
1. Test the connection by opening the AI panel on the right (**Ctrl/Cmd** + **L**) and entering this in the chat: "Check connection to {{ ydb-short-name }}". The output should inform you that the connection works correctly.


### Select a model {#select-model}

If you are using a trial account, skip this section as you will be unable to select a model. All examples from this tutorial will also work for the `auto` mode, but the model will be able to perform more operations, and the result will be less predictable.

In the chat window under the input field, find the **Auto** sign, click it, and disable auto selection in the window that opens.

You will see a list of available models: select a model from the `claude-` family, e.g., `claude-4-sonnet` or a newer version.

The LLM you select does not affect the MCP server performance. However, the steps and the result are directly affected by the choice of model: it is the model that decides which operations to perform via MCP. Examples in this tutorial were tested using `claude-4-sonnet` in `Auto` mode, but you can try other models as well.


## Working with YDB MCP {#ydb-mcp-examples}


### Populating a table with test data via the MCP server {#test-data-with-mcp}

Sometimes you have to populate an empty database with test data. You can delegate this task to the LLM: it will generate data and add it to the database via the MCP server.

Example command for the LLM:

```
Create 15 test notes and write them to {{ ydb-short-name }}. The note dates must be within the `2001-01-01` to `2001-12-31` range. The notes should be in English and Russian.
```

Here is how it works:

1. Cursor provides the description of the MCP server and its tools to the model.
1. The LLM uses the `ydb_status` tool to test the database connection.  
1. The LLM uses `ydb_query` to send queries to add rows. This YQL query must be accurate: sometimes it is not accepted on first try. In which case the model rewrites the query based on the error text and tries again. The number of attempts depends on the model and the quality of the query. You do not need to intervene: the model will fix the errors all by itself and, finally, add the required number of notes.

To check the results, run the `docker compose run --rm notes-app list` command. You will see the notes the LLM has created. You can use this method to populate more complex databases as well.


### Fixing errors using the MCP server {#fix-code-with-mcp}

You can use LLMs not only to write code or populate a database, but also to fix errors. This way, you can troubleshoot errors in data, a database schema, or application source code. To demonstrate how it works, let’s create an error on purpose by **renaming a table** in the database.

Without MCP, the LLM would have only the source code and error text. In this case, it would suggest rerunning the `init` command or creating a table via a query. With MCP, there are more options: the model can request the database schema and perform any operation, e.g., undo table renaming or copy the table.


#### Fixing a database schema {#fix-database-with-mcp}

To simulate an error, rename the table:
1. Log in to the [management console]({{ link-console-main }}).
1. Go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}** and open your database.
1. Click **{{ ui-key.yacloud.ydb.database.switch_browse }}**, then **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**, and run this query to [rename the table](https://ydb.tech/docs/ru/yql/reference/syntax/alter_table/rename):

```
ALTER TABLE notes RENAME TO notes2
```

After that, run `docker compose run --rm notes-app list` and make sure you get the error.

Start a new Cursor chat and describe the issue: 

```
There is something I did, and the application stopped displaying notes. Check the database and fix it to make it work again. Do not modify the code. Error: <paste the error text here>
```

{% note info %}

The text copied from the Cursor terminal will not appear in the chat; the error will be displayed as a link in the window header.

{% endnote %}

The LLM will check the database’s current state via MCP, find the renamed table, and try to fix that. It may rename the table back, create a new table and transfer the data, or perform a migration. Each time you run the model, it may select different options.


#### Adjusting the source code to the schema updates  

Delete the temporary `notes2` table if left after the previous step so it does not affect any further tests:

```
DROP TABLE IF EXISTS notes2
```

Now, [rename](https://ydb.tech/docs/ru/yql/reference/syntax/alter_table/rename) the main table again:

```
ALTER TABLE notes RENAME TO notes_new
```

Open a new chat and run this command:

```
The table name in {{ ydb-short-name }} has changed. Fix the apps’ source code to use the new name and check  that all commands from the instructions still run correctly.
```


### Collecting analytics on the connected database {#mcp-analytics}

AnnLLM with ydb-mcp can be used not only for data modification, but also for analytical queries, e.g., to quickly get a summary or calculate statistics directly in the database.

- Calculate the distribution of the note creation time by hour of day (number of notes for each hour).
- Calculate the average and median note length values. Use YQL on the server side to run the calculations.


## Prompts for experimentation {#prompts}

Use cases for ydb-mcp go far beyond the scope this article covers. LLM access to a real database schema and data provides many integration opportunities. Below, you will find examples of other tasks you can experiment with.

- My query, `<...>`, works slowly, find ways to make it run faster.
- Create wrapper functions to access records in the `notes` table.
- Create CRUD functions for tables in my database.
- Implement an ability to store note attachments. Tell me how to achieve this with our current database schema.


## Results {#results}

Currently, LLMs can solve a wide range of tasks, but they cannot interact with the outside world. MCP provides this connection. When using the {{ ydb-short-name }} MCP server, an LLM gains access to the database and is able to manage it. Now, you are not limited to the source code database schema, but can also work with its actual state. For example, the LLM can change the database schemas or data.

{% note warning %}

Use LLMs with caution and do not connect to critical databases. Via an MCP server, an LLM gains all permissions assigned to the service account. We recommend creating a database copy to work with. For example, during its operation, the model may send a request to delete all data or run a very large query that would interfere with the main load.

{% endnote %}


## Deleting resources {#delete-resources}

To free up resources, follow [this guide](../../ydb/operations/manage-databases.md#delete-db) to delete the {{ ydb-short-name }} test database.
