# Recognition of documents

_Recognition of documents using presets is at the [Preview stage](../../../overview/concepts/launch-stages.md) and is not charged additionally. Its usage is charged [according to the text recognition pricing policy](../../pricing.md)._

You can extract standard fields and recognize the text of presets and documents: passports, driver licenses, vehicle registration certificates, and license plate numbers.

## Recognition models {#models}

To recognize text in your document, use the `model` parameter of the `text_detection_config` array to specify one of the following recognition models:
* `passport`: Passport, the main double page spread.
* `driver-license-front`: Driver's license, the front side.
* `driver-license-back`: Driver's license, the reverse side.
* `vehicle-registration-front`: Front side of the vehicle registration certificate.
* `vehicle-registration-back`: Back side of the vehicle registration certificate.
* `license-plates`: All the license plate numbers in the image.

### Countries whose documents can be recognized {#countries}

{% list tabs %}

- Passports

   * Russia
   * Russia (permanent residency permit)
   * Azerbaijan
   * Armenia
   * Belarus
   * Germany
   * Georgia
   * Israel
   * Italy
   * Kazakhstan
   * Kyrgyzstan
   * Latvia
   * Moldavia
   * Tajikistan
   * Tunisia
   * Turkmenistan
   * Turkey
   * Uzbekistan
   * Ukraine
   * France

- Driver licenses, vehicle registration certificates, and license plate numbers

   * Russia
   * Azerbaijan
   * Armenia
   * Belarus
   * Germany
   * Greece
   * Georgia
   * Israel
   * Kazakhstan
   * Kyrgyzstan
   * Latvia
   * Lithuania
   * Moldavia
   * Poland
   * Tajikistan
   * Turkmenistan
   * Uzbekistan
   * Ukraine
   * Switzerland
   * Estonia

{% endlist %}

## Example {#example}

### Recognition request {#example-query}

`body.json` file:

```json
{
    "folderId": "<folder_ID>",
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

### Response to a request {#example-answer}

For the `passport`, `driver-license-front`, `driver-license-back`, `vehicle-registration-front`, and `vehicle-registration-back` models, an `entities` array is added in the response.

For the `license-plates` model, the response doesn't contain an `entities` array. This model recognizes all the license plate numbers in the image and doesn't recognize any other text. In this case, the completeness and accuracy that license plate numbers are recognized for this model are much higher than for the general OCR model. The recognition results are shown in the [standard text_detection response](../ocr/index.md#response).

{% note warning %}

The `license-plates` model doesn't support [automatic language detection](../../operations/ocr/text-detection.md#basic). To use this model, [specify the text language](../../operations/ocr/text-detection.md#multiple-languages), for example, `ru`.

{% endnote %}

Example of the `entities` array returned in the service response for the `passport` model:

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
          "name": "issued_by",
          "text": "washington state department of licensing."
         },
         {
          "name": "issue_date",
          "text": "10.05.2011"
         },
         {
          "name": "expiration_date",
          "text": "-"
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
   * `issued_by`: Authority that issued the document.
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
* `vehicle-registration-front`
   * `stsfront_car_number`: License plate number.
   * `stsfront_vin_number`: Vehicle identification number (VIN).
   * `stsfront_car_brand`: Vehicle brand.
   * `stsfront_car_model`: Vehicle model.
   * `stsfront_car_year`: Vehicle manufacture year.
   * `stsfront_car_chassis_number`: Chassis number.
   * `stsfront_car_trailer_number`: Vehicle body, compartment, or trailer number.
   * `stsfront_car_color`: Vehicle color.
   * `stsfront_sts_number`: Vehicle registration certificate (VRC) number.
* `vehicle-registration-back`
   * `stsback_car_owner`: Vehicle owner's full name or legal entity name.
   * `stsback_sts_number`: Vehicle registration certificate (VRC) number.

{% note info %}

If the [recognition confidence](./index.md#confidence) is low, some fields may be missing from recognition results.

{% endnote %}

#### What's next {#what-is-next}

* [View the list of supported languages and models](supported-languages.md)
* [View known restrictions for the current version](known-issues.md)
* [Try recognizing text in an image](../../operations/ocr/text-detection.md)