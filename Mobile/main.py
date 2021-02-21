from kivy.app import App
import socket
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen
import os.path
from kivy.clock import Clock
import json
from kivy.uix.modalview import ModalView
from time import sleep
from kivy.uix.gridlayout import GridLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.scrollview import ScrollView
from kivy.core.window import Window
from kivy.app import runTouchApp
import plyer
from threading import Thread


app_name = 'OrderService'
f = 1
log_name = ''
id_order = 1
host = ''
port = ''


def send_message(msg):
    try:
        print(msg)
        sock = socket.socket()
        sock.connect((host, port))

        sock.send(msg.encode('UTF-8'))

        data = sock.recv(4096)

        return data.replace(b'\x00',b'').decode('utf-8',"ignore")
    except Exception as e:

        return '{"result":"fail"}'


class LoginPage(Screen):

    def login(self, HOST, PORT, str):
        global host, port

        host, port = HOST, int(PORT)
        msg ='{"type":"login","login":"'+str+'"}'
        out = json.loads(send_message(msg))
        print(out)
        if out['result'] == 'true':
            f = open('login.txt', 'w')
            f.write(str+' '+HOST+' '+PORT)
            global log_name
            log_name = str
            f.close()
            Clock.schedule_once(self.change_screen)



    def on_enter(self):
        Clock.schedule_once(self.change_screen)

    def change_screen(self, *args):

        if os.path.isfile('login.txt'):
            with open('login.txt', 'r') as f:
                global log_name, host, port
                allinfo = f.read().split()
                log_name = allinfo[0]
                host = allinfo[1]
                port = int(allinfo[2])

            self.manager.current = 'main'
    pass


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


class MainPage(Screen):
    def notif(self):
        while (True):

            msg ='{"type":"notif","login":"'+log_name+'"}'
            out = json.loads(send_message(msg))
            if out['result'] == 'true':
                plyer.notification.notify(title=app_name, message="У вас новые заказы")
            sleep(30)

    def check_pull_refresh(self, args):

        if args.scroll_y > 1.03:
            self.change()
        #self.change()


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

        json_msg = json.loads(send_message(msg))

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


class WindowManager(ScreenManager):
    pass


kv = Builder.load_file("config.kv")

class OrderService(App):

    def build(self):
        plyer.notification.notify(title=app_name, message="Добро пожаловать")
        return kv


OrderService().run()
