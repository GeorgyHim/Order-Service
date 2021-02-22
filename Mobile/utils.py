import socket


def send_message(msg):
    try:
        print(msg)
        sock = socket.socket()
        sock.connect((host, port))
        sock.send(msg.encode('UTF-8'))
        data = sock.recv(4096)
        return data.replace(b'\x00', b'').decode('utf-8', 'ignore')
    except Exception:
        return '{"result":"fail"}'


host = ''
port = ''
app_name = 'OrderService'
log_name = ''
id_order = 1