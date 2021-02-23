import json
import os
from threading import Thread
from time import sleep

from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.screenmanager import Screen

import utils


class MainPage(Screen):
    def on_enter(self):
        if not utils.update_working:
            Thread(target=self.update).start()
            utils.update_working = True
        Clock.schedule_once(self.change)

    def update(self):
        while True:
            self.change()
            sleep(30)

    def change(self, *args):
        self.children[0].children[0].clear_widgets()
        data = {'operation': 'mobile_get_orders', 'login': utils.login}
        answer = json.loads(utils.request_server(data))

        if answer['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует",
                        size_hint_y=None,
                        height=100)
            self.children[0].children[0].add_widget(lbl)

        else:
            lbl = Label(text="Есть контакт!",
                        size_hint_y=None,
                        height=100)
            self.children[0].children[0].add_widget(lbl)
            # lbl = Label(text="Заказы",
            #             size_hint_y=None,
            #             height=100)
            # self.children[0].children[0].add_widget(lbl)
            # for ord in answer['result']:
            #     btn = Button(text=ord['address']+' '+ord['start_time'],
            #                  size_hint_y=None,
            #                  height=100)
            #     setattr(btn, 'id_ord', ord['id'])
            #     btn.bind(on_release=lambda mybtn: self.open_order(mybtn.id_ord))
            #     self.children[0].children[0].add_widget(btn)
        btn = Button(text="Выйти",
                    size_hint_y=None,
                    height=100)
        btn.bind(on_release=self.logout)
        self.children[0].children[0].add_widget(btn)

    def check_pull_refresh(self, args):
        if args.scroll_y > 1.03:
            self.change()

    def logout(self, args):
        os.remove('login.txt')
        self.manager.current = 'login'

    def open_order(self, id):
        utils.id_order = id
        self.manager.current = 'order'

    pass
