# Recognition of documents

_Recognition of documents using presets is at the [Preview stage](../../../overview/concepts/launch-stages.md) and is not charged additionally. Its usage is charged [according to the text recognition pricing policy](../../pricing.md)._

You can extract standard fields and recognize the text of presets and documents: passports, driver licenses, and license plate numbers.

To recognize text in your document, use the `model` parameter of the `text_detection_config` array to specify one of the following recognition models:
* `passport`: Passport, the main double page spread.
* `driver-license-front`: Driver's license, the front side.
* `driver-license-back`: Driver's license, the reverse side.
* `license-plates`: All the license plate numbers in the image.

Example of a request to recognize the main double page spread of a passport in `body.json`:

```json
{
    "folderId": "<folder_id>",
    "analyze_specs": [{
        "content": "<recognition_object>",
        "features": [{
            "type": "TEXT_DETECTION",
            "text_detection_config": {
                "language_codes": ["<text_language>"],
                "model": "<recognition_model>"
            }
        }]
    }]
}
```

Where:

* `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
* `content`: Image [encoded in Base64](../../operations/base64-encode.md).
* `language_codes`: [Text language](supported-languages.md). To detect the text language automatically, specify `*`.
* `model`: Recognition model.

For the `passport`, `driver-license-front`, and `driver-license-back` models, an `entities` array is added in the response.

For the `license-plates` model, the response doesn't contain an `entities` array. This model recognizes all the license plate numbers in the image and doesn't recognize any other text. In this case, the completeness and accuracy that license plate numbers are recognized for this model are much higher than for the general OCR model. The recognition results are shown in the [standard text_detection response](../ocr/index.md#response).

{% note warning %}

The `license-plates` model doesn't support [automatic language detection](../../operations/ocr/text-detection.md#basic). To use this model, [specify the text language](../../operations/ocr/text-detection.md#multiple-languages), for example, `ru`.

{% endnote %}

Example of the `entities` array returned in the service response:

```json
{         "entities": [
         {
          "name": "name",
          "text": "sonya"
         },
         {
          "name": "middle_name",
          "text": "anna"
         },
         {
          "name": "surname",
          "text": "ray"
         },
         {
          "name": "gender",
          "text": "female"
         },
         {
          "name": "citizenship",
          "text": "usa"
         },
         {
          "name": "birth_date",
          "text": "05.02.1965"
         },
         {
          "name": "birth_place",
          "text": "washington. d.c., u.s.a."
         },
         {
          "name": "number",
          "text": "0702084625"
         },
         {
          "name": "issue_date",
          "text": "10.05.2020"
         },
         {
          "name": "expiration_date",
          "text": "10.05.2030"
         }
        ]}
```
List of fields in the `entities` array:

* `passport`
   * `name`: First name.
   * `middle_name`: Middle name.
   * `surname`: Last name.
   * `gender`: Gender.
   * `citizenship`: Citizenship.
   * `birth_date`: Date of birth.
   * `birth_place`: Place of birth.
   * `number`: Passport number.
   * `issue_date`: Date of issue.
   * `subdivision`: Department code.
   * `expiration_date`: Date of expiration.
* `driver-license-front`
   * `name`: First name.
   * `middle_name`: Middle name.
   * `surname`: Last name.
   * `number`: Driver's license number.
   * `birth_date`: Date of birth.
   * `issue_date`: Date of issue.
   * `expiration_date`: Date of expiration.
* `driver-license-back`
   * `experience_from`: Driving experience (year since).
   * `number`: Driver's license number.
   * `issue_date`: Date of issue.
   * `expiration_date`: Date of expiration.
   * `prev_number`: Driver's previous license number.

#### What's next {#what-is-next}

* [View the list of supported languages and models](supported-languages.md)
* [View known restrictions for the current version](known-issues.md)
* [Try recognizing text in an image](../../operations/ocr/text-detection.md)