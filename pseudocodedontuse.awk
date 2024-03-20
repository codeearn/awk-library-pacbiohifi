# draft pseudo code
# filtering the paf file according to the mention alignment score criteria (making this iteration shorter by adding a intermediate arrays which is borrowing the memory)
cat alignment.paf | awk '{ print $10"\t"$11"\t"$12"\t"$13' } ' | awk ' { print $1 } ' \
    awk {
      BEGIN
       for(i=0, i<NF; i++)
      END
    }

# string import 
function fold(str, sep, cols,    out, cmd, i, len, chars, c, last, f, first) {
  if (!cols) {
    # checks if stdout is a tty
    if (system("test -t 1")) {
      cols = 80;
    } else {
      cmd = "tput cols";
      cmd | getline cols;
      close(cmd);
    }
  }

  # squeeze tabs and newlines to spaces
  gsub(/[\t\n]/, " ", str);

  # if "sep" is empty, just fold on cols with substr
  if (!length(sep)) {
    len = length(str);

    out = substr(str, 1, cols);
    for (i=cols+1; i<=len; i+=cols) {
      out = out "\n" substr(str, i, cols);
    }

    return out;


use shift;
# adding rust support for spawn
use std::process:Command;
fn main(){
   Command::new("awkcompile")
# add the native cross compile function here which will invoke and compile the corresponding function. 
           .spawn()
           .expect("failed to execute command");
}
