
{% list tabs %}

- UNIX
  
  ```
  base64 -i input.jpg > output.txt
  ```
  
- Windows
  
  ```
  C:> Base64.exe -e input.jpg > output.txt
  ```
  
- PowerShell
  
  ```
  [Convert]::ToBase64String([IO.File]::ReadAllBytes("./input.jpg")) > output.txt
  ```
  
- Python
  
  ```python
  # Импортируйте библиотеку для кодирования в Base64
  import base64
  
  # Создайте функцию, которая кодирует файл и возвращает результат.
  def encode_file(file):
    file_content = file.read()
    return base64.b64encode(file_content)
  ```
  
- Node.js
  
  ```js
  // Считайте содержимое файла в память.
  var fs = require('fs');
  var file = fs.readFileSync('/path/to/file');
  
  // Получите содержимое файла в формате Base64.
  var encoded = Buffer.from(file).toString('base64');
  ```
  
- Java
  
  ```java
  // Импортируйте библиотеку для кодирования в Base64.
  import org.apache.commons.codec.binary.Base64;
  
  // Получите содержимое файла в формате Base64.
  byte[] fileData = Base64.encodeBase64(yourFile.getBytes());
  ```
  
- Go
  
  ```go
  import (
      "bufio"
      "encoding/base64"
      "io/ioutil"
      "os"
  )
  
  // Откройте файл
  f, _ := os.Open("/path/to/file")
  
  // Прочитайте содержимое файла.
  reader := bufio.NewReader(f)
  content, _ := ioutil.ReadAll(reader)
  
  // Получите содержимое файла в формате Base64.
  base64.StdEncoding.EncodeToString(content)
  ```
  
{% endlist %}