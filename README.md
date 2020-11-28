# "Умный город": Система Анализа Мнений

Инструмент учета мнения и пожеланий жителей при оценке каждого из субиндексов. Приложение позволяет собирать мнения на тему различных инициатив, формировать серии опросов и проводить градацию ответов по шкале негативности-позитивности посредством применения машинного обучения. Также реализуется функция "единого окна" жалоб и предложений.

**Средства разработки:** Python, FastAPI, SQLite, scikit learn, Flutter.

## Инструкция по запуску

## Принципы работы

Выделены 2 подхода к сбору мнений:
1. Активный пользователь отвечает на несколько коротких вопросов в неделю.
2. Пользователь может отправить жалобу или выступить с инициативой через систему.

Каждый вопрос имеет собственный вес и в соответствии с ним влияет на соответствующий мнению по выбранному субиндексу показатель. Значение показателя для одного субиндекса может быть вычислено по формулам:
<p align="center">
  <img src="https://latex.codecogs.com/svg.latex?\frac{\sum_{q\in%20Q}W_q\sum_{v\in%20V_q}w_v%20s_v%20+%20\sum_{q\in%20Q}W_q\sum_{a\in%20A_q}p_a}{\sum%20W_q}" /> 
</p>


## FAQ

**Как сбор мнений поможет расчету индекса?**

**Почему статистика не будет субъективной?**

**Почему способ быстрее и проще текущих способов ручного сбора данных?**
