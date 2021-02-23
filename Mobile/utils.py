import json
import socket

import plyer

from MainPage import MainPage

host = ''
port = ''
app_name = 'OrderService'
login = ''
id_order = 1
listen_working = False
sock = socket.socket()


def request_server(data):
    try:
        print(data)
        msg = json.dumps(data)
        sock.connect((host, port))
        sock.settimeout(2)
        sock.send(msg.encode('UTF-8'))
        answer = sock.recv(4096)
        return answer.replace(b'\x00', b'').decode('utf-8', 'ignore')
    except Exception:
        return json.dumps({'result': 'fail'})


def get_remote_settings():
    global host, port
    with open('config_remote.txt', 'r') as f:
        host_string = f.readline().split()
        host = host_string[1]

        port_string = f.readline().split()
        port = int(port_string[1])


def process_request(request):
    if request == 'mobile_take_order':
        plyer.notification.notify(title=app_name, message='У вас новые заказы!')
        MainPage.change()
