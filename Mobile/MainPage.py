import json
from threading import Thread
from time import sleep

import plyer
from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.screenmanager import Screen

from utils import request_server, app_name, log_name


class MainPage(Screen):
    def notif(self):
        while True:

            msg ='{"type":"notif", "login":"' + log_name + '"}'
            out = json.loads(request_server(msg))
            if out['result'] == 'true':
                plyer.notification.notify(title=app_name, message="У вас новые заказы")
            sleep(30)

    def check_pull_refresh(self, args):

        if args.scroll_y > 1.03:
            self.change()


    def logout(self, args):
        os.remove('login.txt')
        self.manager.current = 'login'

    def open_order(self, id):
        global id_order
        id_order = id

        self.manager.current = 'order'

    def change(self, *args):
        self.children[0].children[0].clear_widgets()
        msg ='{"type":"courierOrders","login":"'+log_name+'"}'

        json_msg = json.loads(request_server(msg))

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
        global f
        if f:
            Thread(target=self.notif).start()
            f = 0
        Clock.schedule_once(self.change)
    pass