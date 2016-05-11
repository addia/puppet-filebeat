# Land Registry's Filebeat Install

A puppet module to manage the Elasticsearch filebeat install

## Requirements

* Puppet  >=  3.4
* The [stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) Puppet library.

## Usage

### Main class

```
class ( 'filebeat' )

This puppet module installs and configures a Lightweight Shipper for all Log Data.
The install should happen at initial server installs.
Additionally required log shipping has to be configured in the relevant Service or Application module.
Each additional prospector has its own config file. These configs live in a sub-directory called /etc/filebeat/filebeat.d/ . 
An example <name>-prospector.yml.erb is below. ( oh and watch the spacing!!! )
```

### Prospectors

```
filebeat:
  # List of prospectors to fetch data - each ' - '  is a new prospectors for a log file or a group
  prospectors:
    -
      paths:
	    - <% @paths %>

      input_type: log

      ignore_older: 24h

      document_type: syslog


  spool_size: 1024

  idle_timeout: 5s

output:

shipper:

logging:


# vim: set ts=2 sw=2 et :
```

### Creating a Certificate for log transport

```

Make a copy of the RedHat provided openssl.cnf.
Modify the followin parts of the copied openssl.cnf as below:
IP.1 has to be the server where filebeat is running
IP.2 has to be the server where the logstash receiver is running
Do not touch the DNs lines.

edit ./openssl.cnf
x509_extensions               = v3_req

[req_distinguished_name]
C = UK
ST = England
L = Plymouth
O = digital.landregistry.gov.uk
CN = *

[v3_req]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:TRUE
subjectAltName = @alt_names
 
[alt_names]
DNS.1 = *
DNS.2 = *.*
DNS.3 = *.*.*
DNS.4 = *.*.*.*
DNS.5 = *.*.*.*.*
DNS.6 = *.*.*.*.*.*
DNS.7 = *.*.*.*.*.*.*
IP.1 = 192.168.249.8
IP.2 = 192.168.249.56


Then execute this to create the region specific certificate:
openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout private/logstash-beats.key -out certs/logstash-beats.crt -config ./openssl.cnf -days 3650

```

### License

Please see the [LICENSE](https://github.com/LandRegistry-Ops/puppet-filebeat/blob/master/LICENSE.md) file.

