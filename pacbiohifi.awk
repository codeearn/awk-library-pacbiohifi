# Universitat Potsdam
# Author Gaurav Sablok
# Date 2024-3-14

use shift;
# adding rust support for spawn
use std::process:Command;
fn main(){
   Command::new("compile.c")
           .spawn()
           .expect("failed to execute command");
}

awksimulate () {

}

