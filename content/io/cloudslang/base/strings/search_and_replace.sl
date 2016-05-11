#   (c) Copyright 2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
##################################################
#!!
#! @description: Replaces a substring within a string.
#! @input origin_string: original string
#! @input text_to_replace: text to replace
#! @input replace_with: text to replace with
#! @output replaced_string: string with the text replaced
#! @output error_message: substirng not found
#! @result SUCCESS: parsing successful
#! @result FAILURE: something went wrong
#!!#
##################################################
namespace: io.cloudslang.base.strings

operation:
  name: search_and_replace
  inputs:
    - origin_string
    - text_to_replace
    - replace_with
  action:
    python_script: |
      try:
        error_message = ""
        if text_to_replace in origin_string:
          replaced_string = origin_string.replace(text_to_replace, replace_with)
        elif text_to_replace not in origin_string:
          error_message = "Substring not found"
        else:
          replaced_string = origin_string
      except Exception as e:
        error_message = e
  outputs:
    - replaced_string
    - error_message
  results:
    - SUCCESS: ${error_message == ""}
    - FAILURE
