When you set up federation authentication, users can log in to the management console from a link containing the federation ID. You must specify the same link when configuring the authentication server.

Obtain and save this link:

1. Get the federation ID:
    1. Open the folder page in the [management console]({{ link-console-main }}).
    1. Select the **Federations** tab in the left menu.
    1. Copy the ID of the federation you're configuring access for.

1. Generate a link using this ID:

    `https://{{ auth-host }}/federations/<federation ID>`

