### Bash {#bash}

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   {% include [Default connection string](default-connstring.md) %}

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

### Go {#go}

Before connecting, install the dependencies:

```bash
go mod init opensearch-example && \
go get github.com/opensearch-project/opensearch-go
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   1. Code example:

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
      	"<FQDN_of_host_1_with_DATA_role>:{{ port-mos }}",
      	...,
      	"<FQDN_of_host_N_with_DATA_role>:{{ port-mos }}"
      	}

      var CA = "/home/<home_directory>/.opensearch/root.crt"

      var password = "<password>"

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

      Unlike other connection methods, in this example, you need to use the full path to the `CA.pem` certificate for {{ OS }} in the `CA` variable.

   1. Connecting:

      ```bash
      go run connect.go
      ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

### PowerShell {#powershell}

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   ```powershell
   curl `
     -Certificate <absolute_path_to_certificate_file> `
     -Uri https://<FQDN_of_{{ OS }}_DATA_host>:{{ port-mos }} `
     -Credential admin
   ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

### Python {#python}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install opensearch-py
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   1. Code example:

      `connect.py`

      ```python
      from opensearchpy import OpenSearch

      CA = '~/.opensearch/root.crt'
      PASS = '<password>'
      HOSTS = [
        "<FQDN_of_DATA_host_1>",
        ...,
        "<FQDN_of_DATA_host_N>"
      ]

      conn = OpenSearch(
        HOSTS,
        http_auth=('admin', PASS),
        use_ssl=True,
        verify_certs=True,
        ca_certs=CA)

      print(conn.info())
      ```

   1. Connecting:

      ```bash
      python3 connect.py
      ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}
