# Creating a connection

{{ speechsense-name }} connections only support two-channel audio. To create a connection, you need either the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role for the space.

To create a connection:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.
1. In the top-right corner, click **More** → ![create](../../../_assets/console-icons/thunderbolt.svg) **Create connection**.
1. Name the new connection and, optionally, enter a description.
1. Under **Agent** and **Customer**:

   1. Specify the track numbers for both the agent's and customer's voices.
   1. Specify the agent and customer keys from the metadata file. This file contains call information obtained from PBX, CRM systems, or other sources.

      By default, connections include keys with the name and ID of the agent and customer. In the **Name in the system** field, enter a name for the key to be displayed in {{ speechsense-name }}. You can also add a description, if required.

      To specify additional metadata for the agent and the customer, click **Add key**.

1. Under **Shared metadata**, provide the keys from the metadata file that are not related to the agent or the customer.

   By default, connections include keys with the date, direction, and language of the call. In the **Name in the system** field, enter a name for the key to be displayed in {{ speechsense-name }}. You can also add a description, if required.

   To specify additional metadata, click **Add key**.

1. Click **Create connection**.
