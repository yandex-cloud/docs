{% note info %}

Some variables are not serialized and, therefore, cannot be saved. For example, let's assume we have a variable with a file open for writing: `f = open("file.txt", "w")`.

Such variables will get this warning during the assignment: `The following variables cannot be serialized:`.

{% endnote %}