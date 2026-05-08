```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Сокращатель URL</title>
  <!-- предостережет от лишнего GET запроса на адрес /favicon.ico -->
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>

<body>
  <h1>Добро пожаловать</h1>
  <form action="javascript:shorten()">
    <label for="url">Введите ссылку:</label><br>
    <input id="url" name="url" type="text"><br>
    <input type="submit" value="Сократить">
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
      document.getElementById("shortened").innerHTML = `<p>Произошла ошибка ${error}, попробуйте еще раз</p>`
    })
  }
</script>

</html>
```