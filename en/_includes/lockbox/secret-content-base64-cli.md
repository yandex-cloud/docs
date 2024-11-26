If a file is used as the confidential value, the returned secret content will be [Base64 encoded](https://{{ lang }}.wikipedia.org/wiki/Base64). To decode the file, use the Linux base64 utility:

```bash
base64 --decode <path_to_file> > output.txt
```