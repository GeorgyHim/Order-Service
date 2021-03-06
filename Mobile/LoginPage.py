from kivy.uix.screenmanager import Screen
import json
import os.path
from kivy.clock import Clock
import utils


class LoginPage(Screen):
    def connect(self, host):
        utils.host = host
        utils.port = 7000
        data = {'operation': 'mobile_connect'}
        response = utils.request_server(data)
        print(response)
        if response['result'] == 'true':
            utils.port = int(response['port'])
            print(f'connected to port {utils.port}')
        else:
            raise Exception

    def login(self, host, login, password):
        try:
            if not utils.port:
                self.connect(host)
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
        response = utils.request_server(data)
        print(response)
        if response['result'] == 'true':
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
                utils.login = f.read()
            self.manager.current = 'main'

    pass
