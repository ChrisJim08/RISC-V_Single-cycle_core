.text
.global strlen
strlen:
    # a0 = const char *str
    li     t0, 0         # i = 0
loop: # Start of for loop
    add    t1, t0, a0    # Add the byte offset for str[i]
    lb     t1, 0(t1)     # Dereference str[i]
    beqz   t1, done        # if str[i] == 0, break for loop
    addi   t0, t0, 1     # Add 1 to our iterator
    j      loop            # Jump back to condition (1 backwards)
done: # End of for loop
    mv     a0, t0        # Move t0 into a0 to return
    ret                  # Return back via the return address register