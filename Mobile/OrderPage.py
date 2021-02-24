from kivy.clock import Clock
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.modalview import ModalView
from kivy.uix.screenmanager import Screen

import utils


class OrderPage(Screen):
    def on_enter(self):
        Clock.schedule_once(self.change)

    def change(self, *args):
        if self.get_grid():
            self.get_grid().clear_widgets()

        data = {'operation': 'mobile_get_order', 'order_id': utils.order_id}
        response = utils.request_server(data)

        if response['result'] == "fail":
            lbl = Label(text="Связь с сервером отсутсвует", width=40, height=100)
            self.get_grid().add_widget(lbl)
        else:
            self.get_grid().add_widget(Label(text='Номер заказа', size_hint_y=0.1, size_hint_x=0.2))
            self.get_grid().add_widget(Label(text=response['id'], size_hint_y=0.1))

            self.get_grid().add_widget(Label(text='Телефон клиента', size_hint_y=0.1, size_hint_x=0.2))
            self.get_grid().add_widget(Label(text=response['client_phone'], size_hint_y=0.1))

            self.get_grid().add_widget(Label(text='Время заказа', size_hint_y=0.1, size_hint_x=0.2))
            self.get_grid().add_widget(Label(text=response['start_time'], size_hint_y=0.1))

            self.get_grid().add_widget(Label(text='Оператор', size_hint_y=0.1, size_hint_x=0.2))
            self.get_grid().add_widget(Label(text=response['operator'], size_hint_y=0.1))

            self.get_grid().add_widget(Label(text='Заказ', size_hint_x=0.2))
            self.get_grid().add_widget(Label(text=response['info']))

            if int(response['status']) == 2:
                self.get_complete_button().text = 'Выполнен'
                self.get_complete_button().disabled = True
            else:
                self.get_complete_button().text = 'Выполнить'
                self.get_complete_button().disabled = False

    def complete_order(self, *args):
        data = {'operation': 'mobile_complete_order', 'order_id': utils.order_id}
        response = utils.request_server(data)

        if response['result'] == "true":
            view = ModalView(size_hint=(None, None), size=(200, 100))
            btn = Button(text='Заказ выполнен!')
            btn.bind(on_press=view.dismiss)
            view.add_widget(btn)
            view.open()
            self.manager.current = 'main'
        else:
            view = ModalView(size_hint=(None, None), size=(150, 100))
            btn = Button(text='Ошибка!')
            btn.bind(on_press=view.dismiss)
            view.add_widget(btn)
            view.open()

    def back(self):
        self.manager.current = 'main'

    def get_grid(self):
        try:
            return self.children[0].children[1]
        except Exception:
            return None

    def get_complete_button(self):
        return self.children[0].children[0]

    pass
