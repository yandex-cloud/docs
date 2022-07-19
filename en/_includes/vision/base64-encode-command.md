
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
  # Import the library for Base64 encoding.
  import base64
  
  # Create a function that encodes a file and returns the result.
  def encode_file(file):
    file_content = file.read()
    return base64.b64encode(file_content)
  ```

- Node.js

  ```js
  // Read the contents of the file into memory.
  var fs = require('fs');
  var file = fs.readFileSync('/path/to/file');
  
  // Get the contents of the file in Base64 format.
  var encoded = Buffer.from(file).toString('base64');
  ```

- Java

  ```java
  //  Import the library for Base64 encoding.
  import org.apache.commons.codec.binary.Base64;
  
  // Get the contents of the file in Base64 format.
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
  
  // Open the file.
  f, _ := os.Open("/path/to/file")
  
  // Read the contents of the file.
  reader := bufio.NewReader(f)
  content, _ := ioutil.ReadAll(reader)
  
  // Get the contents of the file in Base64 format.
  base64.StdEncoding.EncodeToString(content)
  ```

{% endlist %}

