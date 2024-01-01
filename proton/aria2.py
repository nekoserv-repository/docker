#!/usr/bin/env python3
import sys, urllib3, json, random


# init
url = sys.argv[1]
token = sys.argv[2]
port = sys.argv[3]


# send http request
def send_request(data):
  http = urllib3.PoolManager()
  r = http.request(method='POST', url=url, body=jsonreq)
  r.close()
  return r


# generate random id
def gen_id():
  return ''.join(chr(random.randrange(97, 97 + 25)) for x in range(13))


# update port
jsonreq = json.dumps({'jsonrpc': '2.0', 'id': gen_id(),
                      'method': 'aria2.changeGlobalOption',
                      'params': ['token:' + token, {'listen-port': port}]
                     })
r = send_request(jsonreq)
print(r.data)


# get new port
jsonreq = json.dumps({'jsonrpc': '2.0', 'id': gen_id(),
                      'method': 'aria2.getGlobalOption',
                      'params': ['token:' + token]
                     })
r = send_request(jsonreq)
json_result = json.loads(r.data)
print(json_result['result']['listen-port'])
