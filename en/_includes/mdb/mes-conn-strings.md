{% list tabs %}

- Kibana

  
  **If a host with the _Data node_ role is assigned a public IP address:**
  1. Before connecting, install the [SSL certificate](https://{{ s3-storage-host }}{{ pem-path }}) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
  1. In the browser, go to one of the addresses:
     - `https://c-<{{ ES }} cluster ID>.rw.{{ dns-zone }}`, if a public IP address is assigned to all hosts with this role. You can fetch the cluster ID with a [list of clusters in the folder](../../managed-elasticsearch/operations/cluster-list#list-clusters).
     - `https://<name of any host with the Data node role and a public IP>.{{ dns-zone }}`
  1. Enter your user name and password.

  **If no host with the _Data node_ role is assigned a public IP address:**

  1. [Create](../../compute/quickstart/quick-create-linux.md) a Linux-based VM instance in the same [virtual network](../../vpc/concepts/network.md) as the cluster.

  1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH:

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y nginx ssl-cert
     ```

  1. Copy the downloaded SSL certificate to the `/etc/nginx/` directory :

     ```bash
     sudo cp ~/.elasticsearch/root.crt /etc/nginx/root.crt
     ```

  1. Edit the NGINX default configuration file, for example, like this:

     `/etc/nginx/sites-available/default`

     ```nginx
     upstream es-datanodes {
        server <FQDN of host 1 with the Data Node role>:443;
        ...
        server <FQDN of host N with the Data Node role>:443;
     }
     
     server {
        listen 443 ssl;
     
        ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
        ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
     
        server_name _;
     
        location / {
     
            proxy_pass https://es-datanodes;
     
            proxy_ssl_trusted_certificate /etc/nginx/root.crt;
            proxy_ssl_session_reuse on;
        }
     }
     ```

     You can also use the  `proxy_pass` directive with a special FQDN:

     ```nginx
     proxy_pass https://c-<{{ ES }} cluster ID>.rw.{{ dns-zone }};
     ```

     {% note warning %}

     This configuration file example uses a self-signed `snakeoil` certificate from the `ssl-cert` package. It's not safe to use this certificate in a real cluster. Instead of the self-signed certificate, specify the path to your public and private SSL certificate keys in the `ssl_certificate` and `ssl_certificate_key` directives.

     {% endnote %}

  1. Restart NGINX:

     ```bash
     sudo systemctl restart nginx
     ```

  1. Add the certificate specified in the `ssl_certificate` directive to the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).

  1. In the browser, go to `https://<public IP address of the VM instance>`.

  1. Enter your user name and password.


- Bash

  **Command example for connecting via SSL:**

  {% include [default-connstring](./mes/default-connstring.md) %}


- PowerShell

  **Command example for connecting via SSL:**

  ```powershell
   curl `
     -Certificate <absolute path to the certificate file> `
     -Uri https://c-<{{ ES }} cluster ID>.rw.{{ dns-zone }}:9200 `
     -Credential <username>
  ```

   In the window that opens, enter the user's password.

- Python

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install elasticsearch==7.17.2
  ```

  **Code example for connecting via SSL:**

  `connect.py`

  ```python
  from elasticsearch import Elasticsearch
  
  ES_CA = '~/.elasticsearch/root.crt'
  
  ES_USER = '<username>'
  ES_PASS = '<password>'
  
  ES_HOSTS = [
    "<FQDN of {{ ES }} host 1 with the Data Node role>",
    ...,
    "<FQDN of {{ ES }} host N with the Data Node role>",
    ]
  
  conn = Elasticsearch(
    ES_HOSTS,
    http_auth=(ES_USER, ES_PASS),
    use_ssl=True,
    verify_certs=True,
    ca_certs=ES_CA)
  
  print(conn.info())
  
  conn.close()
  ```

  **Connecting:**

  ```bash
  python3 connect.py
  ```

- Go

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go get github.com/elastic/go-elasticsearch
  ```

  **Code example for connecting via SSL:**

  `connect.go`

  ```go
  package main
  
  import (
        "crypto/tls"
        "crypto/x509"
        "github.com/elastic/go-elasticsearch"
        "io/ioutil"
        "log"
        "net/http"
  )
  
  var ES_CA = "/home/<home directory>/.elasticsearch/root.crt"
  
  var ES_USER = "<username>"
  var ES_PASS = "<password>"
  
  var ES_HOSTS = []string{
    "https://<FQDN of {{ ES }} host 1 with the Data Node role>:9200",
    ...,
    "https://<FQDN of {{ ES }} host N with the Data Node role>:9200",
  
  func main() {
       caCert, err := ioutil.ReadFile(ES_CA)
        if err != nil {
                log.Fatal(err)
        }
        caCertPool := x509.NewCertPool()
        caCertPool.AppendCertsFromPEM(caCert)
  
        cfg := elasticsearch.Config{
                Addresses: ES_HOSTS,
                Transport: &http.Transport{
                        TLSClientConfig: &tls.Config{
                                RootCAs: caCertPool,
                        },
                },
                Username: ES_USER,
                Password: ES_PASS,
        }
        conn, err := elasticsearch.NewClient(cfg)
        if err != nil {
                log.Printf("Error creating the client: %s", err)
        } else {
                log.Println(conn.Info())
        }
  }
  ```

  Unlike other connection methods, this code must specify the full path to the `CA.pem` certificate for {{ ES }} in the `ES_CA` variable.

  **Connecting:**

  ```bash
  go run connect.go
  ```

{% endlist %}

