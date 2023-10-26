# Распознавание текста на изображении

Чтобы [распознать текст](../../concepts/ocr/index.md) на изображении, вы можете использовать [OCR API](../../ocr/api-ref/index.md) или [Vision API](../../vision/api-ref/index.md). OCR API — это обновленный и переработанный интерфейс, который предоставляет больше [возможностей](../../concepts/limits.md#vision-limits), в т.ч. распознавание многоколоночного текста.

## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Распознать текст на изображении с помощью OCR API {#ocr-api-recognition}

Распознавание текста на изображении реализовано в методе [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API.

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<изображение_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите содержимое файла, полученное при [переводе](../base64-encode.md) изображения в формат Base64.
    
    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"languageCodes": ["*"]`.


1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    ``` json
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

1. Чтобы получить все распознанные на изображении слова, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

## Распознать текст на изображении с помощью Vision API {#vision-api-recognition}

Распознавание текста на изображении реализовано в методе [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) Vision API.

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}


### Примеры кода {#code-examples}

В примерах ниже показан код скрипта для распознавания текста с использованием Vision API. Аутентификация реализована для аккаунта на Яндексе с помощью [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md) ([подробнее о способах аутентификации](../../api-ref/authentication.md)).

{% list tabs %}

- Go

    Создайте файл скрипта, например `text_detection.go` и скопируйте в него следующий код:

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

    // Функция возвращает IAM-токен для аккаунта на Яндексе.
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

    // Функция отправляет на сервер запрос на распознавание изображения и возвращает ответ сервера.
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

    Создайте файл скрипта, например `text_detection.py` и скопируйте в него следующий код:

    ```python
    # coding: utf-8
    from requests import post
    import json
    import argparse
    import base64

    # Функция возвращает IAM-токен для аккаунта на Яндексе.
    def get_iam_token(iam_url, oauth_token):
        response = post(iam_url, json={"yandexPassportOauthToken": oauth_token})
        json_data = json.loads(response.text)
        if json_data is not None and 'iamToken' in json_data:
            return json_data['iamToken']
        return None

    # Функция отправляет на сервер запрос на распознавание изображения и возвращает ответ сервера.
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