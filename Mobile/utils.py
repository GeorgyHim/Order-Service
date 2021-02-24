import json
import socket

host = ''
port = ''
app_name = 'OrderService'
login = ''
order_id = 1
update_working = False
need_connect = True
flag_connect_fail = False
sock = socket.socket()


def request_server(data):
    global sock
    try:
        print(data)
        msg = json.dumps(data)
        if need_connect:
            sock = socket.socket()
            sock.connect((host, port))
        sock.settimeout(20)
        sock.send(msg.encode('UTF-8'))
        answer = sock.recv(4096)
        print(answer)
        return json.loads(answer.replace(b'\x00', b'').decode('utf-8', 'ignore'))
    except Exception as e:
        return {'result': 'fail'}


def get_remote_settings():
    global host, port
    with open('config_remote.txt', 'r') as f:
        host_string = f.readline().split()
        host = host_string[1]

        port_string = f.readline().split()
        port = int(port_string[1])

