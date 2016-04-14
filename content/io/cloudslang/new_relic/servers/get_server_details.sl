#   (c) Copyright 2016 Hewlett Packard Enterprise Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#!!
#! @description: Retrieves a single Server, identified by ID. The time range for summary data is the last 10 minutes.
#! @input endpoint: the New Relic servers API endpoint
#! @input api_key: the New Relic REST API key
#! @input server_id: the server id
#! @input proxy_host: optional - proxy server used to access web site
#! @input proxy_port: optional - proxy server port
#! @input proxy_username: optional - username used when connecting to proxy
#! @input proxy_password: optional - proxy server password associated with <proxy_username> input value
#! @output return_result: response of operation
#! @output status_code: normal status code is '200'
#! @output return_code: if return_code == -1 then there was an error
#! @output error_message: return_result if return_code ==: 1 or status_code != '200'
#! @result SUCCESS: operation succeeded (return_code != '-1' and status_code == '200')
#! @result FAILURE: otherwise
#!!#
####################################################

namespace: io.cloudslang.new_relic.servers

imports:
  rest: io.cloudslang.base.network.rest

flow:
  name: get_server_details
  inputs:
    - servers_endpoint:
        default: "https://api.newrelic.com/v2/servers"
        required: false
    - api_key:
        required: true
    - server_id:
        required: true
    - proxy_host:
        default: "proxy.houston.hp.com"
        required: false
    - proxy_port:
        default: "8080"
        required: false
    - proxy_username:
        required: false
    - proxy_password:
        required: false
    - query_params:
        default:
        required: false

  workflow:
    - list_servers:
        do:
          rest.http_client_get:
            - url: ${servers_endpoint + '/' + server_id + '.json'}
            - proxy_host
            - proxy_port
            - headers: ${'X-Api-Key:' + api_key}
            - content_type: "application/json"

        publish:
          - return_result
          - error_message
          - return_code
          - status_code

  outputs:
    - return_result
    - error_message
    - return_code
    - status_code