import json

from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.modalview import ModalView
from kivy.uix.screenmanager import Screen

from utils import request_server, order_id


class OrderPage(Screen):
    # TODO: Переделать,
    #  Добавить кнопку "Выполнен"

    def on_enter(self):
        Clock.schedule_once(self.change)

    def change(self, *args):
        if self.get_grid():
            self.get_grid().clear_widgets()

        data = {'operation': 'get_order', 'order_id': order_id}
        response = json.loads(request_server(data))

        if response['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует", width=40, height=100)
            self.get_grid().add_widget(lbl)
        else:
            self.get_grid().add_widget(Label(text="Имя:",size_hint_x=None, width=200))
            self.get_grid().add_widget(Label(text=response['result']['name']))
            self.get_grid().add_widget(Label(text="Телефон:",size_hint_x=None,width=200))
            self.get_grid().add_widget(Label(text=response['result']['phone'], ))
            self.get_grid().add_widget(Label(text="Адрес:",size_hint_x=None, width=200))
            self.get_grid().add_widget(Label(text=response['result']['address'], ))
            self.get_grid().add_widget(Label(text="Время:",size_hint_x=None, width=200, ))
            self.get_grid().add_widget(Label(text=response['result']['start_time'], ))
            self.get_grid().add_widget(Label(text="Содержание:",size_hint_x=None,  width=200))
            self.get_grid().add_widget(Label(text=response['result']['content'],text_size=(box.width-200,None) ))
            btn = Button(text='Подтвердить получение')
            btn.bind(on_release=self.accept_order)
            self.get_grid().add_widget(btn)

    def accept_order(self, *args):
        msg ='{"type":"orderReport","id":"' + str(order_id) + '"}'

        json_msg = json.loads(request_server(msg))

        if json_msg['result'] == "true":
            content = Button(text='Отправка прошла успешно')
            view = ModalView(size_hint=(None, None), size=(200, 100))
            view.add_widget(content)
            content.bind(on_press=view.dismiss)
            view.open()
            self.manager.current = 'main'
        else:
            content = Button(text='Ошибка отправки')
            view = ModalView(size_hint=(None, None), size=(150, 100))
            view.add_widget(content)

            content.bind(on_press=view.dismiss)
            view.open()

    def back(self):
        self.manager.current = 'main'

    def get_grid(self):
        try:
            return self.children[0].children[0].children[0]
        except Exception:
            return None

    pass
