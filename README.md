# This implements a config parser


it parses a default ini and builds
a table:

config["sectionname"]["value"]


##example config


  [LINUX]
  foo = baa
  iggi = buggy


  [TRULALA]
  tarli = asddfggaf
  fasd= 123


would be accessible as:
  echo config["LINUX"]["foo"]



##issues:

  if you have no section a default session is generated
  with the name ""

  so you would access default section with:
    config[""]["keywithoutSection"]
