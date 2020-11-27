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