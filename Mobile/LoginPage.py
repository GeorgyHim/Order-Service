from kivy.uix.screenmanager import Screen
import json
import os.path
from kivy.clock import Clock
import utils


class LoginPage(Screen):
    def login(self, login):
        try:
            utils.get_remote_settings()
        except ValueError:
            self.children[0].children[0].text = """
            Вход
            НЕКОРРЕКТНОЕ ЗНАЧЕНИЕ ПОРТА В КОНФИГУРАЦИИ!
            """
            return

        self.children[0].children[0].text = 'Вход'
        msg = '{"type":"login","login":"' + login + '"}'
        out = json.loads(utils.request_server(msg))
        print(out)
        if out['result'] == 'true':
            with open('login.txt', 'w') as f:
                f.write(login)
            utils.log_name = login
            Clock.schedule_once(self.change_screen)
        else:
            self.children[0].children[0].text = """
            Вход
            Не удалось войти
            """

    def on_enter(self):
        Clock.schedule_once(self.change_screen)

    def change_screen(self, *args):
        if os.path.isfile('login.txt'):
            with open('login.txt', 'r') as f:
                utils.log_name = f.read().split()
            self.manager.current = 'main'

    pass
