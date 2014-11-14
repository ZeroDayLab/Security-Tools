To compile gcc -o remove_newlines remove_newlines.c

Example output:

test@localhost /tmp $ ls  
remove_lines  remove_lines.c  
test@localhost /tmp $ echo -e test target \n |./remove_lines  
test target test@localhost /tmp $ echo -e "test target \n"  
test target  
  
test@localhost /tmp $ echo -e test target \r  
geen idee 
test@localhost /tmp $ echo -e test target \r |./remove_lines
geen idee test@localhost /tmp $ 
