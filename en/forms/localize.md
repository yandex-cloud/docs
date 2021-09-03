# Translate the form into other languages

If the form is used in a service that supports multiple interface languages, translate the form. Depending on the language selected by the user in their Yandex account settings, the form is displayed in the closest available language. If the form is embedded in a service page, specify the GET parameter `lang` to select the display language when calling the form.

## Form translation restrictions {#restrictions}

* The original form must be in Russian.

* The form in a foreign language will contain the same fields as the original form in Russian. If you need a form with a different set of fields in a foreign language, [create a new form](new-form.md).

* You can only translate forms in the old admin panel.

* The supported languages are specified in the [translation requests](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/) form.

## Request translation of the form {#request}

1. Open the form you want to translate.

1. Go to the old admin panel {{ forms-name }}. To do this, click **Go to the old version** on the top panel.

1. In the old admin panel, click **Settings** at the top of the page, and then select **Localization** in the left panel.

1. To send texts to Tanker for translation, select any language and click **Request translation into the selected languages** at the bottom of the page. The translation request form will open in a new browser tab, and the **Keys for translation in Tanker** link will appear in the **Localization** section.

    The process for exporting keys to Tanker does not depend on the languages you selected.

1. In the **Localization** section, copy the link to the keys in Tanker.

2. Fill out the translation request form that pops up: select the languages to translate into and enter the link to the set of keys in Tanker. A ticket is automatically created from the request in the TRANSLATE queue.

    {% note info %}

    If the request form did not pop up automatically, fill out the request form [here](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/).

    {% endnote %}

3. Wait until the translation ticket is completed and the translation keys are uploaded to Tanker.

4. In the old admin panel, go to **Settings** → **Localization** and click **Check translation statuses**. After that, the form will be displayed in the selected languages.

5. If you need to set up integrations for the form depending on the user's language, you can also do this from the old admin panel {{ forms-name }}. To learn more, [go to {{ wiki-name }}](https://wiki.yandex-team.ru/forms/instruction/integrations/#obshhienastrojjkiintegracii).

## Change a translated form {#repeat}

If you change the texts in a form or add new texts, make a translation request for the form one more time:

1. In the old admin panel, go to **Settings** → **Localization** and click **Request translation into the selected languages**. Text changes will be sent to Tanker.

1. Fill out a new [translation request for the form](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/).

1. When new translations are uploaded to Tanker, in the old admin panel, go to **Settings** → **Localization** and click **Check translation statuses**.

