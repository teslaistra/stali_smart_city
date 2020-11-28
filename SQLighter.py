import sqlite3
import datetime


class SQLighter:

    def __init__(self, database):
        self.connection = sqlite3.connect(database)
        self.cursor = self.connection.cursor()

    def get_user(self, login, password):
        obj = self.cursor.execute(f"SELECT * FROM users WHERE LOGIN = '{login}' AND PASSWORD = '{password}'")

        if len(obj.fetchall()) == 0:
            return False
        else:
            return True

    def get_valid_questions(self, user_id):
        age = self.cursor.execute(f"SELECT age FROM users where UID = '{user_id}'").fetchall()[0][0]
        print("found age =", age)
        obj = self.cursor.execute(
            f"SELECT rubrick_id FROM questions where target_age_min < '{age}' and target_age_max > '{age}'")
        valid_rubricks = []
        for rubrick in obj.fetchall():
            print(rubrick[0])
            if not rubrick[0] in valid_rubricks:
                valid_rubricks.append(rubrick[0])

        print(valid_rubricks)
        return valid_rubricks

    def get_survies(self, user_id):
        rubricks = []
        rubrick_ids = self.get_valid_questions(user_id)
        for rubrick in rubrick_ids:
            obj = self.cursor.execute(f"SELECT name, description FROM rubricks where rubrick_id = {rubrick}")
            rubricks.append([obj.fetchall()[0], rubrick])
        return rubricks

    def get_initiatives(self):
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
        self.cursor.execute(
            f"INSERT INTO complaints (text, user_id ) VALUES('{text}',{int(user_id)})")
        self.connection.commit()

    def get_questions(self, rubric_id):
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

    def close(self):
        """ Закрываем текущее соединение с БД """
        self.connection.close()
