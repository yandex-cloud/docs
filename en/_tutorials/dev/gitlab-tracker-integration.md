# Integration with {{ GL }} in {{ tracker-full-name }}

To link {{ GL }} Merge Requests to {{ tracker-full-name }} issues, set up a webhook:

1. If you do not have an OAuth token for working with the {{ tracker-name }} API yet, [get one](../../tracker/concepts/access.md#section_about_OAuth).
1. Open your project in {{ GL }}.
1. In the left-hand menu, select **Settings** → **Webhooks**.
1. Specify the webhook parameters:
   * **URL**: `https://st-api.yandex-team.ru/v2/system/gitlab/receive`.
   * **Secret token**: OAuth token in `OAuth <token>` format. This is the OAuth token of the bot the links will be added under.
   * In the **Trigger** section, disable all options except **Merge request events**.
   * In the **SSL verification** section, select **Enable SSL verification**.
1. Click **Add webhook**.

Once your webhook is created, specify the respective issue's [key](../../tracker/glossary.md#key) in the name or description of a new Merge Request (a link to it will automatically appear in the issue under **{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}**).
