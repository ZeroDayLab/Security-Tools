To compile gcc -o remove_newlines remove_newlines.c

Example output:

test@localhost /tmp $ ls
remove_lines  remove_lines.c
test@localhost /tmp $ echo -e "geen idee \n" |./remove_lines
geen idee test@localhost /tmp $ echo -e "geen idee \n"
geen idee
 
test@localhost /tmp $ echo -e "geen idee \r"
geen idee 
test@localhost /tmp $ echo -e "geen idee \r" |./remove_lines
     geen idee test@localhost /tmp $ 
