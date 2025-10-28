### Bash {#bash}

Перед подключением:

1. {% include [cli-install](../cli-install.md) %}
1. Установите YTsaurus CLI по [инструкции](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Подключение с пользовательской ВМ {#from-yandex-vm}

  1. Получите конфигурационный файл доступа с помощью команды YC CLI:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <имя_или_идентификатор_кластера> --private
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "http://hp.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.mdb.yandexcloud.net:32100";
         network_name = "external";
         http_proxy_role = "default";
       }
     }
     ```

     {% endcut %}

     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

- Подключение из интернета {#from-internet}

  1. Получите конфигурационный файл доступа с помощью команды YC CLI:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <имя_или_идентификатор_кластера>
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "https://<идентификатор_кластера_{{ ytsaurus-name }}>.proxy.ytsaurus.yandexcloud.net";
         enable_proxy_discovery = %false;
       }
     }
     ```
     
     {% endcut %}
     
     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

{% endlist %}

### Go {#go}

В примере используется авторизация при помощи [OAuth-токена](../../iam/concepts/authorization/oauth-token.md).

Чтобы подключиться к кластеру:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes golang git && \
    go mod init example && go get go.ytsaurus.tech/yt/go
    ```

1. Выпустите OAuth-токен.
1. Подготовьте пример файла для подключения:

    {% cut "connect.go" %}

    ```go
    package main

    import (
        "context"
        "flag"
        "fmt"
        "time"

        ycsdk "github.com/yandex-cloud/go-sdk"
        ytsdk "go.ytsaurus.tech/yt/go/yt"
        ythttpsdk "go.ytsaurus.tech/yt/go/yt/ythttp"
    )

    func main() {
        clusterID := flag.String("id", "", "YTsaurus cluster ID")
        token := flag.String("token", "", "OAuth token")
        flag.Parse()

        ctx := context.Background()

        sdk, err := ycsdk.Build(ctx, ycsdk.Config{
            Credentials: ycsdk.OAuthToken(*token),
        })
        if err != nil {
            panic(err)
        }

        iamTokenProvider, err := IamTokenProvider(ctx, sdk)
        if err != nil {
            panic(err)
        }

        timeout := 10 * time.Second
        client, err := ythttpsdk.NewClient(&ytsdk.Config{
            Proxy:                 fmt.Sprintf("https://%s.proxy.ytsaurus.yandexcloud.net", *clusterID),
            LightRequestTimeout:   &timeout,
            DisableProxyDiscovery: true,
            CredentialsProviderFn: iamTokenProvider,
        })
        if err != nil {
            panic(err)
        }

        res, err := client.WhoAmI(context.Background(), nil)
        if err != nil {
            panic(err)
        }

        fmt.Printf("Logged in as %s\n", res.Login)
    }

    func IamTokenProvider(ctx context.Context, sdk *ycsdk.SDK) (ytsdk.CredentialsProviderFn, error) {
        var now = time.Now
        tokenMiddleware := ycsdk.NewIAMTokenMiddleware(sdk, now)
        return func(ctx context.Context) (ytsdk.Credentials, error) {
            currentToken, err := tokenMiddleware.GetIAMToken(ctx, false)
            if err != nil {
                return nil, err
            }
            return &ytsdk.BearerCredentials{Token: currentToken}, nil
        }, nil
    }
    ```

    {% endcut %}

1. Выполните команду:

    ```bash
    go run connect.go -id <идентификатор_кластера_{{ ytsaurus-name }}> -token <OAuth_токен_пользователя>
    ```

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

### Python {#python}

Перед подключением:

1. {% include [cli-install](../cli-install.md) %}
1. Установите YTsaurus CLI по [инструкции](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Подключение с пользовательской ВМ {#from-yandex-vm}

  1. Пример кода:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="http://hp.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.mdb.yandexcloud.net:32100",
          config=with_iam_token_auth(
              config={"proxy": {"network_name": "external", "http_proxy_role": "default"}}
          ),
      )

      client.list("/")
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

- Подключение из интернета {#from-internet}

  1. Пример кода:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="https://<идентификатор_кластера_{{ ytsaurus-name }}>.proxy.ytsaurus.yandexcloud.net",
          config=with_iam_token_auth(config={"proxy": {"enable_proxy_discovery": False}}),
      )

      client.list("/")
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

{% endlist %}
