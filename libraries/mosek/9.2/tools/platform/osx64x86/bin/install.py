#!/usr/bin/env python
import sys,os.path,subprocess

base = os.path.abspath(os.path.dirname(__file__))

binaries = [
    'MOSEKLM',
    'libcilkrts.5.dylib',
    'libmosek64.9.2.dylib',
    'libmosek64.dylib',
    'libmosekjava9_2.jnilib',
    'libmosekxx9_2.dylib',
    'lmgrd',
    'lmutil',
    'mampl',
    'mosek',
    'moseksi',
    'msktestlic',
    '../../../../toolbox/r2015a/mosekopt.mexmaci64',
    '../../../../toolbox/r2015aom/mosekopt.mexmaci64',
]


fixlibs = [ 'libmosek64','libcilkrts' ]

errors = False

print("Fixing library paths")
for fname in binaries:
    fullname = os.path.join(base,fname)
    print("  %s:" % fname)
    try:
        text = subprocess.check_output(['otool','-L',fullname]).decode()
        for l in text.splitlines():
            p = l.find('(')
            if p > 0:
                libname = l[:p].strip()
                libbase = os.path.basename(libname)

                while True:
                    libbase,ext = os.path.splitext(libbase)
                    if not ext:
                        break
                if libbase in fixlibs:
                    abslibpath = os.path.join(base,os.path.basename(libname))
                    if abslibpath != libname:
                        print('    %s -> %s' % (libname,abslibpath))
                        with open('/dev/null','wb') as devnull:
                            subprocess.call(['install_name_tool','-change',libname,abslibpath,fullname],stdout=devnull)
    except:
        errors = True
        print('    ERROR')
        import traceback
        traceback.print_exc()

if not errors:
    print("Install successfully completed.")
else:
    print("Incomplete install with errors. Some parts of MOSEK may not work. Consider saving the above output in case you need to report the issue.")
