from kivy.uix.screenmanager import Screen
import json
import os.path
from kivy.clock import Clock
import utils


class LoginPage(Screen):
    def login(self, HOST, PORT, login):
        utils.host, utils.port = HOST, int(PORT)
        msg = '{"type":"login","login":"' + login + '"}'
        out = json.loads(utils.send_message(msg))
        print(out)
        if out['result'] == 'true':
            with open('login.txt', 'w') as f:
                f.write(login + ' ' + HOST + ' ' + PORT)
            utils.log_name = login
            Clock.schedule_once(self.change_screen)

    def on_enter(self):
        Clock.schedule_once(self.change_screen)

    def change_screen(self, *args):
        if os.path.isfile('login.txt'):
            with open('login.txt', 'r') as f:
                allinfo = f.read().split()
                utils.log_name = allinfo[0]
                utils.host = allinfo[1]
                utils.port = int(allinfo[2])

            self.manager.current = 'main'
    pass
