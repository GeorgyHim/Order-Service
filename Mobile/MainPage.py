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
            utils.update_working = True
            Thread(target=self.update).start()
        Clock.schedule_once(self.change)

    def update(self):
        while utils.update_working:
            sleep(10)
            self.change()

    def change(self, *args):
        if self.get_grid():
            self.get_grid().clear_widgets()
        data = {'operation': 'mobile_get_orders', 'login': utils.login}
        response = utils.request_server(data)

        if response['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует", color=(1, 0, 0, 1))
            if not utils.flag_connect_fail:
                self.children[0].add_widget(lbl)
                utils.flag_connect_fail = True
        else:
            utils.flag_connect_fail = False
            for order in response['result']:
                btn = Button(
                    text=order['info'] + ' ' + order['start_time'],
                    size_hint_y=None,
                    height=100
                )
                setattr(btn, 'order_id', order['id'])
                btn.bind(on_release=lambda b: self.open_order(b.order_id))
                self.get_grid().add_widget(btn)

    def check_pull_refresh(self, args):
        if args.scroll_y > 1.03:
            self.change()

    def logout(self, *args):
        os.remove('login.txt')
        self.manager.current = 'login'

    def open_order(self, order_id):
        utils.order_id = order_id
        self.manager.current = 'order'

    def on_leave(self, *args):
        utils.update_working = False

    def get_grid(self):
        try:
            return self.children[0].children[0].children[0]
        except Exception:
            return None

    pass
