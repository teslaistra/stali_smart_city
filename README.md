# "Умный город": Система Анализа Мнений

Инструмент учета мнения и пожеланий жителей при оценке каждого из субиндексов. Приложение позволяет собирать мнения на тему различных инициатив, формировать серии опросов и проводить градацию ответов по шкале негативности-позитивности посредством применения машинного обучения. Также реализуется функция "единого окна" жалоб и предложений.

**Средства разработки:** Python, FastAPI, SQLite, scikit learn, Flutter.

## Инструкция по запуску

**Как получить статистику из базы данных**
- Создать объект класса `SocialStatisticsCalculator`, передав ему базу данных в качестве параметра;
- Вызвать функцию `compute_index`, указав id города и индикатора.


## Принципы работы
Схема базы данных:
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
- <img src="https://latex.codecogs.com/svg.latex?W_q\in[0,%201]"/> - вес вопроса <img src="https://latex.codecogs.com/svg.latex?q"/>;
- <img src="https://latex.codecogs.com/svg.latex?w_v\in[0,%201]"/> - положительность варианта <img src="https://latex.codecogs.com/svg.latex?v"/> (задается вручную);
- <img src="https://latex.codecogs.com/svg.latex?s_v"/> - доля выбравших вариант <img src="https://latex.codecogs.com/svg.latex?v"/> пользователей среди всех проголосовавших;
- <img src="https://latex.codecogs.com/svg.latex?p_a\in[0,%201]"/> - оценка тональности текста;
- <img src="https://latex.codecogs.com/svg.latex?\alpha"/> - гиперпараметр алгоритма - предполагаемое влияние жалоб на показатель.

## FAQ

**Как сбор мнений улучшит индекс?**

При анализе цифровизации городской среды важно учитывать не только бинарные и количественные показатели, но и удобство с точки зрения жителя. В версии списка показателей 2019-ого года почти 70% критериев могут быть как оценены по документам, так и опросом пользователей [(таблица с классификацией показателей)](https://drive.google.com/file/d/1MNqQ7wvTkJv9V74xvmvVtqToAJp1ddCs/view?usp=sharing). Таким образом, введение дополнительных показателей непосредственно для мнений пользователей или модификация существующих может не только упростить процесс сбора данных, но и повысить качество оценки.

**Почему статистика не будет субъективной?**

Предлагаемая модель сбора статистических данных предусматривает формулировку не окрашенных эмоционально вопросов. В случае возникновения ошибок и непредвиденных ситуаций из-за человеческого фактора, таковые могут быть также автоматически определены. Тем не менее, сбор достаточного количества голосов, который возможен с описанной системой проведения опросов, снизит уровень субъективности информации.

**Почему способ быстрее и проще текущих способов ручного сбора данных?**

Для запуска системы достаточно единожды составить список вопросов по каждому субиндексу. Набор вопросов для каждого города идентичен, анализ данных производится автоматически.
