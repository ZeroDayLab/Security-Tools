To compile gcc -o remove_newlines remove_newlines.c

Example output:

test@localhost /tmp $ ls  
remove_lines  remove_lines.c  
test@localhost /tmp $ echo -e 'test_object \n' |./remove_lines  
test_object test@localhost /tmp $ echo -e 'test_object \n'  
test_object  
  
test@localhost /tmp $ echo -e 'test_object \r'  
test_object
test@localhost /tmp $ echo -e 'test_object \r' |./remove_lines
test_object test@localhost /tmp $ 
