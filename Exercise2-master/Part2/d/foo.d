import std.stdio;
import std.concurrency;

struct Finished {}

void increment(Tid parentId){
  foreach (j; 0 .. 1000000){
    parentId.send(1);
  }
  Finished finished;
  parentId.send(finished);
}

void decrement(Tid parentId){
  foreach (j; 0 .. 1000001){
    parentId.send(-1);
  }
  Finished finished;
  parentId.send(finished);
}

void numServ(Tid parentId){
  int i = 0;
  int finished = 0;
  while(finished < 2){
    receive(
        (int m) {
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
  //Spawn threads
  auto numberServer = spawn(&numServ, thisTid); //Parent thread is main thread
  auto incrementingThread = spawn(&increment, numberServer); //Parent is numberServer
  auto decrementingThread = spawn(&decrement, numberServer);

  //Wait for last thread to finish
  receive(
    (Finished f){
      writeln("FINISHED!");
    }
  );
}
