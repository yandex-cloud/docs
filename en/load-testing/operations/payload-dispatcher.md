---
title: "How to collect user requests for load testing using {{ load-testing-full-name }}"
description: "Follow this guide to collect user requests and use this data for load testing."
---

# Preparing test data using the `dispatcher` tool

`dispatcher` is designed for collecting user requests and saving them to data files which are used for subsequent load testing.

This tool works as a proxy: it redirects HTTP requests to the target server and returns the server's responses back to the client. If a proxied request completes successfully with a 2xx HTTP status code, it is saved to [data](../concepts/payload.md) files which are then used for load testing. `dispatcher` allows configuring rules and amount of data to save using special flags.

## Getting started {#before-you-begin}

1. Install [Go 1.22 or higher](https://go.dev/doc/install):

   ```bash
   wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
   tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
   export PATH=$PATH:/usr/local/go/bin
   ```

1. Install [Git](https://en.wikipedia.org/wiki/Git) using the following command:

   ```bash
   sudo apt install git
   ```

## Collecting requests {#collecting-payload}

1. Clone the GitHub [repository](https://github.com/yandex-cloud-examples/yc-load-testing-dispatcher) and go to the `yc-load-testing-dispatcher` folder:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-load-testing-dispatcher.git
   cd yc-load-testing-dispatcher
   ```

1. Run `dispatcher` with the relevant flags:

   ```bash
   go run dispatcher.go -target '<target_address>' -port <port> -ssl -noproxy -saveall -nostatic
   ```

   Where:
   * `target`: Address of the service for which requests are proxied and saved.
   * `port`: Port used to run the server. The default port is 8888.
   * `ssl`: Enables proxying requests via a secure HTTPS connection.
   * `noproxy`: Determines whether to save requests without proxying them.
   * `saveall`: Allows saving all requests regardless of the HTTP status code of the response to the proxied request.
   * `nostatic`: Allows disregarding saving requests for static content, such as CSS, JS, JPEG, JPG, PNG, GIF, ICO, SVG, WOFF, and WOFF2.

   Example of running:

   ```bash
   go run dispatcher.go -target 'yandex.ru' -port 8080 -nostatic
   ```

   Result:
   ```text
   Dispatcher listens to your requests
   ```

   After running, send all requests for load testing to `localhost:8080`. You can also open the `localhost:8080` page in your browser to load the website specified in the `target` flag.

   All requests are written in series immediately after receiving the response. Therefore, the order of requests running in parallel may differ from the one in the final file.

   Result:
   ```text
   The payload is written to a raw.payload file
   The payload is written to a httpjson.payload file
   The payload is written to a uri.payload file
   The payload is written to a uripost.payload file
   ```

   After completing all the requests you need, press **Ctrl + C** to close `dispatcher`.

   {% note warning %}

   You should avoid closing it before you get all the responses, as the test data may not be written yet.

   {% endnote %}

   Requests are saved to the following files:

   * `uri.payload` for [URI](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/uri) requests
   * `uripost.payload` for [URIPOST](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/uripost) requests
   * `raw.payload` for [RAW](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/raw) requests
   * `httpjson.payload` for [HTTP_JSON](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/http-json) requests