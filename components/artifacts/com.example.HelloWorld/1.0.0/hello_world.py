import sys

message = "Hello, %s!" % sys.argv[1]
message += " Greetings from your first Greengrass component.555"

# Print the message to stdout, which Greengrass saves in a log file.
print(message)
