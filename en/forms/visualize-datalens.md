# Visualizing data in {{ datalens-name }} using {{ sf-name }}

You can deliver form responses to a PostgreSQL database created in {{ yandex-cloud }} and visualize them in {{ datalens-full-name }}.

With this guide, you will learn how to visualize:
* Number of form responses grouped by date.
* Statistics on responses to prompts of the **Short text** and **One option** type, grouped by date.

## Step 1. Create a database

1. Go to the [{{ yandex-cloud }} management console]({{ link-console-main }}) and select the folder where you want to create a database.
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ mpg-full-name }}.
1. In the top-right corner, click **Create cluster**.
1. Configure the cluster:
    1. Under **Basic parameters**, fill in the **Cluster name** field. The name may contain uppercase and lowercase Latin letters, numbers, underscores, and hyphens.
    1. Under **Database**, fill in the **DB name** and **Username** fields. The names may contain uppercase and lowercase Latin letters, numbers, underscores, and hyphens.
    1. Under **Database**, fill in the **Password** field.
    1. Under **Database**, set the **Locale for sorting (LC_COLLATE)** and **Charset locale (LC_CTYPE)** fields to **en_US.UTF8**. Once you create a database, you cannot change these parameters.
    1. Under **Additional settings**, enable **Access from the management console**, **Serverless access**, and **DataLens access**.
    1. Configure other parameters if needed. For more information, see [{#T}](../managed-postgresql/operations/cluster-create.md).
1. Click **Create cluster**.
1. Wait until the new cluster's **Availability** field changes to **Alive**.

## Step 2. Create tables

1. Go to the page of the created cluster.
1. In the left-hand panel, click **SQL**.
1. Select the appropriate username and database, enter the password, and click **Connect**.
1. Select the **public** schema.
1. Run the following SQL queries to create the following tables:
    1. Table to store all form responses:
        ```sql
        create table answers(
            id serial primary key,
            answer jsonb,
            created timestamp with time zone default now()
        );
        ```
    1. Table to count the number of form responses:
        ```sql
        create table answercount(
            id serial primary key,
            survey_id text not null,
            modified date not null default current_date,
            count int default 0,
            unique(survey_id, modified)
        );
        ```
    1. Table to store responses to prompts of the **Short text** and **One option** type:
        ```sql
        create table questioncount(
            id serial primary key,
            survey_id text not null,
            question_key text not null,
            option_key text not null default '',
            modified date not null default current_date,
            count int default 0,
            unique(survey_id, question_key, option_key, modified)
        );
        ```

## Step 3. Create a connection to the database

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ sf-name }}.
1. In the left-hand panel, click ![](../_assets/forms/svg/database-connect.svg).
1. In the top-right corner, click **Create connection**.
1. Set up a connection:
    1. Fill in the **Name** field. The name may only contain lowercase Latin letters, numbers, anhyphens.
    1. In the **Type** field, select **PostgreSQL**.
    1. Fill in the **Cluster**, **Database**, **User**, and **Password** fields. Enter the same field values as you set when creating your cluster in step 1.
1. Click **Create**.
1. Go to the connection page and copy the **Entry point** field value.

## Step 4. Create a service account

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.
1. In the top-right corner, click ![](../_assets/forms/svg/settings.svg) → **Create service account**.
1. In the service account creation window, fill in the following fields:
    1. **Name**; it may only contain lowercase Latin letters, numbers, and hyphens.
    1. **Description**; it may contain any characters.
    1. In the **Roles in folder** field, add the following roles:
        * `serverless.functions.invoker`
        * `serverless.mdbProxies.user`
1. Click **Create**.

## Step 5. Create a service account key

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.
1. Go to the **Service accounts** tab.
1. Select the account you need.
1. In the top panel on the account page, click **Create new key** → **Create API key**.
1. Provide a brief description for the key.
1. Click **Create**.
1. This will open a window with the key ID and the secret key. Store them in a secure place. You will not be able to access them after you close the window.

## Step 6. Create a cloud function

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.

1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ sf-name }}.

1. In the top-right corner, click **Create function**.

1. On the function creation page, fill in the following fields:
    1. **Name**; it may only contain lowercase Latin letters, numbers, and hyphens.
    1. **Description**; it may contain any characters.

1. Select the Python programming language.

1. Create a file named `requirements.txt` and add the following line to it:
    ```
    psycopg2
    ```

1. Create or edit a file named `index.py`:

    ```python
    import json
    import psycopg2

    def get_connection(context):
        return psycopg2.connect(
            database="<connection_ID>",
            user="<username>",
            password=context.token["access_token"],
            host="<entry_point>",
            port=6432,
            sslmode="require",
        )

    def run_function(connection, answer, **params):
        survey_id = answer['survey']['id']
        args = (survey_id, )

        with connection.cursor() as c:
            sql = '''
                insert into answercount as t (survey_id, count)
                values(%s, 1)
                on conflict (survey_id, modified)
                do update set count = t.count + excluded.count
            '''
            c.execute(sql, args)

        args, args_size = [], 0
        for question_key, question_data in answer['data'].items():
            match question_data['question']['answer_type']['slug']:
                case 'answer_choices':
                    for choice_item in question_data['value']:
                        args.extend([survey_id, question_key, choice_item['key']])
                        args_size += 1
                case 'answer_short_text':
                        args.extend([survey_id, question_key, ''])
                        args_size += 1

        with connection.cursor() as c:
            values = ','.join(['(%s, %s, %s, 1)'] * args_size)
            sql = '''
                insert into questioncount as t (survey_id, question_key, option_key, count)
                values{values}
                on conflict (survey_id, question_key, option_key, modified)
                do update set count = t.count + excluded.count
            '''.format(values=values)
            c.execute(sql, args)

        connection.commit()

    def handler(event, context):
        body = json.loads(event.get('body'))
        params = {
            name: value
            for name, value in body.items()
            if name != 'answer'
        }
        connection = get_connection(context)
        result = {
            'id': run_function(connection, body.get('answer'), **params),
        }

        return {
            'statusCode': 200,
            'body': result,
            'headers': {
                'Content-Type': 'application/json',
            }
        }
     ```

    Substitute the following values in this function:
    * `<connection_ID>`: Value of the **ID** field of the DB connection you created in step 3. You can copy it on the connection page.
    * `<username>`: DB username that you specified in the cluster settings in step 1. You can find it in the **Users** tab on the cluster page.
    * `<entry_point>`: Value of the **Entry point** field of the DB connection you created in step 3. You can copy it on the connection page.

