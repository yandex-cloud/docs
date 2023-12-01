# Delivering responses to a database using {{ sf-name }}

You can deliver form responses to a PostgreSQL database created in {{ yandex-cloud }} and store them there.

## Step 1. Create a database

1. Go to the [{{ yandex-cloud }} management console]({{ link-console-main }}) and select the folder where you want to create a database.
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ mpg-full-name }}.
1. In the top-right corner, click **Create cluster**.
1. Configure the cluster:
    1. Under **Basic parameters**, fill in the **Cluster name** field. The name may contain uppercase anlowercase Latin letters, numbers, underscores, and hyphens.
    1. Under **Database**, fill in the **DB name** and **Username** fields. The names may contain uppercase and lowercase Latin letters, numbers, underscores, and hyphens.
    1. Under **Database**, fill in the **Password** field.
    1. Under **Database**, set the **Locale for sorting (LC_COLLATE)** and **Charset locale (LC_CTYPE)*fields to **en_US.UTF8**. Once you create a database, you cannot change these parameters.
    1. Under **Additional settings**, enable **Access from the management console** and **Serverlesaccess**.
    1. Configure other parameters if needed. For more information, see [{#T}](../managed-postgresql/operations/cluster-create.md).
1. Click **Create cluster**.
1. Wait until the new cluster's **Availability** field changes to **Alive**.

## Step 2. Create a table

1. Go to the page of the created cluster.
1. In the left-hand panel, click **SQL**.
1. Select the appropriate username and database, enter the password, and click **Connect**.
1. Select the **public** schema.
1. Run the following query in the SQL editor:
    ```sql
    create table answers(
        id serial primary key,
        answer jsonb,
        created timestamp with time zone default now()
    );
    ```

## Step 3. Create a connection to the database

1. In the [management console]({{ link-console-main }}), return to the folder with the new cluster.
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ sf-name }}.
1. In the left-hand panel, click ![](../_assets/forms/svg/database-connect.svg).
1. In the top-right corner, click **Create connection**.
1. Set up a connection:
    1. Fill in the **Name** field. The name may only contain lowercase Latin letters, numbers, and hyphens.
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
	
    def run_function(connection, answer, **params) -> int:
    data = {
        'answer': answer,
        'params': params,
    }
    args = (json.dumps(data), )
    with connection.cursor() as c:
        c.execute('insert into answers(answer) values(%s) returning id', args)
        rs = c.fetchone()
	
    connection.commit()
    return rs[0]
	
    def get_connection(context):
    return psycopg2.connect(
        database="<connection_id>",
        user="<username>",
        password=context.token["access_token"],
        host="<entry_point>",
        port=6432,
        sslmode="require",
    )	
	
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

From now on, all responses from this form will be additionally saved to your database in the **answers** table.
