from fastapi import FastAPI
from SQLighter import *
from text_model.text_model import TextModel

app = FastAPI(title="Hack")


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/login/")
async def login(login: str, password: str):
    """
    Логин в приложение через внутренний аккаунт
    :param login: Логин пользователя
    :param password: Пароль пользователя
    :return: результат логина
    """
    db_worker = SQLighter("hell.db")

    is_registred = db_worker.get_user(login, password)

    result = {"registred": is_registred}
    db_worker.close()
    return result


#
@app.get("/top_survies/")
async def read_coords(user_id: float):
    """
    Получение списка опросов
    :param user_id: номер пользователя
    :return: список рубрик(опросов)
    """
    db_worker = SQLighter("hell.db")
    survey = db_worker.get_survies(user_id)
    result = {}
    for a in survey:
        print(a)
        result["name"] = a[0][0]
        result["description"] = a[0][1]
        result["rubrick_id"] = a[1]
    return result


@app.get("/top_initiatives/")
async def top_initiatives():
    """
    Получение списка инициатив
    :return: вернет список инициатив
    """
    db_worker = SQLighter("hell.db")
    initiatives = db_worker.get_initiatives()

    return initiatives


@app.get("/send_complaint/")
async def send_complaint(text: str, user_id: float):
    """
    Отправка жалобы
    :param text: Текст жалобы
    :param user_id: Номер пользователя
    """
    db_worker = SQLighter("hell.db")
    db_worker.send_complaint(text, user_id)
    db_worker.close()


#
@app.get("/get_questions/")
async def get_questions(rubric_id: int):
    """
    Получить вопросы в конкретной рубрике
    :param rubric_id: Номер рубрики
    :return: Список вопросов из этой рубрики
    """
    db_worker = SQLighter("hell.db")
    return db_worker.get_questions(rubric_id)


@app.get("/send_free_answer/")
async def send_free_answer(text: str, question_id: int, user_id: int):
    """
    Отправка ответа в свободной форме на вопрос
    :param text: Текст ответа
    :param question_id: Номер вопроса
    :param user_id: Номер пользователя
    """
    db_worker = SQLighter("hell.db")

    predicter = TextModel()
    prediction = predicter.predict([text])
    negative, positive = prediction.tolist()[0][0], prediction.tolist()[0][1]
    result_prediction = "POSITIVE" if positive > negative else "NEGATIVE"
    db_worker.send_free_answer(text, question_id, result_prediction, user_id)
    db_worker.close()


@app.get("/send_variant_answer/")
async def send_variant_answer(variant_id: str, question_id: int, user_id: int):
    """
    Отправка ответа в виде варианта ответа на вопрос
    :param variant_id: Номер варианта ответа
    :param question_id: Номер вопроса
    :param user_id: Номер пользователяд
    """
    db_worker = SQLighter("hell.db")

    db_worker.send_variant_answer(variant_id, question_id, user_id)
    db_worker.close()
