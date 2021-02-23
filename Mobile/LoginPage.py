from kivy.uix.screenmanager import Screen
import json
import os.path
from kivy.clock import Clock
import utils


class LoginPage(Screen):
    def connect(self):
        utils.get_remote_settings()
        data = {'operation': 'mobile_connect'}
        answer = json.loads(utils.request_server(data))
        print(answer)
        if answer['result'] == 'true':
            utils.port = int(answer['port'])
            print(f'connected to port {utils.port}')
        else:
            raise Exception

    def login(self, login, password):
        try:
            if not utils.port:
                self.connect()
        except ValueError:
            self.children[0].children[0].text = """
            Вход
            НЕКОРРЕКТНОЕ ЗНАЧЕНИЕ ПОРТА В КОНФИГУРАЦИИ!
            """
            return
        except Exception:
            self.children[0].children[0].text = """
            Вход
            Не удалось войти
            """
            return

        self.children[0].children[0].text = 'Вход'
        data = {'operation': 'mobile_login', 'login': login, 'password': password}
        answer = json.loads(utils.request_server(data))
        print(answer)
        if answer['result'] == 'true':
            with open('login.txt', 'w') as f:
                f.write(login)
            utils.login = login
            utils.need_connect = False
            Clock.schedule_once(self.change_screen)
        else:
            self.children[0].children[0].text = """
            Вход
            Не удалось войти
            """

    def on_enter(self):
        Clock.schedule_once(self.change_screen)

    def change_screen(self, *args):
        if os.path.isfile('login.txt') and utils.port:
            with open('login.txt', 'r') as f:
                utils.login = f.read().split()
            self.manager.current = 'main'

    pass
