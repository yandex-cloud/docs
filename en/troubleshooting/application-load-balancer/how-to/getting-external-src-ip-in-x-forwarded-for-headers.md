# How to get the real IP address of the source in request headers



## Case description {#case-description}

You need to log external IP addresses of clients establishing connections with the load balancer.

## Solution {#case-resolution}

When traffic is intercepted between clients and servers, the server access logs only contain the IP address of the proxy server or load balancer.

In {{ network-load-balancer-full-name }}, the IP address of the remote host initiating the request is visible by default without additional settings unless you use Ingress Controller for {{ k8s }}. If you are using it, follow [this guide](../../../managed-kubernetes/operations/create-load-balancer.md#lb-create) to manually set `TrafficPolicy: local` in order to preserve actual IP addresses for requests.

When you use {{ alb-full-name }}, the request source IP address is listed in the `X-Forwarded-For`.
The `X-Forwarded-For` header identifies the origin of the IP address of the user connecting to the web server via an HTTP proxy or a load balancer.

To write external addresses in the web server log, change its configuration.

{% list tabs %}

- Nginx

    If you are running an Nginx web server as a backend, make sure your Nginx service configuration has the `http_x_forwarded_for` variable in the `log_format` section:
    ```
    log_format main '$remote_addr - $http_x_forwarded_for - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" $request_time';
    ```

- Apache

    If you are running an Apache web server as a backend, make sure your Apache service configuration has the `%{X-Forwarded-For}` variable:

    ```text
    Log format config

    LogFormat "%{X-Forwarded-For}i %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i"" common
    SetEnvIf X-Forwarded-For "^......." forwarded
    CustomLog "logs/access_log" common env=forwarded
    ```

{% endlist %}

After changing the web server configuration and restarting it, you will see the external IP addresses of clients in your logs.
For example, if a request with IP 123.34.56.67 comes to Ingress:

```text
kubectl logs nginx-ingress-nginx-ingress-*****
123.34.56.67 - - [28/Jun/2022:09:11:32 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0" "-"
```

In the backend pod log, this address will be listed in the `X-Forwarded-For` header:

```text
kubectl logs -n demo-ns pod/nginx
10.20.129.8 - - [28/Jun/2022:09:11:32 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0" "123.34.56.67"
```