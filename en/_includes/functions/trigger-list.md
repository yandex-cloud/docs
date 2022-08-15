{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of triggers.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get a list of triggers:

   ```
   yc serverless trigger list
   ```

   Result:

   ```
   +----------------------+------------+----------------------+
   |          ID          |    NAME    |      FOLDER ID       |
   +----------------------+------------+----------------------+
   | dd0gj5tsj2pq9at8ja8i | my-trigger | aoek49ghmknnpj1ll45e |
   +----------------------+------------+----------------------+
   ```

- API

   You can get a list of triggers using the [list](../../functions/triggers/api-ref/Trigger/list.md) API method.

{% endlist %}
