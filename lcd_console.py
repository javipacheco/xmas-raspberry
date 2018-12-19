import time
import sys  

class lcd:

    interval = 2

    run = False

    def lcd_display_string(self, string, line):
        print line + " - " + string

    def getLines(self, messages):
        lines = [""]
        for message in reversed(messages):
            words = message['subject'].split(" ") 
            line = ""
            for word in words:
                newLine = ""
                if line:
                    newLine = line + " " + word
                else:
                    newLine = word

                if len(newLine) > 16:
                    lines.append(line)
                    line = word
                else:
                    line = newLine
            if line:
                lines.append(line)
            lines.append("----------------")
        return lines

    def lcd_display_messages(self, messages):
        self.run = True
        lines = self.getLines(messages)
        rounds = 0
        lineNumber = 0
        totalLines = len(lines)

        while self.run:
            sys.stdout.write("1 - %s                     \r" % (lines[lineNumber]))
            
            if lineNumber < totalLines - 1:
                sys.stdout.write("\n2 - %s               \r" % (lines[lineNumber + 1]))
            else:
                sys.stdout.write("\n2 -                  \r")

            sys.stdout.write("\x1b[A")
            sys.stdout.flush()

            time.sleep(self.interval)
            if lineNumber + 1 < totalLines:
                lineNumber = lineNumber + 1
            else:
                lineNumber = 0
                rounds = rounds + 1
                if rounds >= 20:
                    self.run = False

