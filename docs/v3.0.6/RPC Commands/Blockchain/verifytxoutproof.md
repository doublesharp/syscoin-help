## **`verifytxoutproof`**

**`verifytxoutproof "proof"`**

Verifies that a proof points to a transaction in a block, returning the transaction it commits to
and throwing an RPC error if the block is not in our best chain

***Arguments:***
```
1. "proof"    (string, required) The hex-encoded proof generated by gettxoutproof

```

***Result:***
```
["txid"]      (array, strings) The txid(s) which the proof commits to, or empty array if the proof is invalid

```

***Examples:***
```
> syscoin-cli verifytxoutproof "proof"
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxoutproof", "params": ["proof"] }' -H 'content-type: text/plain;' http://127.0.0.1:8236/
```