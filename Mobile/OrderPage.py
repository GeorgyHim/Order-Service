import json

from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.modalview import ModalView
from kivy.uix.screenmanager import Screen

from utils import send_message, id_order


class OrderPage(Screen):


    def accept_order(self,*args):
        msg ='{"type":"orderReport","id":"'+str(id_order)+'"}'

        json_msg = json.loads(send_message(msg))

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
        pass


    def change(self, *args):
        box = self.children[0].children[0]
        box.clear_widgets()
        btn = Button(text="Назад",
                    size_hint_x=None, width=200)
        order_bind = lambda *args: setattr(self.manager, "current", 'main')
        btn.bind(on_release=order_bind)
        box.add_widget(btn)
        box.add_widget(Label(text='Заказ',))
        msg ='{"type":"courierOrder","id":"'+str(id_order)+'"}'

        json_msg = json.loads(send_message(msg))
        if json_msg['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует",
                        width=40,
                        height=100)
            box.add_widget(lbl)
        else:

            box.add_widget(Label(text="Имя:",size_hint_x=None, width=200))
            box.add_widget(Label(text=json_msg['result']['name']))
            box.add_widget(Label(text="Телефон:",size_hint_x=None,width=200))
            box.add_widget(Label(text=json_msg['result']['phone'], ))
            box.add_widget(Label(text="Адрес:",size_hint_x=None, width=200))
            box.add_widget(Label(text=json_msg['result']['address'], ))
            box.add_widget(Label(text="Время:",size_hint_x=None, width=200, ))
            box.add_widget(Label(text=json_msg['result']['start_time'], ))
            box.add_widget(Label(text="Содержание:",size_hint_x=None,  width=200))
            box.add_widget(Label(text=json_msg['result']['content'],text_size=(box.width-200,None) ))
            btn = Button(text='Подтвердить получение')
            btn.bind(on_release=self.accept_order)
            box.add_widget(btn)
    def on_enter(self):
        Clock.schedule_once(self.change)
    pass