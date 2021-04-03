#!/usr/bin/python3

# called from hardify
# py3process kwords aliases funcs bintoks

import sys, getopt

def main(argv):


   arg_kwords = argv[0]
   arg_aliases = argv[1]
   arg_funcs = argv[2]
   arg_bintoks = argv[3]
#   try:
#      args = getopt.getopt(argv,"",["arg_kwords=","arg_aliases=","arg_funcs=","arg_bintoks="])
#   except getopt.GetoptError:
#      print ('py3process.py <keywords_file> <aliases_file> <funcs_file> <binfiles_file>')
#      sys.exit(2)

   f = open( arg_kwords, 'r+' )
   kwords = f.read()

   f = open( arg_aliases, 'r+' )
   aliases = f.read()

   f = open( arg_funcs, 'r+' )
   funcs = f.read()

   kwords += " is and cat grep the The " 

   bintoks = open(arg_bintoks, 'r')
   count = 0

   while True:
      count += 1

      line = bintoks.readline()
      if not line:		# EOF
         break
      toks  =  line.split()
      proc = toks[0]		# first token is function or alias name
      if proc.find(".py") > 0:      # ignore python scripts
         continue
      for tok in toks[1:]:
         if len(tok) == 1:
            continue
         if tok.isnumeric():	# our cheap bash tokenizing leaves numbers and keywords so ignore
            continue
         if kwords.find(tok) > 0:
            continue
         if aliases.find(tok) > 0:
            print (proc + ": " + tok, "is found in .bashrc" )
         if funcs.find(tok) > 0:
            print (proc + ": " + tok, "is found in .bash_funcs" )

if __name__ == "__main__":
   main(sys.argv[1:])


