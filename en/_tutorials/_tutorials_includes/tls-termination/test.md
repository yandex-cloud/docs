To test the hosting:

1. Create the website home page, i.e., the `index.html` file.

   {% cut "Example of the index.html file" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My site</title>
     </head>
     <body>
       <h1>This is my site</h1>
     </body>
   </html>
   ```

   {% endcut %}

1. Upload the `index.html` file to each VM:

   {% include [upload-files](../upload-web-site-files.md) %}

1. Open the website at `http://my-site.com` in your browser. A redirect to `https://my-site.com` should occur with the TLS certificate from {{ certificate-manager-name }} already enabled.