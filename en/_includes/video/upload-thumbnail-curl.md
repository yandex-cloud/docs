```
curl \
  --request PUT \
  --url '<signed_link>' \
  --header 'Content-Type: image/<image_format>' \
  --upload-file '<path_to_thumbnail_file>'
```

Where:
* `<signed_link>`: Signed thumbnail file upload link you got in the previous step.
* `<image_format>`: Format of the image to upload, such as `png`, `jpeg`, or `gif`. 
* `<path_to_thumbnail_file>`: Absolute path to the image file to upload. Do not use any shortcuts, including `~`.