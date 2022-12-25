# Localize forms to foreign languages

If a form is used in a service that supports multiple interface languages, localize the form. Depending on the language the user selected in the Yandex account settings, the form will be displayed in the nearest language available. If the form is embedded in the service page, to select the language to display the form in, set the `lang` GET parameter when invoking the form.

## Form localization restrictions {#restrictions}

* The original form must be in Russian.

* A form in a foreign language will contain the same fields as the original form in Russian. If you need a form in а foreign language with a different set of fields, [create a new form](new-form.md).

* Supported languages are listed in the [localization requests](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/) form.


## Request a form's localization {#request}

1. Open the form to be localized.

1. Click **Settings** → **Translations**.

1. To send your texts to Tanker for translation, select any language and click **Add keys to Tanker**.
1. Check that the Russian keys have been added to Tanker: click **Keys in Tanker**. Copy the link to the keyset.
1. Send the new keys for translation. Click **New request**. A request for translating keys will open in a new browser window.

1. Fill out the translation request that opens: select the languages to translate your form to and specify the link to the keyset that you copied. A ticket is created automatically in the TRANSLATE queue based on your request.

   {% note info %}

   If the request form doesn't open automatically, fill out the request at this [link](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/).

   {% endnote %}

1. Wait until the ticket for localization is completed and the keysets get translated in Tanker.

After that, the form will be displayed in the languages selected.  The data is refreshed every 30 minutes.

If you need to set up your form's integration with other services depending on the user language, you can also do that in the old {{ forms-name }} admin panel. For more information, [see {{ wiki-name }}](https://wiki.yandex-team.ru/forms/instruction/integrations/#obshhienastrojjkiintegracii).

## Edit localized forms {#repeat}

If you change your form's text or add a new one, make a new form localization request:

1. Go to **Settings** → **Translations**. Text updates will be sent to Tanker within 5 minutes.
1. Check that the Russian keys have been updated in Tanker: click **Keys in Tanker**. Copy the link to the keyset.
1. Click **New request** and fill out a new [request to translate the form](https://wiki.yandex-team.ru/doc-and-loc/l10n/zakazatperevod/localizationrequest/).
1. Wait until the ticket for localization is completed and the keysets get translated in Tanker.

After that, the form will be displayed in the languages selected.  The data is refreshed every 30 minutes.