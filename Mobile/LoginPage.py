from kivy.uix.screenmanager import Screen
import json

import utils
import os.path
from kivy.clock import Clock

from utils import host, port


class LoginPage(Screen):

    def login(self, HOST, PORT, login):
        global host, port
        host, port = HOST, int(PORT)
        msg = '{"type":"login","login":"' + login + '"}'
        out = json.loads(utils.send_message(msg))
        print(out)
        if out['result'] == 'true':
            f = open('login.txt', 'w')
            f.write(login + ' ' + HOST + ' ' + PORT)
            global log_name
            log_name = login
            f.close()
            Clock.schedule_once(self.change_screen)

    def on_enter(self):
        Clock.schedule_once(self.change_screen)

    def change_screen(self, *args):

        if os.path.isfile('login.txt'):
            with open('login.txt', 'r') as f:
                global log_name, host, port
                allinfo = f.read().split()
                log_name = allinfo[0]
                host = allinfo[1]
                port = int(allinfo[2])

            self.manager.current = 'main'
    pass