---
title: "Instructions for operations with {{ objstorage-full-name }} (S3)"
description: "In this article, you'll learn how to work with {{ objstorage-full-name }} (S3) in {{ yandex-cloud }}. Find out how to use buckets (create, delete, and edit them) and objects (upload and download objects, get download links, and delete objects), as well as how to host static websites (set up hosting and your own domain and configure HTTPS)."
---

# Step-by-step instructions for {{ objstorage-name }}

## Buckets {#buckets}

* [{#T}](buckets/create.md)
* [{#T}](buckets/delete.md)
* [{#T}](buckets/limit-max-volume.md)
* [{#T}](buckets/bucket-availability.md)
{% if product == "yandex-cloud" and audience != "internal"%}
* [{#T}](buckets/encrypt.md)
{% endif %}
* [{#T}](buckets/lifecycles.md)
* [{#T}](buckets/cors.md)
* [{#T}](buckets/policy.md)
* [{#T}](buckets/versioning.md)
* [{#T}](buckets/edit-acl.md)
{% if product == "yandex-cloud" %}
* [{#T}](buckets/enable-logging.md)
* [{#T}](buckets/configure-object-lock.md)
{% endif %}

## Objects {#objects}

* [{#T}](objects/upload.md)
* [{#T}](objects/info.md)
* [{#T}](objects/download.md)
* [{#T}](objects/link-for-download.md)
{% if product == "yandex-cloud" %}
* [{#T}](objects/edit-object-lock.md)
{% endif %}
* [{#T}](objects/delete.md)
* [{#T}](objects/delete-all.md)
* [{#T}](objects/deleting-multipart.md)
* [{#T}](objects/edit-acl.md)

## Hosting static sites {#hosting}

* [{#T}](hosting/setup.md)
* [{#T}](hosting/own-domain.md)
* [{#T}](hosting/multiple-domains.md)
* [{#T}](hosting/certificate.md)