```yaml
apiVersion: v1
data:
  index.html: "<!DOCTYPE html>\n<html>\n<head>\n    <title>Тест Stackland</title>\n    <meta charSet=\"UTF-8\"/>\n</head>\n<body>\n    <h1>Тест внешнего доступа к Stackland</h1>\n    <p>Эта страница используется для тестирования внешнего доступа к сервису Stackland</p>\n</body>\n</html>\n"
kind: ConfigMap
metadata:
  name: test-stackland-html
  namespace: <название проекта>
```
