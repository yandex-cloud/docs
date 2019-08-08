# Database management

{% if audience == "internal" %}

## Creating a database {#create-db}

1. Go to the [management console](https://ydb.yandex-team.ru) and click **Create database**.

    ![Create database](../_assets/db_ui_create_database_button.png)

1. Configure database parameters in the dialog box:
    1. Cluster. You can choose a single data center cluster (`ydb-vla`, `ydb-sas`, `ydb-man`, and `ydb-myt`) or a multiple data center cluster (`ydb-ru` in VLA-SAS-MYT data centers, or `ydb-eu` in VLA-SAS-MAN data centers).

    {% note important }

    For the current {{ ydb-short-name }} installation, `ydb-ru` clusters are available in VLA-SAS-MYT data centers.
    
    {% note }

    1. **Account**. If you are just starting to use {{ ydb-short-name }} and don't have a project account, fill out the [form](https://st.yandex-team.ru/createTicket?template=1911&queue=KIKIMR) to create an account. If you want to try creating a personal database for testing purposes, use your *home* account.

    1. **Directory**. Select a directory from the list of existing directories for the selected account, or create a new directory. If you selected the *home* account, a directory with your username is created automatically. The directory name is case-sensitive, it must start with a Latin letter followed by Latin letters, numbers, underscores (_), or hyphens (-).

    1. **Name**. The database name has the same restrictions as the directory name.

    1. **Computing resources** The type and amount of computing resources (compute units).

    1. **Distribution policy**. Policy for distributing computing resources between data centers in multiple data center clusters (distribution policy). Possible options:
        * *auto* — Computing resources are located in available data centers. If a data center goes offline, computing resources are moved to the other available data centers.
        * *in one DC* — Computing resources are located in a single data center. If it goes offline, the computing resources move to another data center, and are again hosted in a single data center.
        * *uniform distribution* — Computing resources are distributed evenly among data centers. If one data center goes offline, computing resources are moved to the other data centers.

    1. **Storage groups**. Type and number of storage groups. Each storage group corresponds to a specific storage schema that affects the number of disks used, the failure model, and the redundancy factor. The ``block4-2`` schema is commonly used for single data center clusters, where the storage group is located on 8 disks in 8 racks, can withstand the failure of any two disks, and ensures a redundancy factor of 1.5. In multiple data center clusters, we use the ``mirror3dc`` schema, where storage groups are made up of 9 disks, 3 in each of the three data centers, which can survive the failure of a data center or disk, and ensures a redundancy factor of 3. A storage group can consist of any of the following types of storage devices: SATA HDDs, SATA SSDs, NVMe SSDs.

    {% note important %}

    For the current {{ ydb-short-name }} installation, only SATA SSDs are available.
    
    {% endnote %}

1. Click **Create** button to create a database with specified parameters.

Sample form for creating a database:

![Create new database](../_assets/db_ui_create_new_database.png)

## Viewing the list of databases {#db-list}

To view the list of databases, go to the [web interface](https://ydb.yandex-team.ru) homepage.
A list of created databases appears on the page. The full name of the database, its location (cluster), the resources reserved for the database, and the resources used are specified for each database.

![List databases](../_assets/db_ui_list_databases.png)

## Creating custom databases {#create-custom-db}

Currently, only a system administrator can create custom sized databases.
To change the parameters of a created database, submit a [request form](https://st.yandex-team.ru/createTicket?template=2082&queue=YDBREQUESTS).

## Changing database parameters {#change-db-params}

Currently, only a system administrator can change database parameters.
To change database parameters, submit a [request form](https://st.yandex-team.ru/createTicket?template=1918&queue=YDBREQUESTS).

## Deleting databases {#delete-db}

Currently, only a system administrator can delete databases.
To delete a database, submit a [request form](https://st.yandex-team.ru/createTicket?template=1919&queue=YDBREQUESTS).

{% else if audience == "external" %}

{% include [create_db](../_includes/create_db.md) %}

## Viewing the list of databases {#db-list}

To view the list of databases, go to the homepage of the **Database** management console.
A list of created databases appears on the page. The list shows the full name and [VM status](../../compute/concepts/vm-statuses.md) for each database.

## How to query a database {#db-query}

To query a database:

1. Select a database on the homepage of the management console.

1. Click **SQL query** in the upper-right corner. The **Root folder** page opens. Queries entered in the **Query** field are sent to the database.

1. Enter your query. For example, to create a new table, paste the following query:

    ```
    CREATE TABLE series                             
    (
        series_id Uint64,
        title Utf8,
        series_info Utf8,
        release_date Uint64,
        PRIMARY KEY (series_id)
    );
    ```

1. Click **Run**. The new *series* table and the name of the table owner are shown in the box on the left. If you hover the cursor over a table and click the <svg viewBox="0 0 24 24" width="18" height="18" fill="#26a"><path id="icon.info" d="M11,9H13V7H11M12,20C7.59,20 4,16.41 4,12C4,7.59 7.59,4 12,4C16.41,4 20,7.59 20,12C20,16.41 16.41,20 12,20M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M11,17H13V11H11V17Z"></path></svg> icon to the right of the table, the database schema is shown in the lower-left corner of the screen.

{% endif %}

