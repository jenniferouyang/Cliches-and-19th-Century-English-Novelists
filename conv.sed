# Lowercase everything!
# remove punctuations? s/[,:;?!.-]//g
# number digits
# optional the/a/an

# unicode whitespace
s/\xc2\x91\|\xc2\x92\|\xc2\xa0\|\xe2\x80\x8e/ /;

# remove trailing material in parentheses/brackets
s/([^()]*)\s*$//g;  # original - remove anything after a parenthesis
#s/\([^()]*\)//g     # mine - remove the parenthese

# remaining parenthesized material becomes optional
s/( *\([^()]*\S\) *) */(?:\1 )?/g;  

# normalize punctuation
s/…/.../g;
s/’/'/g;
s/­/-/g;

# escape ? and .
s/?/ \\?/g;
s/!/ !/g;
s/\([^.]\)\./\1 ./g;
s/\./\\./g;
s/:/ :/g;
                                  
# recover short form - 's - two meanings, 'm, 're, 've, 'd
# is/am/are -> be
s/\bis\b/&\/am\/are\/was\/were\/been\/'s\/'m\/'re/g;
s/\bhave\b/&\/has\/had\/'ve/g;
s/\bshould\b/&\/would\/could\/'d\/must/g;
s/\bn't\b/&\/ not/g;
s/\bdo\b/&\/does\/did\/done/g;                            

# alternative pronouns
s/\bshe\b/&\/he\/it\/they\/you\/i/g;
s/\bher\b/&\/his\/its\/their\/theirs\/your\/yours\/mine\/me/g;
s/\bherself\b/&\/himself\/itself\/themself\/themselves\/yourself\/myself/g;          

# remaining alternatives: A/B => (?:A|B)
s/\( *\)\([-'\A-Za-z]\+\( *\/ *[-'A-Za-z]\+\)\+\)\( *\)/\1(?:\2)\4/g;
s/ *\/ */|/g;

# tokenize punctuation
s/\(\S\)\([,;"!]\)\(\S\)/\1 \2 \3/g;
s/\( [,;"]\)\(\S\)/\1 \2/g;
s/\(\S\)\([,;"!] \)/\1 \2/g;

# trim white space
s/\s+/ /g;

# remove empty lines
/^\s*$/d;
