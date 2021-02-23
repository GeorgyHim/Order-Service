import json
import socket

host = ''
port = ''
app_name = 'OrderService'
login = ''
id_order = 1
f = 1


def request_server(data):
    try:
        print(data)
        msg = json.dumps(data)
        sock = socket.socket()
        sock.settimeout(2)
        sock.connect((host, port))
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
