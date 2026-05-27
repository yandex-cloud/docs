```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>URL shortener</title>
  <!-- warns against sending unnecessary GET requests to /favicon.ico -->
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>

<body>
  <h1>Welcome</h1>
  <form action="javascript:shorten()">
    <label for="url">Enter a link:</label><br>
    <input id="url" name="url" type="text"><br>
    <input type="submit" value="Shorten">
  </form>
  <p id="shortened"></p>
</body>

<script>
  function shorten() {
    const link = document.getElementById("url").value
    fetch("/shorten", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: link
    })
    .then(response => response.json())
    .then(data => {
      const url = data.url
      document.getElementById("shortened").innerHTML = `<a href=${url}>${url}</a>`
    })
    .catch(error => {
      document.getElementById("shortened").innerHTML = `<p>${error} occurred. Try again.</p>`
    })
  }
</script>

</html>
```