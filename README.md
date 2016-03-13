# This implements a config parser


it parses a default ini and builds
a table:

```nim

var config = configParser("./testconfig.ini")
echo config
echo config["LINUX"]["foo"]

```

##example config
```ini

  [LINUX]
  foo = baa
  iggi = buggy


  [TRULALA]
  tarli = asddfggaf
  fasd= 123
```

would be accessible as:
```nim
  echo config["LINUX"]["foo"]
```


##issues:

  * no write support (yet?)!  

  * if you have no section a default session is generated
    with the name ""
    so you would access default section with:

    ```nim  
        config[""]["keywithoutSection"]
    ```