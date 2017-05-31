from Competition import *

class Guest(BDtemplate):
    def __init__(self):
        while (True):
            self.conn = pymysql.connect("localhost", "root", "123Fokus456p", "zawody_bjj")
            self.divisions = ["biale_64", "biale_70", "biale_76", "biale_82_i_3", "biale_88_i_3", "biale_100_i_5", "biale_plus_100_i_5", "niebieskie_64", "niebieskie_70", "niebieskie_76", "niebieskie_82_i_3", "niebieskie_88_i_3", "niebieskie_94_i_3", "niebieskie_100_i_5", "niebieskie_plus_100_i_5", "purpurowe_57_i_5", "purpurowe_64", "purpurowe_70", "purpurowe_76", "purpurowe_82_i_3", "purpurowe_88_i_3", "purpurowe_94_i_3", "purpurowe_100_i_5", "purpurowe_plus_100_i_5", "elita_64", "elita_70", "elita_76", "elita_82_i_3", "elita_88_i_3", "elita_94_i_3", "elita_100_i_5", "elita_plus_100_i_5"]            
            self.cursor = self.conn.cursor()
            self.i = input('What wpuld you like to do? (I)-insert, (S)-select, (U)-update, (D)-drop, (Q)-quit').upper()
            if (self.i == 'I'):    
                self.insert()
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
            
            
    def insert(self):
        print('You cannot do that')
        
        
    def update(self):
        print('You cannot do that')            


    def drop(self):
        print('You cannot do that')