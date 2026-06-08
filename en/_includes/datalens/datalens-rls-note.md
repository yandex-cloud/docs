{% note warning %}

* When using RLS, restrict access to the connection by using the `Execute` permission. This will prevent changes to row access permissions and restrict access to opening the preview window and creating a new dataset based on the connection.

* RLS only supports access control for row values.

* The RLS limits apply to whole rows, not just the fields used to configure access control.

{% endnote %}
