#!/bin/bash
dig ANY $1 @8.8.8.8 +noall +answer +authority
