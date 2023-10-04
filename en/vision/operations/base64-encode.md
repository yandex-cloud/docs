# Encoding a file as Base64

To pass an image file to the {{ vision-short-name }} API, convert the file content into text in Base64 format:

{% include [base64-encode-command](../../_includes/vision/base64-encode-command.md) %}

Pass the content of the resulting `output.txt` file in the request body:

```json
{
    "folderId": "b1gvmob95yys********",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        ...
    }]
}

```

Where:
* `folderId`: [ID of any folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
* `analyze_specs: content`: Content of the created `output.txt` file.
