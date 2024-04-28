# Обработчик запросов функции на Go

_Обработчик запросов_ — это метод, который используется для обработки каждого вызова функции на Go. При создании версии функции необходимо указать точку входа, которая состоит из имени файла и имени обработчика запросов (например, `index.Handler`).

* Для корректной работы обработчик должен находиться в пакете `main`.
* Чтобы обработчик был доступен вне модуля (файла), экспортируйте его, вводя первую букву его имени с заглавной буквы.

{% note info %}

В каждый момент времени один экземпляр функции обрабатывает только один запрос. Это позволяет использовать глобальные переменные без необходимости обеспечивать контроль целостности данных.

{% endnote %}

## Сигнатура Cloud Functions {#functions}

При вызове обработчика среда выполнения может передавать следующие аргументы:
1. Контекст вызова (параметр `context`). 

    Контекст содержит необходимую информацию о версии функции. Структура этого объекта описана в разделе [{#T}](context.md).
    В случае присутствия второго аргумента (тела HTTP-запроса), контекст вызова должен быть первым в списке аргументов.
1. Тело HTTP-запроса (параметр `request`). 

    Тело может быть представлено массивом байтов, строкой, пользовательским типом или указателем на него. В первых двух случаях представление отражает HTTP-запрос в чистом виде — либо в качестве массива байт, либо в виде строки.
    Если же аргумент обработчика имеет пользовательский тип, а тело запроса — JSON-документ, то оно будет преобразовано в объект этого типа с помощью метода `json.Unmarshal`.

Ни один из вышеперечисленных аргументов **не является** обязательным.
Если аргумент, отвечающий за тело запроса, отсутствует, то любые входные данные функции **игнорируются**.

Среда выполнения возвращает результат исполнения функции в виде набора данных:
1. Тело ответа (значение `response`).

    Тело может быть представлено массивом байтов, строкой, пользовательским типом или указателем на него, а также [пустым интерфейсом](https://go.dev/tour/methods/14). В первых двух случаях для получения корректного ответа следует вызывать функцию с указанием параметра строки запроса `?integration=raw`. Подробнее про вызов функции можно почитать в [соответствующем разделе](../../concepts/function-invoke.md#http). В других случаях возвращаемое значение будет преобразовано в объект соответствующего типа с помощью метода `json.Unmarshal` и возвращено в виде JSON-документа.

1. Ошибка (значение `error`).

    Для оповещения об ошибочном результате исполнения функции рекомендуется возвращать соответствующую ошибку. В случае, когда `error != nil`, тело ответа, при его наличии, игнорируется. **Внимание**: ошибка является **обязательным** возвращаемым значением. Другими словами, в случае отсутствия тела ответа, из функции должна возвращаться ошибка в качестве единственного возвращаемого значения, иначе ошибка должна быть последней в списке возвращаемых значений.
    
## Стандартная сигнатура Go {#go}

{{ sf-name }} поддерживает в качестве обработчика:
* функции с сигнатурой `func (http.ResponseWriter, *http.Request)`;
* объекты, которые удовлетворяют интерфейсу [http.Handler](https://pkg.go.dev/net/http#Handler).

Функция может брать значения, которые передаются в запросе, из структуры [http.Request](https://pkg.go.dev/net/http#Request), и передавать ответ на запрос через интерфейс [http.ResponseWriter](https://pkg.go.dev/net/http#ResponseWriter).

{{ sf-name }} не поддерживает пути в запросах. Для корректной работы [http.ServeMux](https://pkg.go.dev/net/http#ServeMux) функцию нужно [вызывать через API-шлюз](../../../api-gateway/quickstart/index.md#function).

Пример функции:

```golang
package main

import (
  "fmt"
  "io"
  "net/http"
)

func Handler(rw http.ResponseWriter, req *http.Request) {
  rw.Header().Set("X-Custom-Header", "Test")
  rw.WriteHeader(200)
  name := req.URL.Query().Get("name")
  io.WriteString(rw, fmt.Sprintf("Hello, %s!", name))
}
```

## Примеры {#examples}

### Вывод структуры HTTP-запроса {#http-req}

Следующая функция получает на вход запрос с двумя полями (строкой и числом), выводит структуру запроса и контекста вызова в журнал выполнения и возвращает строчную запись JSON-документа, содержащего информацию о контексте и запросе.

{% note warning %}

Функцию необходимо вызывать с помощью [CLI {{ yandex-cloud }}](../../concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `?integration=raw`.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// Входной JSON-документ будет автоматически преобразован в объект данного типа
type Request struct {
  Message string `json:"message"`
  Number  int    `json:"number"`
}

type ResponseBody struct {
  Context context.Context `json:"context"`
  Request interface{}     `json:"request"`
}

func Handler(ctx context.Context, request *Request) ([]byte, error) {
  // В логах функции будут напечатаны значения контекста вызова и тела запроса
  fmt.Println("context", ctx)
  fmt.Println("request", request)
  
  // Объект, содержащий тело ответа, преобразуется в массив байтов
  body, err := json.Marshal(&ResponseBody {
    Context: ctx,
    Request: request,
  })

  if err != nil {
    return nil, err
  }

  // Тело ответа необходимо вернуть в виде массива байтов
  return body, nil
}
```

Пример входных данных:

```json
{
  "message": "Hello, world",
  "number": 24
}
```

В журнале будет напечатано:
```
context {context.Background map[lambdaRuntimeFunctionName:b09ks558ute7******** lambdaRuntimeFunctionVersion:b09ebrsp6jba******** lambdaRuntimeLogGroupName:eolitpnj15jr******** lambdaRuntimeLogStreamName:b09ebrsp6jba******** lambdaRuntimeMemoryLimit:512 lambdaRuntimeRequestID:58fc90cc-97b9-4c2b-95db-9dd0********]}
request &{Hello, world 24}
```

Возвращаемый JSON-документ:

```json
{ 
  "context": {
    "Context": 0
  },
  "request": {
    "message": "Hello, world",
    "number": 24
  }
}
```

### Вывод подготовленного ответа или ошибки

Функция генерирует случайное число от 0 до 100 и возвращает ошибку, если это число больше или равно 50, иначе возвращает строку "Lucky one!":

```golang
package main

import (
  "fmt"
  "math/rand"
)

// Тело ответа представляет собой строку, следовательно, для корректного отображения
// ответа следует запускать функцию с параметром `?integration=raw`
func Handler() (string, error) {
  if (rand.Int31n(100) >= 50) {
    return "", fmt.Errorf("not so lucky")
  }
  
  return "Lucky one!", nil
}
```

Возвращаемый JSON-документ:

В случае, когда случайное число больше или равно 50:

```json
{
  "errorMessage":"not so lucky",
  "errorType":"UserCodeError"
}
```

В противном случае:

```
"Lucky one!"
```

### Разбор HTTP-запроса

Функция вызывается с помощью HTTP-запроса с именем пользователя, записывает в журнал метод и тело запроса и возвращает приветствие.

{% note warning %}

Не используйте для вызова функции параметр `?integration=raw`. При его использовании функция не получает данных о методах, заголовках и параметрах исходного запроса.

{% endnote %}

```golang
package main

import (
  "context"
  "encoding/json"
  "fmt"
)

// Структура тела запроса (см. абзац после этого примера).
// Остальные поля нигде не используются в данном примере, поэтому можно обойтись без них
type RequestBody struct {
  HttpMethod string `json:"httpMethod"`
  Body       []byte `json:"body"`
}

// Преобразуем поле body объекта RequestBody
type Request struct {
  Name string `json:"name"`
}

type Response struct {
  StatusCode int         `json:"statusCode"`
  Body       interface{} `json:"body"`
}

func Greet(ctx context.Context, request []byte) (*Response, error) {
  requestBody := &RequestBody{}
  // Массив байтов, содержащий тело запроса, преобразуется в соответствующий объект
  err := json.Unmarshal(request, &requestBody)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing request: %v", err)
  }

  // В журнале будет напечатано название HTTP-метода, с помощью которого осуществлен запрос, а также тело запроса
  fmt.Println(requestBody.HttpMethod, string(requestBody.Body))

  req := &Request{}
  // Поле body запроса преобразуется в объект типа Request для получения переданного имени
  err = json.Unmarshal(requestBody.Body, &req)
  if err != nil {
    return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
  }

  name := req.Name
  // Тело ответа необходимо вернуть в виде структуры, которая автоматически преобразуется в JSON-документ,
  // который отобразится на экране
  return &Response{
    StatusCode: 200,
    Body:       fmt.Sprintf("Hello, %s", name),
  }, nil
}
```

Подробнее о структуре тела запроса (`type RequestBody struct`) см. в разделе [{#T}](../../concepts/function-invoke.md#request).

Пример входных данных (метод POST):

```json
{
  "name": "Anonymous"
}
```

В журнале будет напечатано:
```
POST { "name": "Anonymous" }
```

Возвращаемый ответ:
```
Hello, Anonymous
```



### Разбор HTTP-запроса за {{ api-gw-name }}

Функция вызывается сервисом {{ api-gw-full-name }} с сервисным аккаунтом, записывает в журнал метод и тело запроса и возвращает приветствие.

Функция декодирует тело входящего запроса при помощи `json.Unmarshal()`.

```golang
package main

import (
	"context"
	"encoding/json"
	"fmt"
)

// Структура запроса API Gateway v1
type APIGatewayRequest struct {
	OperationID string `json:"operationId"`
	Resource    string `json:"resource"`

	HTTPMethod string `json:"httpMethod"`

	Path           string            `json:"path"`
	PathParameters map[string]string `json:"pathParameters"`

	Headers           map[string]string   `json:"headers"`
	MultiValueHeaders map[string][]string `json:"multiValueHeaders"`

	QueryStringParameters           map[string]string   `json:"queryStringParameters"`
	MultiValueQueryStringParameters map[string][]string `json:"multiValueQueryStringParameters"`

	Parameters           map[string]string   `json:"parameters"`
	MultiValueParameters map[string][]string `json:"multiValueParameters"`

	Body            string `json:"body"`
	IsBase64Encoded bool   `json:"isBase64Encoded,omitempty"`

	RequestContext interface{} `json:"requestContext"`
}

// Структура ответа API Gateway v1
type APIGatewayResponse struct {
	StatusCode        int                 `json:"statusCode"`
	Headers           map[string]string   `json:"headers"`
	MultiValueHeaders map[string][]string `json:"multiValueHeaders"`
	Body              string              `json:"body"`
	IsBase64Encoded   bool                `json:"isBase64Encoded,omitempty"`
}

type Request struct {
	Name string `json:"name"`
}

func Greet(ctx context.Context, event *APIGatewayRequest) (*APIGatewayResponse, error) {
	req := &Request{}

	// Поле event.Body запроса преобразуется в объект типа Request для получения переданного имени
	if err := json.Unmarshal([]byte(event.Body), &req); err != nil {
		return nil, fmt.Errorf("an error has occurred when parsing body: %v", err)
	}

	// В журнале будет напечатано название HTTP-метода, с помощью которого осуществлен запрос, а также путь
	fmt.Println(event.HTTPMethod, event.Path)

	// Тело ответа.
	return &APIGatewayResponse{
		StatusCode: 200,
		Body:       fmt.Sprintf("Hello, %s", req.Name),
	}, nil
}
```

{% note warning %}

Обращаться к функции нужно через API-шлюз.

{% endnote %}

Пример входных данных (метод POST):

```json
{
  "name": "Anonymous"
}
```

В журнале будет напечатано:
```
POST { "name": "Anonymous" }
```

Возвращаемый ответ:
```
Hello, Anonymous
```

