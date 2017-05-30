# -*- coding: utf-8 -*-
import pymysql

class Login():
    
    def __init__(self):
        self.conn = pymysql.connect("localhost", "root", "123Fokus456p", "zawody_bjj")
        self.cursor = self.conn.cursor()
        
        
    def logging(self):
        while True:
            login = input("Input user name: ")
            password = input("Input password: ")
            if login == "root" and password == "123Fokus456p":
                print("Logged as an admin.")
                return "admin"
            else:
                print("Invalid login or password. Try again.")