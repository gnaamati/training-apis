import requests, sys
 
server = "http://rest.ensemblgenomes.org"
ext = "/lookup/id/AT3G52430?"
 
r = requests.get(server+ext, headers={ "Content-Type" : "application/json"})
 
if not r.ok:
  r.raise_for_status()
  sys.exit()
 
decoded = r.json()
print repr(decoded)
