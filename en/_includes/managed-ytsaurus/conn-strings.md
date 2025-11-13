### Bash {#bash}

Before connecting:

1. {% include [cli-install](../cli-install.md) %}
1. Install the YTsaurus CLI according to the [instructions](https://ytsaurus.tech/docs/en/api/cli/install).
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Connecting from a user VM {#from-yandex-vm}

  1. Get the access configuration file using the following YC CLI command:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <cluster_name_or_ID> --private
     ```

     {% cut "Configuration file example" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "http://hp.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.mdb.yandexcloud.net:32100";
         network_name = "external";
         http_proxy_role = "default";
       }
     }
     ```

     {% endcut %}

     The configuration file will be saved to `~/.yt/config`.

     You can get the cluster ID with the [list of clusters in the folder](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Run a request for the root directory contents list:

      ```bash
      yt list /
      ```

- Connecting from the internet {#from-internet}

  1. Get the access configuration file using the following YC CLI command:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <cluster_name_or_ID>
     ```

     {% cut "Configuration file example" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "https://<{{ ytsaurus-name }}_cluster_ID>.proxy.ytsaurus.yandexcloud.net";
         enable_proxy_discovery = %false;
       }
     }
     ```
     
     {% endcut %}
     
     The configuration file will be saved to `~/.yt/config`.

     You can get the cluster ID with the [list of clusters in the folder](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Run a request for the root directory contents list:

      ```bash
      yt list /
      ```

{% endlist %}

### Go {#go}

The example uses [OAuth token](../../iam/concepts/authorization/oauth-token.md)-based authorization.

To connect to your cluster:

1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install --yes golang git && \
    go mod init example && go get go.ytsaurus.tech/yt/go
    ```

1. Issue an OAuth token.
1. Prepare a sample file for connection:

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

1. Run this command:

    ```bash
    go run connect.go -id <{{ ytsaurus-name }}_cluster_ID> -token <user_OAuth_token>
    ```

    You can get the cluster ID with the [list of clusters in the folder](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

### Python {#python}

Before connecting:

1. {% include [cli-install](../cli-install.md) %}
1. Install the YTsaurus CLI according to the [instructions](https://ytsaurus.tech/docs/en/api/cli/install).
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Connecting from a user VM {#from-yandex-vm}

  1. Code example:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="http://hp.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.mdb.yandexcloud.net:32100",
          config=with_iam_token_auth(
              config={"proxy": {"network_name": "external", "http_proxy_role": "default"}}
          ),
      )

      client.list("/")
      ```

  1. Connecting:

      ```bash
      python3 connect.py
      ```

- Connecting from the internet {#from-internet}

  1. Code example:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="https://<{{ ytsaurus-name }}_cluster_ID>.proxy.ytsaurus.yandexcloud.net",
          config=with_iam_token_auth(config={"proxy": {"enable_proxy_discovery": False}}),
      )

      client.list("/")
      ```

  1. Connecting:

      ```bash
      python3 connect.py
      ```

{% endlist %}
