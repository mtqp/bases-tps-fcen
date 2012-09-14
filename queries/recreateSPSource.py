#coding=utf-8

import os
sqlfiles = []
for root, dirs, files in os.walk('./sps'):
  for file in files:
    if file.endswith('.sql'):
      sqlfiles.append(os.path.join(root, file))
      
sourceFile = open('./sps.sql', 'w')
sourceFile.write('-- Generado automaticamente\n\n')

for sqlFile in sqlfiles:
    sourceFile.write('source ' + sqlFile + ';\n')

sourceFile.close()


