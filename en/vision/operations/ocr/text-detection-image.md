# Text recognition in images

You can [recognize text](../../concepts/ocr/index.md) in an image using the [OCR API](../../ocr/api-ref/index.md) or [Vision API](../../vision/api-ref/index.md). The OCR API is an updated and revised interface with enhanced [features](../../concepts/limits.md#vision-limits), including multi-column text recognition.

## Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Recognizing text in an image through the OCR API {#ocr-api-recognition}

Image text recognition is implemented in the [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API method.

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

    {% note info %}

    Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

    {% endnote %}

1. Encode the image file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<base64-encoded_image>"
    }
    ```

    In the `content` property, specify the image file contents [encoded](../base64-encode.md) as Base64.

    For the service to automatically detect the text language, specify the `"languageCodes": ["*"]` property in the configuration.


1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    The result will consist of recognized blocks of text, lines, and words with their position on the image:

    ```json
    {
      "result": {
        "text_annotation": {
          "width": "1920",
          "height": "1280",
          "blocks": [{
            "bounding_box": {
              "vertices": [{
                "x": "460",
                "y": "777"
              }, {
                "x": "460",
                "y": "906"
              }, {
                "x": "810",
                "y": "906"
              }, {
                "x": "810",
                "y": "777"
              }]
            },
            "lines": [{
              "bounding_box": {
                "vertices": [{
                  "x": "460",
                  "y": "777"
                }, {
                  "x": "460",
                  "y": "820"
                }, {
                  "x": "802",
                  "y": "820"
                }, {
                  "x": "802",
                  "y": "777"
                }]
              },
              "alternatives": [{
                "text": "PENGUINS",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "460",
                      "y": "768"
                    }, {
                      "x": "460",
                      "y": "830"
                    }, {
                      "x": "802",
                      "y": "830"
                    }, {
                      "x": "802",
                      "y": "768"
                    }]
                  },
                  "text": "PENGUINS",
                  "entity_index": "-1"
                }]
              }]
            }, {
              "bounding_box": {
                "vertices": [{
                  "x": "489",
                  "y": "861"
                }, {
                  "x": "489",
                  "y": "906"
                }, {
                  "x": "810",
                  "y": "906"
                }, {
                  "x": "810",
                  "y": "861"
                }]
              },
              "alternatives": [{
                "text": "CROSSING",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "489",
                      "y": "852"
                    }, {
                      "x": "489",
                      "y": "916"
                    }, {
                      "x": "810",
                      "y": "916"
                    }, {
                      "x": "810",
                      "y": "852"
                    }]
                  },
                  "text": "CROSSING",
                  "entity_index": "-1"
                }]
              }]
            }],
            "languages": [{
              "language_code": "en"
            }]
          }, {
            "bounding_box": {
              "vertices": [{
                "x": "547",
                "y": "989"
              }, {
                "x": "547",
                "y": "1046"
              }, {
                "x": "748",
                "y": "1046"
              }, {
                "x": "748",
                "y": "989"
              }]
            },
            "lines": [{
              "bounding_box": {
                "vertices": [{
                  "x": "547",
                  "y": "989"
                }, {
                  "x": "547",
                  "y": "1046"
                }, {
                  "x": "748",
                  "y": "1046"
                }, {
                  "x": "748",
                  "y": "989"
                }]
              },
              "alternatives": [{
                "text": "SLOW",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "547",
                      "y": "983"
                    }, {
                      "x": "547",
                      "y": "1054"
                    }, {
                      "x": "748",
                      "y": "1054"
                    }, {
                      "x": "748",
                      "y": "983"
                    }]
                  },
                  "text": "SLOW",
                  "entity_index": "-1"
                }]
              }]
            }],
            "languages": [{
              "language_code": "en"
            }]
          }],
          "entities": []
        },
        "page": "0"
      }
    }
    ```

1. To get all the recognized words in an image, find all the values with the `text` property.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

## Recognizing text in an image through the Vision API {#vision-api-recognition}

Image text recognition is implemented in the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) Vision API method.

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

    {% endnote %}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}


### Code samples {#code-examples}

The examples below show the script code for text recognition using the Vision API. Authentication is implemented for an account on Yandex using [OAuth token](../../../iam/concepts/authorization/oauth-token.md) ([learn more about authentication methods](../../api-ref/authentication.md)).

{% list tabs group=programming_language %}

- Go {#go}

   Create a script file, e.g., `text_detection.go` and copy the following code into it:

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

    // The function sends an image recognition request to the server and returns a response from the  server
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

- Python {#python}

    Create a script file, e.g., `text_detection.py` and copy the following code into it:
 
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

    # The function sends an image recognition request to the server and returns a response from the  server.
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