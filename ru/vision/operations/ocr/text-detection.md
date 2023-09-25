# Распознавание текста

Чтобы распознать текст с изображения или из PDF-файла, воспользуйтесь возможностью [Распознавание текста](../../concepts/ocr/index.md).

Для этого в методе [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `TEXT_DETECTION`, а в свойстве `textDetectionConfig` задайте настройки распознавания.

## Примеры {#examples}

### Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Распознать текст с изображения {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

### Распознайте текст из PDF-файла {#pdf}

1. В PDF-файле должно быть не больше 8 страниц. Если страниц больше, разбейте его на файлы по 8 страниц.
1. Кодируйте PDF-файл в формат Base64.

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command-pdf.md) %}

1. Создайте файл с телом запроса, например `body.json`.

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

    Где:
    * `folderId` – [идентификатор любого каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
    * `analyze_specs: content` – PDF-файл, кодированный в Base64.
    * `analyze_specs: mime_type` – [MIME-тип](https://en.wikipedia.org/wiki/Media_type) `application/pdf`.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Распознайте строку текста {#string}

Если вы не хотите передавать изображение целиком, вы можете вырезать строку и отправить на распознавание только ее. В конфигурации укажите модель `line`, которая лучше подходит для распознавания отдельных строк.

{% note alert %}

{% include [include](../../../_includes/vision/text-detection-line-note.md) %}

{% endnote %}

Чтобы распознать строку текста:

1. Кодируйте файл изображения в формат Base64.

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`:

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

    Где:
    * `folderId` – [идентификатор любого каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
    * `analyze_specs: content` – изображение, кодированное в Base64.
    * `analyze_specs: features: text_detection_config: model` – модель `line`.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Указать язык текста в запросе {#multiple-languages}

Если вы знаете язык текста, укажите его в запросе, чтобы повысить качество распознавания:

1. Кодируйте файл в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            ...
    ```

    Где `analyze_specs: content` – изображение, кодированное в Base64.

1. [Выберите языки](../../concepts/ocr/supported-languages.md) для распознавания текста и соответствующие им модели распознавания:

   * Если все языки входят в одну модель, то укажите их в конфигурации запроса. Можно указать до 8 языков. Например, французский и немецкий:

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
   * Если языки из разных моделей, задайте несколько конфигураций в свойстве `features`.
       Например, распознайте изображение на иврите, арабском и английском языках:

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

### Готовая функция для отправки запросов в bash {#oneliner}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Скопируйте в терминал функцию:

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

1. Теперь вы можете вызывать эту функцию, передав путь к файлу в аргументах:

    ```bash
    vision_text_detection path/to/image.jpg
    ```

    Вторым аргументом вы можете передать MIME-тип. Например, чтобы распознать PDF-файл, вызовите:

    ```bash
    vision_text_detection path/to/document.pdf application/pdf
    ```

### Примеры кода {#code-examples}

В примерах ниже показан код скрипта для распознавания текста. Аутентификация реализована для аккаунта на Яндексе с помощью [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md) ([подробнее о способах аутентификации](../../api-ref/authentication.md)).

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