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


    def update_last_time(self, house_id):
        self.cursor.execute(
            f"UPDATE pictures SET UPDATE_DATE = '{datetime.datetime.now().replace(microsecond=0)}' where HOUSE_ID = {house_id}")
        self.connection.commit()


    def close(self):
        """ Закрываем текущее соединение с БД """
        self.connection.close()