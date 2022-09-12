{% list tabs %}

- Kibana

  
  **Если хосту с ролью _Data node_ назначен публичный IP-адрес:**
  1. Перед подключением установите [SSL-сертификат](https://{{ s3-storage-host }}{{ pem-path }}) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
  1. В браузере перейдите по одному из адресов:
     - `https://c-<идентификатор кластера {{ ES }}>.rw.{{ dns-zone }}`, если публичный IP-адрес назначен всем хостам с этой ролью. Идентификатор кластера можно получить [со списком кластеров в каталоге](../../managed-elasticsearch/operations/cluster-list#list-clusters).
     - `https://<имя любого хоста с ролью Data node и публичным IP>.{{ dns-zone }}`
  1. Введите имя пользователя и пароль.

  {% include [kibana-api](mes-kibana-api.md) %}

  **Если ни одному хосту с ролью _Data node_ не назначен публичный IP-адрес:**
  1. [Создайте](../../compute/quickstart/quick-create-linux.md) виртуальную машину на основе Linux в той же [виртуальной сети](../../vpc/concepts/network.md), что и кластер.
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
  1. Установите зависимости:  

     ```bash
     sudo apt update && sudo apt install -y nginx ssl-cert
     ```

  1. Скопируйте загруженный SSL-сертификат в директорию `/etc/nginx/`:

     ```bash
     sudo cp ~/.elasticsearch/root.crt /etc/nginx/root.crt
     ```
 
  1. Измените файл конфигурации по умолчанию для NGINX, например, так:
  
     `/etc/nginx/sites-available/default`
     ```nginx
     upstream es-datanodes {
        server <FQDN хоста 1 с ролью Data Node>:443;
        ...
        server <FQDN хоста N с ролью Data Node>:443;
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
   
     Также можно использовать директиву `proxy_pass` со специальным FQDN:
     ```nginx
     proxy_pass https://c-<идентификатор кластера {{ ES }}>.rw.{{ dns-zone }};
     ```
   
     {% note warning %}
   
     В этом примере конфигурационного файла используется самоподписанный сертификат `snakeoil` из пакета `ssl-cert`. Использовать этот сертификат в реальном кластере небезопасно. Вместо самоподписанного сертификата укажите путь к вашим публичным и приватным ключам SSL-сертификата в директивах `ssl_certificate` и `ssl_certificate_key`.   
   
     {% endnote %}

  1. Перезапустите NGINX:

     ```bash
     sudo systemctl restart nginx
     ```

  1. Добавьте сертификат, указанный в директиве `ssl_certificate`, в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).

  1. Перейдите в браузере по адресу `https://<публичный IP-адрес ВМ>`.
  
  1. Введите имя пользователя и пароль.

  {% include [kibana-api](mes-kibana-api.md) %}
  

- Bash

  **Пример команды для подключения с использованием SSL-соединения :**

  {% include [default-connstring](./mes/default-connstring.md) %}

- PowerShell

  **Пример команды для подключения с использованием SSL-соединения :**

  ```powershell
   curl `
     -Certificate <абсолютный путь к файлу сертификата> `
     -Uri https://c-<идентификатор кластера {{ ES }}>.rw.{{ dns-zone }}:9200 `
     -Credential <имя пользователя>
   ```

   В открывшемся окне введите пароль пользователя.

- Python
  
  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install --yes python3 python3-pip && \
  pip3 install elasticsearch==7.17.2
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.py`
  ```python
  from elasticsearch import Elasticsearch

  ES_CA = '~/.elasticsearch/root.crt'

  ES_USER = '<имя пользователя>'
  ES_PASS = '<пароль>'

  ES_HOSTS = [
    "<FQDN хоста 1 {{ ES }} с ролью Data Node>",
    ...,
    "<FQDN хоста N {{ ES }} с ролью Data Node>"
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

  **Подключение:**
  
  ```bash
  python3 connect.py
  ```
  
- Go

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go get github.com/elastic/go-elasticsearch
  ```
  
  **Пример кода для подключения с использованием SSL-соединения:**

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

  var ES_CA = "/home/<домашняя директория>/.elasticsearch/root.crt"

  var ES_USER = "<имя пользователя>"
  var ES_PASS = "<пароль>"

  var ES_HOSTS = []string{
    "https://<FQDN хоста 1 {{ ES }} с ролью Data Node>:9200",
    ...,
    "https://<FQDN хоста N {{ ES }} с ролью Data Node>:9200"}

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
  
  В отличие от других способов подключения, в этом коде необходимо указывать полный путь к сертификату `CA.pem` для {{ ES }} в переменной `ES_CA`.
  
  **Подключение:**
  
  ```bash
  go run connect.go
  ```

{% endlist %}
