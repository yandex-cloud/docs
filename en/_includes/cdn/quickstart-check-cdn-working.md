1. Wait for the DNS records to update. This may take a few hours.
1. Make sure the `cdn` CNAME record in the DNS server's cache points to the generated URL, e.g., `{{ cname-example-yc }}`.
1. Open the website in your browser to make sure it is working. Here is an example:

    ```http
    http://cdn.example.com/index.html
    ```