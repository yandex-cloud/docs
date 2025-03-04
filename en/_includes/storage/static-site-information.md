You can host your static website in {{ objstorage-name }}. A static website is based on such client-side technologies as HTML, CSS, or JavaScript. It may not contain any scripts that run on the web server side. 

In a static website, pages are [objects](../../storage/concepts/object.md) in a [bucket](../../storage/concepts/bucket.md) where object [keys](../../storage/concepts/object.md#key) match the website page paths and the full page URL has this format `http(s)://{{ s3-web-host }}/<bucket_name>/<object_key>`. {#static-site-information}
