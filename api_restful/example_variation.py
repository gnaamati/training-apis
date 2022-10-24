import requests, sys
 
server = "http://rest.ensemblgenomes.org"
ext = "/variation/triticum_aestivum/BA00249348?genotypes=1"
 
r = requests.get(server+ext, headers={ "Content-Type" : "application/json"})
 
if not r.ok:
  r.raise_for_status()
  sys.exit()
 
decoded = r.json()
print repr(decoded)
