import sqlite3
import random
import datetime
import numpy as np

from collections import Counter


class SQLighter:

    def __init__(self, database):
        self.connection = sqlite3.connect(database)
        self.cursor = self.connection.cursor()

    def get_weighted_complaints_proportion(self, city_id, indicator_id):
        """
        Возвращает частное суммы тональностей текста, определяемой по шкале позитивности -- негативности
        и общего числа зарегистрировавшихся в городе пользователей.
        """
        comps = self.cursor.execute(f"SELECT classification FROM complaints WHERE city_id = '{city_id}' AND indicator_id = '{indicator_id}'").fetchall()
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
        questions = self.cursor.execute(f"SELECT question_id, weight FROM questions WHERE indicator_id = '{indicator_id}'").fetchall()
        weighted_sum = 0.0 # взвешенная сумма по всем вопросам и ответам
        total_weight = 0.0 # суммарный вес всех вопросов

        for q in questions:
            total_weight += float(q[1])

            variants = self.cursor.execute(f"SELECT variant_id FROM answered_questions_variants WHERE city_id = '{city_id}' AND answered_question_id = '{q[0]}'").fetchall()
            unique_variants = Counter([int(v[0]) for v in variants])
            variant_sum = 0.0 # взвешенная сумма по ответам
            total_votes = 0 # количество голосов

            for v in unique_variants.keys():
                weight = self.cursor.execute(f"SELECT weight FROM variants WHERE variant_id = '{v}'").fetchall()[0][0]
                variant_sum += float(weight) * unique_variants[v]
                total_votes += unique_variants[v]

            weighted_sum += variant_sum / total_votes * float(q[1])

            free_answers = self.cursor.execute(f"SELECT classification FROM answered_questions_free WHERE city_id = '{city_id}' AND answered_question_id = '{q[0]}'").fetchall()
            free_sum = 0.0 # взвешенная сумма по свободным ответам

            for c in free_answers:
                free_sum += float(c[0]) * 2 - 1

            weighted_sum += free_sum / len(free_answers) * float(q[1])

        return weighted_sum / total_weight


class SocialStatisticsCalculator:

    def __init__(self, database):
        self.sqlighter = SQLighter(database)

    def compute_index(self, city_id, indicator_id, complaints_impact_level=0.2):
        """
        Считает финальный показатель. Результат работы -- число от 1 до 12.
        """
        complaints = self.sqlighter.get_weighted_complaints_proportion(city_id, indicator_id)
        answers = self.sqlighter.get_weighted_complaints_proportion(city_id, indicator_id)
        return (complaints * complaints_impact_level + answers * (1 - complaints_impact_level)) * 12
