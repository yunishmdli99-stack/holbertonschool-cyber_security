#!/bin/bash
dig A MX TXT NS SOA $1 @8.8.8.8 +noall +answer
