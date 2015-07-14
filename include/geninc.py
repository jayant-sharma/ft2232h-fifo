import os, sys, glob

hdlpath = sys.argv[1]
incpath = hdlpath[:-4]+'include/'

#Search for Verilog files
list_hdl = [os.path.basename(x) for x in glob.glob(hdlpath+'*.v')]
list_v_inc  = [os.path.basename(x) for x in glob.glob(incpath+'*.v')]
list_vh_inc = [os.path.basename(x) for x in glob.glob(incpath+'*.vh')]
list_inc = list_v_inc + list_vh_inc

#Write include file
f = open(incpath+'incdef.vh', 'w')
INCFILE_DATA = []

for file in list_hdl:
   INCFILE_DATA.append( '`ifndef _' + file[:-2] + '_vh_' )
   INCFILE_DATA.append( '`define _' + file[:-2] + '_vh_' )
   INCFILE_DATA.append( '`include "../../hdl/' + file + '"' )
   INCFILE_DATA.append( '`endif //_' + file[:-2] + '_vh_\n')

for file in list_inc:
   if (file != 'incdef.vh'):
      INCFILE_DATA.append( '`ifndef _' + file[:-2] + '_vh_' )
      INCFILE_DATA.append( '`define _' + file[:-2] + '_vh_' )
      INCFILE_DATA.append( '`include "../../include/' + file + '"' )
      INCFILE_DATA.append( '`endif //_' + file[:-2] + '_vh_\n')

f.writelines(["%s\n" % item  for item in INCFILE_DATA])
f.close()
 