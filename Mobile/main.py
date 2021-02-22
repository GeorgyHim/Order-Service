from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager
import plyer
from utils import app_name
import LoginPage
import MainPage
import OrderPage


class WindowManager(ScreenManager):
    pass


app = Builder.load_file("config.kv")


class OrderService(App):
    def build(self):
        plyer.notification.notify(title=app_name, message="Добро пожаловать")
        return app


OrderService().run()