# Networking 101

## Open two windows

Server:
```bash
$ make run.bash
```

Client:
```bash
$ make exec.bash
```

## Stream Sockets

### UNIX

Server:
```bash
$ echo PONG | nc -Uvl server.sock

Bound on server.sock
Listening on server.sock
```

Client:
```bash
$ echo PING | nc -Uv server.sock

PONG
```

### TCP

Server:
```bash
$ echo PONG | nc -lvkN 3000

Listening on 0.0.0.0 3000
```

Client:
```bash
$ echo PING | nc -v localhost 3000

Connection to localhost (127.0.0.1) 3000 port [tcp/*] succeeded!
PONG
```

### HTTP (over TCP)

Server:
```bash
$ echo -e 'HTTP/1.1 200\r\nContent-Type: application/text\r\n\r\nPONG' | nc -lvkN 3000

Listening on 0.0.0.0 3000
```

Client:
```bash
$ curl http://localhost:3000/ -d PING

PONG
```

## Running a complete web server (simple homepage, login and logout)

Server:
```bash
$ bash http/005-login/server

Listening on 3000...
```

### HTTP client using a web browser
Open your preferred web browser at `http://localhost:3000`.

### HTTP client using cURL

Accessing the homepage:
```html
$ curl http://localhost:3000/

<form method="POST" action="/login">
  <input type="text" name="name" />
  <input type="submit" value="Login" />
</form>
```

Performing the login:
```bash
$ curl -vi -X POST http://localhost:3000/login -d 'name=Leandro'

HTTP/1.1 301
Location: http://localhost:3000/
Set-Cookie: name=Leandro; path=/; HttpOnly
```

Accessing the homepage again but using the provided cookie:
```html
$ curl -H 'Cookie: name=Leandro' http://localhost:3000/

<p>Hello, leandro</p>
<form method="POST" action="/logout">
  <input type="submit" value="Logout" />
</form>
```

Performing the logout using the provided cookie:
```bash
$ curl -vi -X POST -H 'Cookie: name=leandro' http://localhost:3000/logout

HTTP/1.1 301
Location: http://localhost:3000/
Set-Cookie: name=leandro; path=/; HttpOnly; Expires=Thu, 01 Jan 1970 00:00:00 GMT
```

### HTTP client using a bash script with file descriptor

Login:
```bash
$ bash http/005-login/client

HTTP1.1 200
Content-Type: application/text

Login (type your name):
Leandro
```

Menu:
```bash
Leandro
HTTP/1.1 301
Location: http://localhost:3000/
Set-Cookie: name=Leandro; path=/; HttpOnly
HTTP/1.1 200
Content-Type: application/text

Hello, Leandro
Deseja fazer logout? (s/n/q):
```

Enjoy!
