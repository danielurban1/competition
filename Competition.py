# -*- coding: utf-8 -*-
import pymysql
class BDtemplate:

    def __init__(self):
        self.conn = pymysql.connect("localhost", "root", "123Fokus456p", "zawody_bjj")
        self.divisions = ["biale_64", "biale_70", "biale_76", "biale_82_i_3", "biale_88_i_3", "biale_100_i_5", "biale_plus_100_i_5", "niebieskie_64", "niebieskie_70", "niebieskie_76", "niebieskie_82_i_3", "niebieskie_88_i_3", "niebieskie_94_i_3", "niebieskie_100_i_5", "niebieskie_plus_100_i_5", "purpurowe_57_i_5", "purpurowe_64", "purpurowe_70", "purpurowe_76", "purpurowe_82_i_3", "purpurowe_88_i_3", "purpurowe_94_i_3", "purpurowe_100_i_5", "purpurowe_plus_100_i_5", "elita_64", "elita_70", "elita_76", "elita_82_i_3", "elita_88_i_3", "elita_94_i_3", "elita_100_i_5", "elita_plus_100_i_5"]
        while (True):
            self.cursor = self.conn.cursor()
            self.i = input('What wpuld you like to do? (I)-insert, (S)-select, (U)-update, (D)-drop, (Q)-quit').upper()
            if (self.i == 'I'):    
                self.wprowadzanie()
                self.__init__()
            elif(self.i == 'S'):
                self.select()
                self.__init__()
            elif(self.i == 'U'):
                self.update()
                self.__init__()
            elif(self.i == 'D'):
                self.drop()
                self.__init__()            
            elif(self.i == 'Q'):
                print('Logging out...')
                break
            self.conn.close()

    def drop(self):
        while True:
            self.name = input("Input name: ")
            try:
                self.sql1 = "delete from dane_os where imie_nazwisko = '" + self.name + "';"
                self.cursor.execute(self.sql1)
                self.results = self.cursor.fetchall()
                break
            except:
                if self.option == "Q":
                    break
                else:
                    print("Invalid input try again")
        self.cursor.execute(self.sql1)
        self.conn.commit()
        print('Deleted.')
        
    def update(self):
        while True:
            self.id_log = input("Input id: ")
            self.updated_name = input("Input updated name: ")
            self.category = input("Input updated category id: ")
            self.club = input("Input updated club id: ")          
            try:
                self.sql1 = "update dane_os set imie_nazwisko = '" + self.updated_name + "' , kategoria = " + self.category + " , klub = " + self.club + " where id_login = " + self.id_log + ";" 
                self.cursor.execute(self.sql1)
                self.results = self.cursor.fetchall()                
                break
            except:
                print("Invalid input try again")
        self.cursor.execute(self.sql1)
        self.conn.commit()
        print('Updated.')             
        
        
    def select(self):
        while True:
            print("1 - weight divisons")
            print("2 - teams")
            print("3 - teams ranking")
            print("4 - referees")
            print("Q - quit")
            print("Choose what to display:", end="")
            self.option = input().upper()
            if self.option == "1":
                self.select_weight()
                self.__init__()
            elif self.option == "2":
                self.select_club()
                self.__init__()
            elif self.option == "3":
                    self.select_club_ranking()
                    self.__init__()
            elif self.option == "4":
                self.select_referees()
                self.__init__()
            elif self.option == "Q":
                break
            else:
                print("Invalid input try again")
                
    def select_weight(self):
        while True:
            print("Select weight division:")
            print("1 - white -64 kg")
            print("2  - white -70 kg")
            print("3  - white -76 kg")
            print("4  - white -82.3 kg")
            print("5  - white -82.3 kg")
            print("6  - white -88.3 kg")
            print("7  - white -94.3 kg")
            print("8  - white -100.5 kg")
            print("9  - white +100.5 kg")
            print("10 - blue -64 kg")
            print("11 - blue -70 kg")
            print("11 - blue -76 kg")
            print("12 - blue -82.3 kg")
            print("13 - blue -82.3 kg")
            print("14 - blue -88.3 kg")
            print("15 - blue -94.3 kg")
            print("16 - blue -100.5 kg")
            print("17 - blue +100.5 kg")
            print("18 - purple -57.5 kg")
            print("19 - purple -64 kg")
            print("20 - purple -70 kg")
            print("21 - purple -76 kg")
            print("22 - purple -82.3 kg")
            print("23 - purple -82.3 kg")
            print("24 - purple -88.3 kg")
            print("25 - purple -94.3 kg")
            print("26 - purple -100.5 kg")
            print("27 - purple +100.5 kg") 
            print("28 - elite -64 kg")
            print("29 - elite -70 kg")
            print("30 - elite -76 kg")
            print("31 - elite -82.3 kg")
            print("32 - elite -82.3 kg")
            print("33 - elite -88.3 kg")
            print("34 - elite -94.3 kg")
            print("35 - elite -100.5 kg")
            print("36 - elite +100.5 kg")
            print("Q - quit")
            self.option = input().upper()
            try:
                self.sql1 = "select * from " + self.divisions[int(self.option) - 1] + ";"
                self.cursor.execute(self.sql1)
                self.results = self.cursor.fetchall()
                print ("%10s %20s %30s" % ("name", "club", self.divisions[int(self.option) - 1]))
                for row in self.results:
                    name = row[0]
                    club = row[1]
                    division = row[2]
                    print ("%10s %20s %65s" % (name, club, division))
                break
            except:
                if self.option == "Q":
                    break
                else:
                    print("Invalid input try again")
                    
                    
    def select_club(self):
        self.sql1 = "select * from kluby;"
        self.cursor.execute(self.sql1)
        self.results = self.cursor.fetchall()
        print ("Club name")
        for row in self.results:
            club = row[1]
            print(club)
            
            
    def select_club_ranking(self):
        self.sql1 = "select * from ranking_klubow;"
        self.cursor.execute(self.sql1)
        self.results = self.cursor.fetchall()
        print ("%30s %10s %10s %10s %10s" % ("club", "gold", "silver", "bronze", "points"))
        for row in self.results:
            club = row[0]
            gold = row[1]
            silver = row[2]
            bronze = row[3]
            points = row[4]
            print ("%30s %10s %10s %10s %10s" % (club, gold, silver, bronze, points))
            
    
    def select_referees(self):
        self.sql1 = "select * from sedziowie;"
        self.cursor.execute(self.sql1)
        self.results = self.cursor.fetchall()
        print ("%10s" % ("referee name"))
        for row in self.results:
            referee = row[1]
            print ("%10s" % (referee))    
            
o1 = BDtemplate()

