import json
import os
from threading import Thread
from time import sleep

import plyer
from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.screenmanager import Screen

import utils


class MainPage(Screen):
    def notif(self):
        while True:

            msg ='{"operation":"notif", "login":"' + utils.login + '"}'
            out = json.loads(utils.request_server(msg))
            if out['result'] == 'true':
                plyer.notification.notify(title=utils.app_name, message="У вас новые заказы")
            sleep(30)

    def check_pull_refresh(self, args):
        if args.scroll_y > 1.03:
            self.change()

    def logout(self, args):
        os.remove('login.txt')
        self.manager.current = 'login'

    def open_order(self, id):
        utils.id_order = id
        self.manager.current = 'order'

    def change(self, *args):
        self.children[0].children[0].clear_widgets()
        msg ='{"type":"courierOrders","login":"' + utils.login + '"}'

        json_msg = json.loads(utils.request_server(msg))

        if json_msg['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует",
                        size_hint_y=None,
                        height=100)
            self.children[0].children[0].add_widget(lbl)

        else:
            lbl = Label(text="Заказы",
                        size_hint_y=None,
                        height=100)
            self.children[0].children[0].add_widget(lbl)
            for ord in json_msg['result']:
                btn = Button(text=ord['address']+' '+ord['start_time'],
                             size_hint_y=None,
                             height=100)
                setattr(btn, 'id_ord', ord['id'])
                btn.bind(on_release=lambda mybtn: self.open_order(mybtn.id_ord))
                self.children[0].children[0].add_widget(btn)
        btn = Button(text="Выйти",
                    size_hint_y=None,
                    height=100)
        btn.bind(on_release=self.logout)
        self.children[0].children[0].add_widget(btn)

    def on_enter(self):
        if utils.f:
            Thread(target=self.notif).start()
            f = 0
        Clock.schedule_once(self.change)

    pass
