```yaml
apiVersion: v1
data:
  index.html: "<!DOCTYPE html>\n<html>\n<head>\n    <title>Stackland test</title>\n    <meta charSet=\"UTF-8\"/>\n</head>\n<body>\n    <h1>Stackland external access test</h1>\n    <p>This page is used to test external access to Stackland</p>\n</body>\n</html>\n"
kind: ConfigMap
metadata:
  name: test-stackland-html
  namespace: <project name>
```
