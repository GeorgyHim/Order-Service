import socket

host = ''
port = ''
app_name = 'OrderService'
log_name = ''
id_order = 1


def request_server(msg):
    try:
        print(msg)
        sock = socket.socket()
        sock.settimeout(2)
        sock.connect((host, port))
        sock.send(msg.encode('UTF-8'))
        data = sock.recv(4096)
        return data.replace(b'\x00', b'').decode('utf-8', 'ignore')
    except Exception:
        return '{"result":"fail"}'


def get_remote_settings():
    global host, port
    with open('config_remote.txt', 'r') as f:
        host_string = f.readline().split()
        host = host_string[1]

        port_string = f.readline().split()
        port = int(port_string[1])
