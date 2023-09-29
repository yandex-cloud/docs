# Text recognition

To recognize text in an image or from a PDF file, use the [Text recognition](../../concepts/ocr/index.md).

To do this in the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) method, set the `type` property to `TEXT_DETECTION`, and specify the recognition settings in the `textDetectionConfig` property.

## Examples {#examples}

### Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Recognize text from an image {#basic}

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

    {% endnote %}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

### Recognize text from a PDF file {#pdf}

1. The PDF file must contain up to 8 pages. If there are more pages, split it into files with 8 pages or less.
1. Encode the PDF file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Create a file with the request body (for example, `body.json`).

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "mime_type": "application/pdf",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"]
                }
            }]
        }]
    }
    ```

    Where:
    * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
    * `analyze_specs: content`: Base64-encoded PDF file.
    * `analyze_specs: mime_type`: [MIME-type](https://en.wikipedia.org/wiki/Media_type) `application/pdf`.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Recognize a line of text {#string}

If you don't want to send an entire image, you can cut out a single line and send it for recognition. In the configuration, specify the model `line` which is better for recognizing a line of text.

{% note alert %}

{% include [include](../../../_includes/vision/text-detection-line-note.md) %}

{% endnote %}

To recognize a line of text:

1. Encode the file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Create a file with the request body, e.g., `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"],
                    "model": "line"
                }
            }]
        }]
    }
    ```

    Where:
    * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
    * `analyze_specs: content`: Image encoded in Base64.
    * `analyze_specs: features: text_detection_config: model`: `line` model.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Specify the language of the text in the request {#multiple-languages}

If you know the language of the text, specify it in the request to improve the quality of recognition:

1. Encode the file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Create a file with the request body, e.g., `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            ...
    ```

    Where `analyze_specs: content`: Image encoded in Base64.

1. [Select the languages](../../concepts/ocr/supported-languages.md) for text recognition and the appropriate recognition models:

   * If all languages are in the same model, specify them in the request configuration. You can specify up to 8 languages: For example, French and German:

       **body.json:**
       ```json
       {
           "folderId": "b1gvmob95yys********",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["fr", "de"]
                   }
               }]
           }]
       }
       ```
   * If the languages are from different models, set multiple configurations in the `features` property.
      For example, you can recognize images in Hebrew, Arabic, and English:

       **body.json:**
       ```json
       {
           "folderId": "b1gvmob95yys********",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["he","en"]
                   }
               },{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["ar","en"]
                   }
               }]
           }]
       }
       ```
1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Ready-to-use function for sending requests in bash {#oneliner}

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Copy the function to the terminal:

    ```bash
    vision_text_detection() {
        if [[ $2 ]]; then MIME_TYPE=$2 ; else MIME_TYPE=image; fi
        curl -H "Authorization: Bearer `yc iam create-token`" \
        "https://vision.{{ api-host }}/vision/v1/batchAnalyze" \
        -d @<(cat << EOF
    {
        "folderId": "`yc config get folder-id`",
        "analyze_specs": [{
            "content": "`base64 -i $1`",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"]
                }
            }],
            "mime_type": "$MIME_TYPE"
        }]
    }
    EOF
    )
    }
    ```

    {% include [oneline-function-hints](../../../_includes/vision/oneline-function-hints.md) %}

1. Now you can call this function by passing the file path in the arguments:

    ```bash
    vision_text_detection path/to/image.jpg
    ```

    With the second argument, you can pass the MIME type. For example, to recognize a PDF file, call:

    ```bash
    vision_text_detection path/to/document.pdf application/pdf
    ```

### Code samples {#code-examples}

The examples below show the script code for text recognition. Authentication is implemented for an account on Yandex using [OAuth token](../../../iam/concepts/authorization/oauth-token.md) ([learn more about authentication methods](../../api-ref/authentication.md)).

{% list tabs %}

- Go

   Create a script file, for example `text_detection.go` and copy the following code into it:

   ```go
   package main

   import (
       "bytes"
       "encoding/base64"
       "encoding/json"
       "errors"
       "flag"
       "fmt"
       "io/ioutil"
       "log"
       "net/http"
   )

   // The function returns the IAM token for the Yandex account.
   func GetIamToken(iamURL, oauthToken string) (string, error) {
       body, err := json.Marshal(&IamTokenRequest{YandexPassportOauthToken: oauthToken})
       if err != nil {
           return "", err
       }

       resp, err := http.Post(iamURL, "application/json", bytes.NewReader(body))
       if err != nil {
           return "", errors.New("Failed to obtain IAM token by oAuth token: " + err.Error())
       }

       if resp.StatusCode != http.StatusOK {
           return "", fmt.Errorf("Auth service returned status %d", resp.StatusCode)
       }

       defer func() {
           err := resp.Body.Close()
           if err != nil {
               log.Fatal(err)
           }
       }()

       respBody, err := ioutil.ReadAll(resp.Body)
       if err != nil {
           return "", err
       }

       iamTokenResponse := &IamTokenResponse{}
       err = json.Unmarshal(respBody, iamTokenResponse)
       if err != nil {
           return "", err
       }

       return iamTokenResponse.IamToken, nil
   }

   type IamTokenRequest struct {
       YandexPassportOauthToken string `json:"yandexPassportOauthToken"`
   }

   type IamTokenResponse struct {
       IamToken string
   }

   // The function sends an image recognition request to the server and returns a response from the server
   func RequestAnalyze(visionURL, iamToken, folderID, imageBase64 string) (string, error) {
       request := BatchAnalyzeRequest{
           FolderID: folderID,
           AnalyzeSpecs: []AnalyzeSpec{
               {
                   Content: imageBase64,
                   Features: []Feature{
                       {
                           Type: "TEXT_DETECTION",
                           TextDetectionConfig: TextDetectionConfig{
                               LanguageCodes: []string{
                                   "en",
                                   "ru",
                               },
                           },
                       },
                   },
               },
           },
       }

       body, err := json.Marshal(&request)
       if err != nil {
           return "", err
       }

       req, err := http.NewRequest("POST", visionURL, bytes.NewReader(body))
       if err != nil {
           return "", errors.New("Failed to prepare request: " + err.Error())
       }
       req.Header.Set("Content-Type", "application/json")
       req.Header.Set("Authorization", "Bearer "+iamToken)

       resp, err := http.DefaultClient.Do(req)
       if err != nil {
           return "", errors.New("Failed to process request: " + err.Error())
       }

       if resp.StatusCode != http.StatusOK {
           return "", fmt.Errorf("Service returned status %d", resp.StatusCode)
       }

       defer func() {
           err := resp.Body.Close()
           if err != nil {
               log.Panic(err)
           }
       }()

       respBody, err := ioutil.ReadAll(resp.Body)
       if err != nil {
           return "", err
       }

       return string(respBody), nil
   }

   type BatchAnalyzeRequest struct {
       FolderID     string        `json:"folderId"`
       AnalyzeSpecs []AnalyzeSpec `json:"analyzeSpecs"`
   }

   type AnalyzeSpec struct {
       Content  string    `json:"content"`
       Features []Feature `json:"features"`
   }

   type Feature struct {
       Type                string `json:"type"`
       TextDetectionConfig `json:"textDetectionConfig"`
   }

   type TextDetectionConfig struct {
       LanguageCodes []string `json:"languageCodes"`
   }

   func main() {
       iamURL := "https://iam.{{ api-host }}/iam/v1/tokens"
       visionURL := "https://vision.{{ api-host }}/vision/v1/batchAnalyze"

       oauthToken := flag.String("oauth-token", "", "oAuth token to obtain IAM token")
       folderID := flag.String("folder-id", "", "Folder ID")
       imagePath := flag.String("image-path", "", "Path to image to recognize")
       flag.Parse()

       iamToken, err := GetIamToken(iamURL, *oauthToken)
       if err != nil {
           log.Panic(err)
       }

       imageData, err := ioutil.ReadFile(*imagePath)
       if err != nil {
           log.Panic(err)
       }
       imageBase64 := base64.StdEncoding.EncodeToString(imageData)

       responseText, err := RequestAnalyze(visionURL, iamToken, *folderID, imageBase64)
       if err != nil {
           log.Panic(err)
       }
       fmt.Print(responseText)
   }
   ```

   {% include [text-detection-run-example](../../../_includes/vision/text-detection-run-example.md) %}

   ```bash
   export TOKEN=AgAAAAAMTH...
   export FOLDER_ID=b1gvmob95yysaplct532
   go run text_detection.go -folder-id $FOLDER_ID -oauth-token $TOKEN -image-path input.jpg
   ```

- Python

   Create a script file, for example `text_detection.py` and copy the following code into it:

   ```python
   # coding: utf-8
   from requests import post
   import json
   import argparse
   import base64

   # The function returns the IAM token for the Yandex account.
   def get_iam_token(iam_url, oauth_token):
       response = post(iam_url, json={"yandexPassportOauthToken": oauth_token})
       json_data = json.loads(response.text)
       if json_data is not None and 'iamToken' in json_data:
           return json_data['iamToken']
       return None

   # The function sends an image recognition request to the server and returns a response from the server.
   def request_analyze(vision_url, iam_token, folder_id, image_data):
       response = post(vision_url, headers={'Authorization': 'Bearer '+iam_token}, json={
           'folderId': folder_id,
           'analyzeSpecs': [
               {
                   'content': image_data,
                   'features': [
                       {
                           'type': 'TEXT_DETECTION',
                           'textDetectionConfig': {'languageCodes': ['en', 'ru']}
                       }
                   ],
               }
           ]})
       return response.text


   def main():
       parser = argparse.ArgumentParser()

       parser.add_argument('--folder-id', required=True)
       parser.add_argument('--oauth-token', required=True)
       parser.add_argument('--image-path', required=True)
       args = parser.parse_args()

       iam_url = 'https://iam.{{ api-host }}/iam/v1/tokens'
       vision_url = 'https://vision.{{ api-host }}/vision/v1/batchAnalyze'

       iam_token = get_iam_token(iam_url, args.oauth_token)
       with open(args.image_path, "rb") as f:
           image_data = base64.b64encode(f.read()).decode('utf-8')
       response_text = request_analyze(vision_url, iam_token, args.folder_id, image_data)
       print(response_text)


   if __name__ == '__main__':
       main()
   ```

   {% include [text-detection-run-example](../../../_includes/vision/text-detection-run-example.md) %}

   ```bash
   export TOKEN=AgAAAAAMTH...
   export FOLDER_ID=b1gvmob95yysaplct532
   python text_detection.py --folder-id=$FOLDER_ID --oauth-token=$TOKEN --image-path=input.jpg
   ```

{% endlist %}