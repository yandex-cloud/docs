## Go {#go}

Перед подключением установите зависимости:

```bash
go mod init opensearch-example && \
go get github.com/opensearch-project/opensearch-go
```

Пример кода:

{% list tabs group=connection %}


- Подключение с SSL {#with-ssl}

    `connect.go`

    ```go
    package main

    import (
    	"crypto/tls"
    	"crypto/x509"
    	"crypto/x509"
    	"github.com/opensearch-project/opensearch-go"
    	"io/ioutil"
    	"log"
    	"net/http"
    )

    var hosts = []string{
    	"<FQDN_хоста_1_с_ролью_DATA>:{{ port-mos }}",
    	...,
    	"<FQDN_хоста_N_с_ролью_DATA>:{{ port-mos }}"
    	}

    var CA = "/home/<домашняя_директория>/.opensearch/root.crt"

    var password = "<пароль>"

    func main() {
    	caCert, err := ioutil.ReadFile(CA)
    	if err != nil {
    		log.Fatal(err)
    	}
    	caCertPool := x509.NewCertPool()
    	caCertPool.AppendCertsFromPEM(caCert)

    	cfg := opensearch.Config{
    		Addresses: hosts,
    		Transport: &http.Transport{
    			TLSClientConfig: &tls.Config{
    				RootCAs: caCertPool,
    			},
    		},
    		Username: "admin",
    		Password: password,
    	}
    	es, err := opensearch.NewClient(cfg)
    	if err != nil {
    		log.Printf("Error creating the client: %s", err)
    	} else {
    		log.Println(es.Info())
    	}
    }
    ```

    В отличие от других способов подключения, в этом примере необходимо указывать полный путь к сертификату `CA.pem` для {{ OS }} в переменной `CA`.

    {% include [see-fqdn](fqdn-host.md) %}

{% endlist %}

Подключение:

```bash
go run connect.go
```

## Python {#python}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install opensearch-py
```

Пример кода:

{% list tabs group=connection %}


- Подключение с SSL {#with-ssl}

    `connect.py`

    ```python
    from opensearchpy import OpenSearch

    CA = '~/.opensearch/root.crt'
    PASS = '<пароль>'
    HOSTS = [
      "<FQDN_хоста_1_с_ролью_DATA>",
      ...,
      "<FQDN_хоста_N_с_ролью_DATA>"
    ]

    conn = OpenSearch(
      HOSTS,
      http_auth=('admin', PASS),
      use_ssl=True,
      verify_certs=True,
      ca_certs=CA)

    print(conn.info())
    ```

    {% include [see-fqdn](fqdn-host.md) %}

{% endlist %}

Подключение:

```bash
python3 connect.py
```
