print("stat")

from fastapi import FastAPI
from SQLighter import *
from math import radians, cos, sin, asin, sqrt
from datetime import *
import torch
import numpy as np

app = FastAPI(title="Hack")


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/login/")
async def login(login: str, password: str):
    db_worker = SQLighter("hell.db")

    is_registred = db_worker.get_user(login, password)

    result = {"registred": is_registred}
    db_worker.close()
    return result

@app.get("/get_parking/")
async def read_coords(lat: float, lon: float):
    return lat, lon


@app.get("/feedback/")
async def read_coords(user_id: int, text: str):
    db_worker = SQLighter("parking.db")
    db_worker.insert_feedback(user_id, text)
    db_worker.close()

@app.get("/top_survies/")
async def read_coords(user_id: float):

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
async def read_coords():
    db_worker = SQLighter("hell.db")
    initiatives = db_worker.get_initiatives()

    return initiatives

@app.get("/send_complaint/")
async def send_complaint(text: str, user_id: float):
    db_worker = SQLighter("hell.db")
    db_worker.send_complaint(text, user_id)
    db_worker.close()

@app.get("/get_questions/")
async def get_questions(rubric_id: int):
    db_worker = SQLighter("hell.db")
    return db_worker.get_questions(rubric_id)

