
{% list tabs group=programming_language %}

- UNIX {#unix}

  ```
  base64 -i input.pdf > output.txt
  ```

- Windows {#windows}

  ```
  C:> Base64.exe -e input.pdf > output.txt
  ```

- PowerShell {#powershell}

  ```
  [Convert]::ToBase64String([IO.File]::ReadAllBytes("./input.pdf")) > output.txt
  ```

- Python {#python}

  ```python
  # Import a library for encoding files in Base64
  import base64

  # Create a function that will encode a file and return results.
  def encode_file(file):
    file_content = file.read()
    return base64.b64encode(file_content)
  ```

- Node.js {#node}

  ```js
  // Read the file contents to memory.
  var fs = require('fs');
  var file = fs.readFileSync('/path/to/file');

  // Get the file contents in Base64 format.
  var encoded = Buffer.from(file).toString('base64');
  ```

- Java {#java}

  ```java
  // Import a library for encoding files in Base64.
  import org.apache.commons.codec.binary.Base64;

  // Get the file contents in Base64 format.
  byte[] fileData = Base64.encodeBase64(yourFile.getBytes());
  ```

- Go {#go}

  ```go
  import (
    "bufio"
    "encoding/base64"
    "io/ioutil"
    "os"
  )

  // Open the file
  f, _ := os.Open("/path/to/file")

  // Read the file contents.
  reader := bufio.NewReader(f)
  content, _ := ioutil.ReadAll(reader)

  // Get the file contents in Base64 format.
  base64.StdEncoding.EncodeToString(content)
  ```

{% endlist %}