# Task types

[User validation](./validation.md) consists of two steps. The first step includes a basic check where the user is asked to complete the [main task](#main-task). After completing the main task, the user's request is automatically sent to {{ captcha-name }}. If the service considers the request suspicious, it will offer the user to solve an [additional task](#additional-task).

## Main task {#main-task}

The basic check is carried out when the main task is performed.

You can choose between these two types of main tasks in {{ captcha-name }}:

* **Checkbox**: User must click the **I am not a robot** button.

  {% cut "Checkbox" %}

  ![image](../../_assets/smartcaptcha/checkbox-task.gif)

  {% endcut %}

* **Slider**: User must move the slider from left to right.

  {% note info %}

  The slider is in the [Preview](../../overview/concepts/launch-stages.md) stage, so it may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Slider" %}

  ![image](../../_assets/smartcaptcha/slider-task.gif =370x93)

  {% endcut %}

## Additional task {#additional-task}

If the service considers the result of the main task suspicious, it offers to the user an additional task. In this case, the service analyzes user behavior in more detail.

There are several types of additional tasks in {{ captcha-name }}:

* ![image](../../_assets/smartcaptcha/text.svg) **Text recognition**: The user is shown a distorted text in an image and should enter it into a special field.

  {% cut "Text recognition" %}

  ![image](../../_assets/smartcaptcha/text-task.gif =370x401)

  {% endcut %}

* ![image](../../_assets/smartcaptcha/silhouette.svg) **Silhouettes**: An image includes several icons, and the user should select them in a specified order.

  {% note info %}

  The silhouettes are in the [Preview](../../overview/concepts/launch-stages.md) stage, so they may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Silhouettes" %}

  ![image](../../_assets/smartcaptcha/silhouette-task.gif)

  {% endcut %}

* ![image](../../_assets/smartcaptcha/kaleidoscope.svg) **Kaleidoscope**: The user should build a picture from parts by moving them using a slider. To solve the task, the user should move the slider to a position where the image parts are arranged in the correct order.

  {% note info %}

  The Kaleidoscope is in the [Preview](../../overview/concepts/launch-stages.md) stage, so it may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Kaleidoscope" %}

  ![image](../../_assets/smartcaptcha/kaleidoscope-task.gif =370x405)

  {% endcut %}
