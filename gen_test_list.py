import sys

if len(sys.argv) > 1:
    execName=sys.argv[1]
else:
    execName=''
prefix=''
for line in sys.stdin:
    if len(line) > 0:
        if line[0] != ' ':
            prefix=line 
            prefixList = prefix.split("/")
            prefix = prefixList[0]
            for ndx in range(1,len(prefixList)):
                prefix=prefix+'__'+prefixList[ndx]
        else:
            suffix = line.split()
            if suffix[0].find('DISABLED_') < 0:
                suffixList = suffix[0].split("/")
                if len(suffixList) >1:
                    final = prefix[:-1]+suffixList[0]
                    for ndx in range(1,len(suffixList)):
                        final = final + '__'+suffixList[ndx]
                    print execName+final
                else:
                    print execName+prefix[:-1]+suffix[0]
