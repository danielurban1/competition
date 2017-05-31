# -*- coding: utf-8 -*-
import pymysql
import getpass

class Login():
    
    def __init__(self):
        self.conn = pymysql.connect("localhost", "root", "123Fokus456p", "zawody_bjj")
        self.cursor = self.conn.cursor()
        
        
    def logging(self):
        while True:
            login = input("User name: ")
            password = getpass.getpass('Password:')
            if login == "root" and password == "123Fokus456p":
                print("Logged as an admin.")
                return "admin";
            elif login == "guest" and password == "guest":
                print("Logged as a guest.")
                return "guest";
            else:
                print("Invalid login or password. Try again.")
