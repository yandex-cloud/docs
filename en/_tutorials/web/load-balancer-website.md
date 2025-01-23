# Fault-tolerant website with load balancing via {{ network-load-balancer-full-name }}


In this tutorial, you will learn how to create a fault-tolerant website with load balancing. You will create a [{{ vpc-full-name }}](../../vpc/) cloud network, deploy a [{{ compute-full-name }}](../../compute/) instance group, and configure load balancing between two [availability zones](../../overview/concepts/geo-scope.md) to protect your website from failures using [{{ network-load-balancer-name }}](../../network-load-balancer/).

For the website, you will use the [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) or LEMP (Apache web server is replaced with [Nginx](https://www.nginx.com/)) stack.

You can create your website infrastructure using one of these tools: