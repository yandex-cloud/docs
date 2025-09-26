* `<bucket_name>`: [Name of the bucket](../../storage/concepts/bucket.md#naming) containing the object you need, e.g., `first-bucket`.
* `<object_key>`: [Object key](../../storage/concepts/object.md#key) in the bucket to generate a pre-signed URL for, e.g., `sample.txt`.
* `--expires-in`: URL validity period in seconds.
* `--as-attachment`: For a forced download of an object when opening the URL you got in a browser. This is an optional parameter. If the option is not set, when opening a URL, the browser may try to display the contents of the text object instead of downloading it.