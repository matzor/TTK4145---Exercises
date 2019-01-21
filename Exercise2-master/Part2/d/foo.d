import std.stdio;
import std.concurrency;


struct Finished {}

void increment(Tid parentId){
  Finished finished;
  foreach (j; 0 .. 1000000){
    parentId.send(1);
  }
  parentId.send(finished);
}

void decrement(Tid parentId){
  Finished finished;
  foreach (j; 0 .. 1000001){
    parentId.send(-1);
  }
  parentId.send(finished);
}

void numServ(Tid parentId){
  int i = 0;
  int finished = 0;
  while(finished < 2){
    //try
    receive(
        (int m) {
          //writeln("Recieved ", m);
          i+=m;
        },
        (Finished f){
          writeln("Finished one thread");
          finished += 1;
        }
      );
    }
  writeln("Magic number: ", i);
  Finished f;
  parentId.send(f);
}

void main(){

  auto numberServer = spawn(&numServ, thisTid);
  auto incrementingThread = spawn(&increment, numberServer);
  auto decrementingThread = spawn(&decrement, numberServer);

  Finished f;
  receive(
    (Finished f){
      writeln("FINISHED!");
    }
  );
}
