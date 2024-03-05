# Document recognition

You can extract standard fields and recognize the text of templates and documents, such as passports, driver licenses, vehicle registration certificates, and license plate numbers.

## Recognition models {#models}

Specify the model you need in the `model` field in your request.

{% include [models](../../../_includes/vision/models-templates.md) %}

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

## List of returned fields {#entities-list}

Depending on the model, the list of fields in the response may vary:

`passport` model:
* `name`: First name.
* `middle_name`: Middle name.
* `surname`: Last name.
* `gender`: Gender.
* `citizenship`: Citizenship.
* `birth_date`: Date of birth.
* `birth_place`: Place of birth.
* `number`: Passport number.
* `issued_by`: Issued by.
* `issue_date`: Date of issue.
* `subdivision`: Department code.
* `expiration_date`: Expiration date.


`driver-license-front` model:
* `name`: First name.
* `middle_name`: Middle name.
* `surname`: Last name.
* `number`: Driver license number.
* `birth_date`: Date of birth.
* `issue_date`: Date of issue.
* `expiration_date`: Date of expiration.

`driver-license-back` model:
* `experience_from`: Driving experience since (year).
* `number`: Driver license number.
* `issue_date`: Date of issue.
* `expiration_date`: Date of expiration.
* `prev_number`: Driver's previous license number.

`vehicle-registration-front` model:
* `stsfront_car_number`: License plate number.
* `stsfront_vin_number`: Vehicle identification number (VIN).
* `stsfront_car_brand`: Vehicle brand.
* `stsfront_car_model`: Vehicle model.
* `stsfront_car_year`: Vehicle manufacture year.
* `stsfront_car_chassis_number`: Chassis number.
* `stsfront_car_trailer_number`: Vehicle body, compartment, or trailer number.
* `stsfront_car_color`: Vehicle color.
* `stsfront_sts_number`: Vehicle registration certificate (VRC) number.

`vehicle-registration-back` model:
* `stsback_car_owner`: Owner full name or legal entity name.
* `stsback_sts_number`: Vehicle registration certificate (VRC) number.

{% note info %}

If the [recognition accuracy](./index.md#confidence) is low, some fields may be missing from recognition results.

{% endnote %}

## Example {#example}

### Recognition request {#example-query}

`body.json` file:

```json
{
  "mimeType": "<data_type>"",
  "languageCodes": ["*"],
  "model": "<recognition_model>"",
  "content": "<image_to_recognize>"
}
```

Where:

* `mimeType`: [MIME type](https://en.wikipedia.org/wiki/Media_type) for the data being provided.
* `languageCodes`: [Text language](supported-languages.md). To detect the text language automatically, specify `*`.
* `model`: [Recognition model](index.ms#models).
* `content`: [Base64-encoded](../../operations/base64-encode.md) image.

### Response to a request {#example-answer}

For the `passport`, `driver-license-front`, `driver-license-back`, `vehicle-registration-front`, and `vehicle-registration-back` models, an `entities` array is added in the response.

For the `license-plates` model, the response does not contain an `entities` array. This model recognizes all license plate numbers in the image and does not recognize any other text. In this case, the completeness and accuracy the license plate numbers are recognized for this model are much higher than for the general OCR model. The recognition results are shown in the [standard text_detection response](../ocr/index.md#response).

{% note warning %}

The `license-plates` model does not support [automatic language detection](../../operations/ocr/text-detection-image.md#ocr-api-recognition). To use this model, make sure to specify the [text language](./supported-languages.md), e.g., `en`.

{% endnote %}

Here is an example of the `entities` array returned in the service response for the `passport` model:

```json
{  "entities": [
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
    "text": "05/12/1978"
   },
   {
    "name": "birth_place",
    "text": "washington. d.c., usa"
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
    "text": "5/10/2011"
   },
   {
    "name": "expiration_date",
    "text": "-"
   }
  ]}
```

#### See also {#see-also}

* [List of supported languages and models](supported-languages.md)
* [Known issues in the current {{ vision-name }} version](known-issues.md)
* [How to recognize text in an image](../../operations/ocr/text-detection-image.md)