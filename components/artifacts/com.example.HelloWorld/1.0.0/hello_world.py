import sys

message = "Hello, %s!" % sys.argv[1]
message += " Greetings from your first Greengrass component.222"

# Print the message to stdout, which Greengrass saves in a log file.
print(message)