1. Click **Save changes**.

1. On the function page, copy the value from the **ID** field.

## Step 7. Set up integration

1. Go to the form whose responses you want to deliver to the database and select the **Integrations** tab.
1. Select a group of actions to set up issue creation in and click {{ sf-name }} at the bottom of the group.
1. In the **Function code** field, paste the function ID that you copied in the previous step.
1. Under **Parameters**, you can optionally select additional parameters to be transferred to the function.
1. Click **Save**.

## Step 8. Connect {{ datalens-name }} to the database

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ datalens-name }}.
1. Click **Create connection** → **PostgreSQL**.
1. Set up a connection:
    1. In the **Cloud and folder** field, select the folder where you created the cluster.
    1. In the **Cluster** field, select the cluster that you created in step 1.
    1. In the **Host name** field, select a host.
    1. In the **Path to database** field, select the database where you created tables in step 2.
    1. In the **User** field, select the user that you created along with the cluster in step 1.
    1. In the **Password** field, enter the password that you created in step 1.
1. Click **Create connection**.

## Step 9. Create a chart

1. In the top-right corner, click **Create dataset**.
1. Drag the `public.answercount` table to the area in the middle of the page.
1. In the top-right corner, click **Create chart**.
1. Drag the table column names from the **Dimensions** section to the **Bar chart** panel as follows:
    * `modified` to the **X** field
    * `count` to the **Y** field
    * `survey_id` to the **Filters** field
1. Click **Save**.

## Step 10. Create a dashboard

1. Go back to the {{ datalens-name }} page.
1. Click **Create dashboard**.
1. Select the folder where you want to create your dashboard, name it, and click **Create**.
1. In the top panel, click **Add** → **Chart**.
1. In the add chart window:
    1. Fill in the **Name** field.
    1. In the **Chart** field, select the chart that you created in step 9.
    1. Click **Add**.
1. In the top-right corner, click **Save**.

You will get a bar chart with the number of form responses by date.

## Step 11. Set up the chart

1. Go to the page of the cluster that you created in step 1.
1. In the left-hand panel, click **SQL**.
1. Select the appropriate username and database, enter the password, and click **Connect**.
1. Select the **public** schema.
1. Run the following SQL query:
    1. Create a table that will store the information about chart colors:
        ```sql
        create table labels(
            id serial primary key,
            compound_key text not null,
            label text default '',
            unique(compound_key)
       );
        ```
    1. Add information about labels for prompt responses to this table:
        ```sql
        insert into labels(compound_key, label)
        values('id-radio.62019338', 'Option 1'), ('id-radio.62019364', 'Option 2'), ('id-radio.6201936'Option3');
        ```
    1. Create a view with a link between prompt IDs and response option IDs:
        ```sql
        create view questioncount_vw as
        select t.*,
            case
                when t.option_key = '' or t.option_key is null then t.question_key
                else t.question_key || '.' || t.option_key
            end as compound_key
        from questioncount t;
        ```

## Step 12. Set up display of colors in the chart

1. Open the {{ datalens-name }} page and go to the connection that you created in step 8.
1. In the top-right corner, click **Create dataset**.
1. Drag the `public.questioncount_vw` table to the middle of the page.
1. Drag the `public.labels` table to the middle of the page.
1. Click ![](../_assets/forms/datalens-inner-join.png =16x) between the table names in the middle of the page.
1. In the window that opens, click ![](../_assets/forms/datalens-inner-join.png =16x) once again, select the **left** value by the `compound key` field, and click **Save**.
1. Go to the **Fields** tab.
1. In the top panel, click **Add field**.
1. Fill in the fields of the field creation window:
    1. In **Field name**, enter `question_label`.
    1. In the main part of the field, enter:
         ```
        if [label] is not null then [label] else [compound key (1)] end
        ```
    1. Click **Save**.
1. In the top panel, click **Create chart**.
Drag the names from the **Dimensions** section to the **Bar chart** panel as follows:
    * `modified` to the **X** field
    * `count` to the **Y** field
    * `question_label` to the **Colors** field
    * `survey_id` and `question_key` to the **Filters** field
1. Click **Save**.

## Step 13. Place the new chart on the dashboard

1. Go to the dashboard that you created in step 10.
1. In the top panel, click **Add** → **Chart**.
1. In the add chart window:
    1. Fill in the **Name** field.
    1. In the **Chart** field, select the chart that you created in step 12.
    1. Click **Add**.
1. In the top-right corner, click **Save**.

Now, your dashboard contains two similar bar charts, single- and multicolor, whose colors depend on user responses.

## Step 14. Set up dashboard auto-update

1. In the top panel, click ![](../_assets/forms/svg/settings-2.svg).
1. In the window that opens, select **Auto-update** and set the interval between dashboard updates.
1. Click **Save**.
