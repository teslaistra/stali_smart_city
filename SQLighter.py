import sqlite3
import random
import datetime
import numpy as np


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

    def update_last_time(self, house_id):
        self.cursor.execute(
            f"UPDATE pictures SET UPDATE_DATE = '{datetime.datetime.now().replace(microsecond=0)}' where HOUSE_ID = {house_id}")
        self.connection.commit()

    def close(self):
        """ Закрываем текущее соединение с БД """
        self.connection.close()
