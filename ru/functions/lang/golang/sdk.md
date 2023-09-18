# Использование SDK для функции на Go

Среда выполнения не содержит предустановленной библиотеки для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для её использования требуется добавить [зависимость](dependencies.md) в приложение на Go. Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/go-sdk).

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции.

### Пример:

Следующая функция получает на вход запрос с двумя полями: ID папки (`FolderId`) и тег (`Tag`), авторизуется в SDK, получает список всех виртуальных машин {{ compute-name }} в заданной папке, фильтрует их по заданному тегу, и запускает остановленные машины. В качестве результата возвращает сообщение-отчёт с количеством запущенных машин.

{% note warning %}

Функцию необходимо вызывать с помощью [CLI {{ yandex-cloud }}](../../concepts/function-invoke.md) или с помощью HTTP-запроса с параметром `integration=raw`.

{% endnote %}

```golang
package main

import (
  "context"
  "fmt"
  "github.com/yandex-cloud/go-genproto/yandex/cloud/compute/v1"
  "github.com/yandex-cloud/go-genproto/yandex/cloud/operation"
  "github.com/yandex-cloud/go-sdk"
)

func startComputeInstance(ctx context.Context, sdk *ycsdk.SDK, id string) (*operation.Operation, error) {
  // Операция запуска Compute Instance с указанным ID
  return sdk.Compute().Instance().Start(ctx, &compute.StartInstanceRequest{
    InstanceId: id,
  })
}

type Request struct {
  FolderId string `json:"folderId"`
  Tag      string `json:"tag"`
}

type Response struct {
  StatusCode int         `json:"statusCode"`
  Body       interface{} `json:"body"`
}

func StartComputeInstances(ctx context.Context, request *Request) (*Response, error) {
  // Авторизация в SDK при помощи сервисного аккаунта
  sdk, err := ycsdk.Build(ctx, ycsdk.Config{
    // Вызов InstanceServiceAccount автоматически запрашивает IAM-токен и формирует
    // при помощи него данные для авторизации в SDK
    Credentials: ycsdk.InstanceServiceAccount(),
  })
  if err != nil {
    return nil, err
  }
  // Получение списка Compute Instance по заданному запросом FolderId
  listInstancesResponse, err := sdk.Compute().Instance().List(ctx, &compute.ListInstancesRequest{
    FolderId: request.FolderId,
  })
  if err != nil {
    return nil, err
  }
  instances := listInstancesResponse.GetInstances()
  count := 0
  // Фильтрация списка Compute Instance, фильтр: выключена, в тегах содержится тег, заданный запросом
  for _, i := range instances {
    labels := i.Labels
    if _, ok := labels[request.Tag]; ok && i.Status != compute.Instance_RUNNING {
      // Запуск удовлетворяющих фильтру Compute Instance
      _, err := startComputeInstance(ctx, sdk, i.GetId())
      if err != nil {
        return nil, err
      }
      count++
    }
  }
  return &Response{
    StatusCode: 200,
    Body:       fmt.Sprintf("Started %d instances", count),
  }, nil
}
```

Файл `go.mod`:

```golang
module example

go 1.14
```