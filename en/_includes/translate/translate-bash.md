{% include [bash-windows-note-single](bash-windows-note-single.md) %}

This example shows how to translate two strings containing *Hello* and *World* into Russian. The text source language is recognized automatically.

1. Create a file with the request body, e.g., `body.json`:

   ```json
   {
       "folderId": "<Folder_ID>",
       "texts": ["Hello", "World"],
       "targetLanguageCode": "ru"
   }
   ```

   Where:

   * `folderId`: Folder ID received [before starting](#before-begin).
   * `texts`: Text to translate as a list of strings.
   * `targetLanguageCode`: Target [language](../../translate/concepts/supported-languages.md). You can get the language code with a [list of supported languages](../../translate/operations/list.md).

1. Submit the file for translation by running the command:

   {% include [translate-file](translate-file.md) %}

   Where `IAM_TOKEN` is the IAM token received [before starting](#before-begin).

   The service will return the translated strings:
   ```json
   {
       "translations": [
           {
           "text": "Hello",
           "detectedLanguageCode": "en"
           },
           {
           "text": "World",
           "detectedLanguageCode": "en"
           }
       ]
   }
   ```
