Make sure you have a routing instance in your default folder:

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc cloudrouter routing-instance list
  ```

  If your folder already contains a routing instance, the command will output something like this:

  ```text
  +----------------------+-------------------------------------------+--------+-----------------------+
  |          ID          |                    NAME                   | STATUS | PRIVATE CONNECTION ID |
  +----------------------+-------------------------------------------+--------+-----------------------+
  | cf35oot8f0eu******** | ajeol2afu1js********-enpcfncr6uld******** | ACTIVE | cf395uf8dg7h********  |
  +----------------------+-------------------------------------------+--------+-----------------------+
  ```

{% endlist %}