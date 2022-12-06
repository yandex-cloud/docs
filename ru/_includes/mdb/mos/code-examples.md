### Bash {#bash}

{% list tabs %}

- Подключение с SSL

    {% include [Default connection string](default-connstring.md) %}

{% endlist %}

### Go {#go}

Перед подключением установите зависимости:

```bash
go mod init opensearch-example && \
go get github.com/opensearch-project/opensearch-go
```

{% list tabs %}

- Подключение с SSL

    1. Пример кода:

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
        	"<FQDN хоста 1 с ролью DATA>:{{ port-mos }}",
        	...,
        	"<FQDN хоста N с ролью DATA>:{{ port-mos }}"
        	}
        
        var CA = "/home/<домашняя директория>/.opensearch/root.crt"
        
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

    1. Подключение:

        ```bash
        go run connect.go
        ```

{% endlist %}

### PowerShell {#powershell}

{% list tabs %}

- Подключение с SSL

   ```powershell
   curl `
     -Certificate <абсолютный путь к файлу сертификата> `
     -Uri https://<идентификатор хоста {{ OS }} с ролью DATA>.{{ dns-zone }}:{{ port-mos }} `
     -Credential admin
   ```

{% endlist %}

### Python {#python}
  
Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install opensearch-py
```

{% list tabs %}

- Подключение с SSL

    1. Пример кода:

        `connect.py`

        ```python
        from opensearchpy import OpenSearch

        CA = '~/.opensearch/root.crt'
        PASS = '<пароль>'
        HOSTS = [
          "<FQDN хоста 1 с ролью DATA>",
          ...,
          "<FQDN хоста N с ролью DATA>"
        ]

        conn = OpenSearch(
          HOSTS,
          http_auth=('admin', PASS),
          use_ssl=True,
          verify_certs=True,
          ca_certs=CA)

        print(conn.info())
        ```

    1. Подключение:

        ```bash
        python3 connect.py
        ```

{% endlist %}
