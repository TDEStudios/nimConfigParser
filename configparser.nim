discard """
  This implements a config parser
  ===============================

  it parses a default ini and builds
  a table:

  config["sectionname"]["value"]


  example config
  -------

    [LINUX]
    foo = baa
    iggi = buggy


    [TRULALA]
    tarli = asddfggaf
    fasd= 123


  would be accessible as:
    echo config["LINUX"]["foo"]



  issues:
    if you have no section a default session is generated
    with the name ""

    so you would access default section with:
      config[""]["keywithoutSection"]

"""


import os, parsecfg, strutils, streams , tables

proc  configParser *(configPath: string): Table[system.string, Table[system.string, system.string]] =

  var config = initTable[string,Table[string,string] ]()
  var f = newFileStream(configPath, fmRead)

  if f != nil:
    var p: CfgParser
    var actuallySection : string = "" # "" because if you have no section

    config[""] = initTable[string, string]() # this is our empty default section

    open(p, f, configPath)

    while true:
      var e = next(p)
      case e.kind
      of cfgEof:
        break
      of cfgSectionStart:
        actuallySection = e.section
        config[e.section] = initTable[string, string]()
      of cfgKeyValuePair:
        config[actuallySection][e.key] = e.value
      of cfgOption:
        echo("command: " & e.key & ": " & e.value)
        echo("#########################")
        echo("Not handeld!")
        echo("#########################")
      of cfgError:
        echo(e.msg)
    close(p)
  else:
    raise newException(ValueError, "could not open config path: " & configPath)

  return config

when isMainModule :
  var config = configParser("./testconfig.ini")
  echo config
  echo config["LINUX"]["iggi"]
  echo config["TRULALA"]["tarli"]
