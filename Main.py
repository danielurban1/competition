# -*- coding: utf-8 -*-
from Login import *
from Competition import *
from Guest import *

if __name__ == "__main__":
    l1 = Login()
    admin = BDtemplate
    guest = Guest
    result = l1.logging()
    if result == "admin":
        admin()
    elif result == "guest":
        guest()