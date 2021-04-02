## Examples {#examples}

### Add a user with read-only permissions {#user-read-only}

To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the `user2` username and password (from 8 to 128 characters).
  1. Select the `db1` database from the **Add database** drop-down list.
  1. Select the role `read` from the drop-down list next to the `db1` database.
  1. Click **Add**.

- CLI

  Run the following command:

  ```
  yc managed-mongodb user create user2 \
    --cluster-name <cluster name>
    --password <user password> \
    --permission database=db1,role=read
  ```

{% endlist %}

