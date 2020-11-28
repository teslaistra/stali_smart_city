# "Умный город": Система Анализа Мнений

Инструмент учета мнения и пожеланий жителей при оценке каждого из субиндексов. Приложение позволяет собирать мнения на тему различных инициатив, формировать серии опросов и проводить градацию ответов по шкале негативности-позитивности посредством применения машинного обучения. Также реализуется функция "единого окна" жалоб и предложений.

**Средства разработки:** Python, FastAPI, SQLite, scikit learn, Flutter.

## Инструкция по запуску

## Принципы работы

![Схема базы данных](images/database.png)

Реализованы 2 подхода к сбору мнений:
1. Активный пользователь отвечает на несколько коротких вопросов в неделю.
2. Пользователь может отправить жалобу или выступить с инициативой через систему.

Каждый вопрос имеет собственный вес и в соответствии с ним влияет на соответствующий мнению по выбранному субиндексу показатель. Для анализа текстовых данных используется определение его тональности (эмоционального окраса) с помощью наивного байесовского классификатора. Значение показателя для одного субиндекса может быть вычислено по формулам:
<p align="center">
  <img src="https://latex.codecogs.com/svg.latex?\text{Voting}=\frac{\sum_{q\in%20Q}W_q\sum_{v\in%20V_q}w_v%20s_v%20+%20\sum_{q\in%20Q}W_q\sum_{a\in%20A_q}p_a}{\sum%20W_q}"/> 
</p>
<p align="center">
  <img src="https://latex.codecogs.com/svg.latex?\text{Complaints}=\frac{\sum_{c\in%20C}p_c}{|C|}"/> 
</p>
<p align="center">
  <img src="https://latex.codecogs.com/svg.latex?\text{Index}=12\times\left((1-\alpha)\text{Voting}+\alpha~\text{Complaints}\right)"/> 
</p>

Здесь:
- <img src="https://latex.codecogs.com/svg.latex?Q"/> - множество вопросов;
- <img src="https://latex.codecogs.com/svg.latex?C"/> - множество жалоб;
- <img src="https://latex.codecogs.com/svg.latex?V_q"/> - множество вариантов ответов на вопрос <img src="https://latex.codecogs.com/svg.latex?q"/>;
- <img src="https://latex.codecogs.com/svg.latex?A_q"/> - множество ответов на вопрос <img src="https://latex.codecogs.com/svg.latex?q"/> в свободной форме;
- <img src="https://latex.codecogs.com/svg.latex?W_q\in[0, 1]"/> - вес вопроса <img src="https://latex.codecogs.com/svg.latex?q"/>;
- <img src="https://latex.codecogs.com/svg.latex?w_v\in[0,%201]"/> - положительность варианта <img src="https://latex.codecogs.com/svg.latex?v"/> (задается вручную);
- <img src="https://latex.codecogs.com/svg.latex?s_v"/> - доля выбравших вариант <img src="https://latex.codecogs.com/svg.latex?v"/> пользователей среди всех проголосовавших;
- <img src="https://latex.codecogs.com/svg.latex?p_a\in[0,%201]"/> - оценка тональности текста;
- <img src="https://latex.codecogs.com/svg.latex?\alpha"/> - гиперпараметр алгоритма - предполагаемое влияние жалоб на показатель.

## FAQ

**Как сбор мнений поможет расчету индекса?**

**Почему статистика не будет субъективной?**

**Почему способ быстрее и проще текущих способов ручного сбора данных?**
