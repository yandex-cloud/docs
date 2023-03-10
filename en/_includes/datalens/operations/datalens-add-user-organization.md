1. Make sure you are authorized in {{ yandex-cloud }} as an administrator or owner of the organization (your user holds the `admin` or `owner` role for the organization). In the top left-hand corner, click ![image](../../../_assets/datalens/all-services.svg) and select **Resources and management** → **Manage organization services** or click the [link]({{ link-org-users }}).

1. In the top right-hand corner, click **Add user**. In the resulting window, enter the email address of a Yandex user and click **Add**. The new user will appear in the list of organization users.

   {% note warning %}

   At this time, you can only add a user with a Yandex account. Other accounts are not supported.

   {% endnote %}

1. Assign this user a role for accessing {{ datalens-short-name }}:

   1. Open the **Configure permissions** window:

      {% include [configure-roles-console](../../iam/configure-roles-console.md) %}
   1. In the **Configure access rights** window, click **![image](../../../_assets/plus-sign.svg) Add role**. Choose the `{{ roles-datalens-instances-user }}` role from the list.
   1. Click **Save**. The user will gain access to {{ datalens-short-name }}.
