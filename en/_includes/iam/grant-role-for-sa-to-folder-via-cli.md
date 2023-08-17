1. Select the role to assign to the service account. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

1. Find out the service account ID by its name:

   ```bash
   yc iam service-account get my-robot
   ```

   Result:

   ```bash
   id: aje6o61dvog2h6g9a...
   folder_id: b1gvmob95yysaplct...
   created_at: "2018-10-15T18:01:25Z"
   name: my-robot
   ```

   If you don't know the name of the service account, get a list of service accounts with their IDs:

   ```bash
   yc iam service-account list
   ```

   Result:

   ```bash
   +----------------------+------------------+-----------------+
   |          ID          |       NAME       |   DESCRIPTION   |
   +----------------------+------------------+-----------------+
   | aje6o61dvog2h6g9a... | my-robot         | my description  |
   +----------------------+------------------+-----------------+
   ```

1. Assign the `{{ roles-viewer }}` role to the `my-robot` service account using its ID:

   ```bash
   yc resource-manager folder add-access-binding my-folder \
     --role viewer \
     --subject serviceAccount:aje6o61dvog2h6g9a...
   ```