import sqlite3
from collections import Counter


class SQLighter:

    def __init__(self, database):
        self.connection = sqlite3.connect(database)
        self.cursor = self.connection.cursor()

    def get_user(self, login, password):
        """
        Существует ли искомый пользователь
        :param login: Логин пользователя
        :param password: Пароль пользователя
        :return: Истина если пользователь существует и ложь если не существует
        """
        obj = self.cursor.execute(f"SELECT * FROM users WHERE LOGIN = '{login}' AND PASSWORD = '{password}'")

        if len(obj.fetchall()) == 0:
            return False
        else:
            return True

    def get_valid_questions(self, user_id):
        """
        Поиск тех рубрик, которые доустпны для прохождения опроса пользователем
        :param user_id: Номер пользователя
        :return: вернет список номеров валидных рубрик
        """
        age = self.cursor.execute(f"SELECT age FROM users where UID = '{user_id}'").fetchall()[0][0]

        obj = self.cursor.execute(
            f"SELECT rubrick_id FROM questions where target_age_min < '{age}' and target_age_max > '{age}'")
        valid_rubricks = []

        for rubrick in obj.fetchall():
            print(rubrick[0])
            if not rubrick[0] in valid_rubricks:
                valid_rubricks.append(rubrick[0])

        return valid_rubricks

    def get_survies(self, user_id):
        """
        Получение рубрик
        :param user_id: Номмер пользователя
        :return: Вернет названия и описания доступных рубрик
        """
        rubricks = []
        rubrick_ids = self.get_valid_questions(user_id)
        for rubrick in rubrick_ids:
            obj = self.cursor.execute(f"SELECT name, description FROM rubricks where rubrick_id = {rubrick}")
            rubricks.append([obj.fetchall()[0], rubrick])
        return rubricks

    def get_initiatives(self):
        """
        Список инициатив
        :return: вернет список инициатив
        """
        obj = self.cursor.execute(
            f"SELECT short_description, long_description,votes_up, votes_down, author_id  FROM initiatives where is_approved = 'YES'")
        initiatives_result = obj.fetchall()
        authors = {}
        result = []
        for init in initiatives_result:
            obj = self.cursor.execute(f"SELECT name FROM users where UID = '{init[4]}'")
            name = obj.fetchall()[0][0]
            result.append(
                {"short_description": init[0], "long_description": init[1], "votes_up": init[2], "votes_down": init[3],
                 "author_name": name})
        return result

    def send_complaint(self, text, user_id):
        """
        Отправка жалобы
        :param text: Текст жалобы
        :param user_id: Номер пользователя
        """
        self.cursor.execute(
            f"INSERT INTO complaints (text, user_id ) VALUES('{text}',{int(user_id)})")
        self.connection.commit()

    def get_questions(self, rubric_id):
        """
        Получит вопросы определенной рубрики
        :param rubric_id: Номер рубрики
        :return: вернет список вопросов в рубрике и тип варианта ответа на них
        """
        obj = self.cursor.execute(
            f"SELECT text, is_free_answers,question_id FROM questions where rubrick_id = '{rubric_id}'")
        questions = obj.fetchall()
        result = {}
        for i, question in enumerate(questions):

            if question[1] == "FALSE":
                obj = self.cursor.execute(f"SELECT text, variant_id FROM variants where question_id = '{question[2]}'")
                variants = obj.fetchall()
                variants_arr = []
                for var in variants:
                    variants_arr.append({"text": var[0], "variant_id": var[1]})
                result["question" + str(i)] = {"question_id": question[2], "question_text": question[0],
                                               "answers": variants_arr}
            else:
                result["question" + str(i)] = {"question_id": question[2], "question_text": question[0],
                                               "answers": ""}
        return result

    def send_free_answer(self, text, question_id, result_prediction, user_id):
        self.cursor.execute(
            f"INSERT INTO answered_questions_free (user_id, text,classification,answered_question_id) VALUES({user_id},'{text}', '{result_prediction}','{question_id}')")
        self.connection.commit()

    def send_variant_answer(self, variant_id, question_id, user_id):
        self.cursor.execute(
            f"INSERT INTO answered_questions_variants (user_id, variant_id ,answered_question_id) VALUES({user_id}, '{variant_id}','{question_id}')")
        self.connection.commit()

    def get_weighted_complaints_proportion(self, city_id, indicator_id):
        """
        Возвращает частное суммы тональностей текста, определяемой по шкале позитивности -- негативности
        и общего числа зарегистрировавшихся в городе пользователей.
        """
        comps = self.cursor.execute(
            f"SELECT classification FROM complaints WHERE city_id = '{city_id}' AND indicator_id = '{indicator_id}'").fetchall()
        users = self.cursor.execute(f"SELECT * FROM users WHERE city_id = '{city_id}'").fetchall()
        if len(users) == 0:
            return None

        weighted_sum = 0.0
        for c in comps:
            weighted_sum += float(c[0])
        return weighted_sum / len(users)

    def get_weighted_answers_coefficient(self, city_id, indicator_id):
        """
        Возвращает показатель удовлетворённости гражданами цифровизацией города по заданному индикатору.
        """
        questions = self.cursor.execute(
            f"SELECT question_id, weight FROM questions WHERE indicator_id = '{indicator_id}'").fetchall()
        weighted_sum = 0.0  # взвешенная сумма по всем вопросам и ответам
        total_weight = 0.0  # суммарный вес всех вопросов

        for q in questions:
            total_weight += float(q[1])

            variants = self.cursor.execute(
                f"SELECT variant_id FROM answered_questions_variants WHERE city_id = '{city_id}' AND answered_question_id = '{q[0]}'").fetchall()
            unique_variants = Counter([int(v[0]) for v in variants])
            variant_sum = 0.0  # взвешенная сумма по ответам
            total_votes = 0  # количество голосов

            for v in unique_variants.keys():
                weight = self.cursor.execute(f"SELECT weight FROM variants WHERE variant_id = '{v}'").fetchall()[0][0]
                variant_sum += float(weight) * unique_variants[v]
                total_votes += unique_variants[v]

            weighted_sum += variant_sum / total_votes * float(q[1])

            free_answers = self.cursor.execute(
                f"SELECT classification FROM answered_questions_free WHERE city_id = '{city_id}' AND answered_question_id = '{q[0]}'").fetchall()
            free_sum = 0.0  # взвешенная сумма по свободным ответам

            for c in free_answers:
                free_sum += float(c[0]) * 2 - 1

            weighted_sum += free_sum / len(free_answers) * float(q[1])

        return weighted_sum / total_weight

    def close(self):
        """ Закрываем текущее соединение с БД """
        self.connection.close()
