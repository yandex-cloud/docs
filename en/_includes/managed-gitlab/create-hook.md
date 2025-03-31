### Create a hook for integration {#create-hook}

To link {{ GL }} merge requests to {{ tracker-name }} issues, create a hook:

1. If you do not have an OAuth token for working with the {{ tracker-name }} API yet, [get one]({{ link-tracker-cloudless }}concepts/access#section_about_OAuth).
1. Check if you have access to the API by [requesting information about the current user]({{ link-tracker-cloudless }}get-user-info).
1. Open a {{ GL }} instance and go to the hook settings:
    * To enable integration for the entire [{{ GL }} instance](../../managed-gitlab/concepts/index.md) ({{ GL }} admin privileges are required):
        1. In the left-hand panel, click the **Your work** drop-down list and select **Admin Area**.
        1. Go to **System Hooks**.
    * To enable integration for an individual project:
        1. Go to the project you need.
        1. In the left-hand panel, click **Settings** and select **Webhooks**.
1. Specify the hook parameters:
    * **URL**: `https://api.tracker.yandex.net/v2/system/gitlab/receive?comments=true&<organization_type>=<organization_ID>`.

       Where:

        * `comments=true`: Enables automatic creation of comments in an issue with a link to and information about merge requests. Disable it if commenting is not required. This parameter is only available for {{ mgl-name }}.
        * `<organization_type>`: It may take the following values:

            * `x_cloud_org_id`: If the type of your organization is {{ org-full-name }}.
            * `x_org_id`: If the type of your organization is {{ ya-360 }} or both {{ ya-360 }} and {{ org-full-name }}.

        * `<organization_ID>`: ID of the organization from the [{{ tracker-name }} organizations page]({{ link-tracker }}admin/orgs).

    * **Secret token**: OAuth token of the bot that will be used to add the links, in `OAuth <token_contents>` format.
      For example: `OAuth y1_AQAD-qJScAAAEKEQbBNnChvfBIqR_yEQl_HMO0********`.
    * In the **Trigger** section, disable all options except **Merge request events**.
    * In the **SSL verification** section, select **Enable SSL verification**.

1. Click **Add system hook** (**Add webhook** for an individual project).

The **System Hooks** (**Project Hooks** for an individual project) section with information about the created hook and its parameters will appear on the page.
