# we can't set breakpoints for .so's we haven't loaded yet without this
set breakpoint pending on

# can often get away with typing: pv or pvis, etc.
define pvisit
  p visitor->Id().Key()._M_dataplus._M_p
end

# print C++ standard strings
define pcppstr
 p *(char**)($arg0)._M_dataplus._M_p
end

# 1
break main

# 2
break XSecSplineList.cxx:216 if i>0
commands 2
printf "i = %d; E[%d] = %f; xsec[%d] = %g\n", i, i-1, E[i-1], i-1, xsec[i-1]
end

# 3
break GEVGDriver.cxx:688

# 4
break gMakeSplines.cxx:166

# 5
# watch the loop through event record visitors!
# top of the loop. `p visitor->Id().Key()` (pvis above)
# check the processor and see if you want to step in
break EventGenerator.cxx:107 if ffwd==false
commands 5
pvisit
end
                          
# 6 actual call to ProcessEventRecord(event_rec)
break EventGenerator.cxx:118 if ffwd==false

# 7
break GEVGDriver.cxx:267

# 8
break GEVGDriver.cxx:226

# 9
break GEVGDriver.cxx:220

# 10
break GSLXSecFunc.cxx:218

# 11
break COHXSec.cxx:65

# 12
break QPMDISPXSec.cxx:79
