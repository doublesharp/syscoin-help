## **`gettxoutproof`**

**`gettxoutproof ["txid",...] ( blockhash )`**

Returns a hex-encoded proof that "txid" was included in a block.

NOTE: By default this function only works sometimes. This is when there is an
unspent output in the utxo for this transaction. To make it always work,
you need to maintain a transaction index, using the -txindex command line option or
specify the block in which the transaction is included manually (by blockhash).

***Arguments:***
```
1. "txids"       (string) A json array of txids to filter
    [
      "txid"     (string) A transaction hash
      ,...
    ]
2. "blockhash"   (string, optional) If specified, looks for txid in the block with this hash

```

***Result:***
```
"data"           (string) A string that is a serialized, hex-encoded data for the proof.

```

***Examples:***
```
> syscoin-cli gettxoutproof '["mytxid",...]'
> syscoin-cli gettxoutproof '["mytxid",...]' "blockhash"
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxoutproof", "params": [["mytxid",...], "blockhash"] }' -H 'content-type: text/plain;' http://127.0.0.1:8236/
```
